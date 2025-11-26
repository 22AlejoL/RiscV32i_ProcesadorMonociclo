//====================================================
// cpu_top.sv - Datapath monociclo RV32I     
//====================================================
module cpu_top (
    input  logic clk,
    input  logic reset
);

    // ---------- Wires / Regs ----------
    logic [31:0] pc_current, pc_next, pc_plus4;
    logic [31:0] instr;
    logic [6:0]  opcode;
    logic [4:0]  rd, rs1_idx, rs2_idx;
    logic [2:0]  funct3;
    logic [6:0]  funct7;

    // Register file
    logic [31:0] rs1_val, rs2_val;
    logic        RegWrite;
    logic        MemRead;
    logic        MemWrite;
    logic        ALUSrc;      // selects alu_b
    logic        MemToReg1;   // original 1-bit MemToReg from control_unit
    logic [1:0]  ALUOp;

    // Imm
    logic [31:0] imm;

    // ALU inputs/outputs
    logic [31:0] alu_a, alu_b, alu_result;
    logic [3:0]  alu_ctrl;

    // Branch unit
    logic        take_branch;
    logic [31:0] branch_target;

    // Jump detection
    logic is_jal, is_jalr;

    // Data memory
    logic [31:0] mem_read_data;

    // Write-back
    logic [31:0] wb_data;
    logic [1:0]  MemToReg; // extended: 00=ALU,01=MEM,10=PC+4

    // PC MUX ctrl
    logic [1:0] PCSrc;

    // ALUSrcA (select between rs1 and pc for alu_a) - for AUIPC
    logic ALUSrcA;

    // pc_adder output (pc + 4)
    // pc_adder module we wrote before outputs "pc_next", use as pc_plus4
    // instantiate modules below

    // ---------- Modules instantiation ----------

    // Program Counter
    pc u_pc (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc_current(pc_current)
    );

    // PC adder (pc + 4)
    pc_adder u_pc_adder (
        .pc_current(pc_current),
        .pc_next(pc_plus4)
    );

    // Instruction memory (reads instruction at pc_current)
    instr_mem u_imem (
        .addr(pc_current),
        .instr(instr)
    );

    // Decode fields
    assign opcode   = instr[6:0];
    assign rd       = instr[11:7];
    assign funct3   = instr[14:12];
    assign rs1_idx  = instr[19:15];
    assign rs2_idx  = instr[24:20];
    assign funct7   = instr[31:25];

    // Immediate generator
    immgen u_imm (
        .instr(instr),
        .imm_out(imm)
    );

    // Control unit (from opcode)
    control_unit u_ctrl (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg1),
        .Branch(/*ignored internal since we use Branch signal to branch_unit*/),
        .ALUOp(ALUOp)
    );
    // Note: If your control_unit module requires Branch output, adapt above line to capture it.
    // If it doesn't have MemToReg as single bit, adjust accordingly.

    // Register file (regunit)
    regunit u_regfile (
        .clk(clk),
        .we(RegWrite),
        .rs1(rs1_idx),
        .rs2(rs2_idx),
        .rd(rd),
        .wd(wb_data),
        .rd1(rs1_val),
        .rd2(rs2_val)
    );

    // ALU input A MUX (rs1 or pc_current) - ALUSrcA for AUIPC
    mux_alu_a u_mux_alu_a (
        .rs1(rs1_val),
        .pc_current(pc_current),
        .ALUSrcA(ALUSrcA),
        .alu_a(alu_a)
    );

    // ALU input B MUX (rs2 or imm)
    mux_alu_b u_mux_alu_b (
        .rs2(rs2_val),
        .imm(imm),
        .ALUSrc(ALUSrc),
        .alu_b(alu_b)
    );

    // ALU Control
    alu_control u_alu_ctrl (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .alu_ctrl(alu_ctrl)
    );

    // ALU
    alu u_alu (
        .a(alu_a),
        .b(alu_b),
        .alu_ctrl(alu_ctrl),
        .result(alu_result),
        .zero(/*optional*/)
    );

    // Branch unit
    branch_unit u_branch (
        .branch( /* use Branch detection from opcode */ (opcode == 7'b1100011) ), // branch-type opcode
        .funct3(funct3),
        .rs1_value(rs1_val),
        .rs2_value(rs2_val),
        .pc_current(pc_current),
        .imm(imm),
        .take_branch(take_branch),
        .branch_target(branch_target)
    );

    // Data memory
    data_mem u_dmem (
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .addr(alu_result),
        .write_data(rs2_val),
        .read_data(mem_read_data)
    );

    // Build jump targets
    logic [31:0] jump_target_jal;
    logic [31:0] jump_target_jalr;
    logic [31:0] jump_target;

    assign jump_target_jal  = pc_current + imm;
    assign jump_target_jalr = (rs1_val + imm) & ~32'b1; // JALR: clear LSB (ensure alignment)
    assign is_jal  = (opcode == 7'b1101111);
    assign is_jalr = (opcode == 7'b1100111);

    assign jump_target = is_jal ? jump_target_jal : jump_target_jalr;

    // PC source selection
    // Priority: branch (if taken) > jump (JAL/JALR) > pc+4
    always_comb begin
        if (take_branch)
            PCSrc = 2'b01;
        else if (is_jal || is_jalr)
            PCSrc = 2'b10;
        else
            PCSrc = 2'b00;
    end

    // Choose next PC
    mux_pc u_mux_pc (
        .pc_plus4(pc_plus4),
        .branch_target(branch_target),
        .jump_target(jump_target),
        .PCSrc(PCSrc),
        .next_pc(pc_next)
    );

    // MemToReg extension: if JAL/JALR -> select PC+4 (2'b10), else use MemToReg1 (0/1)
    always_comb begin
        if (is_jal || is_jalr)
            MemToReg = 2'b10;
        else if (MemToReg1)
            MemToReg = 2'b01;
        else
            MemToReg = 2'b00;
    end

    // ALUSrcA logic: use PC for AUIPC (opcode 0010111) -> AUIPC uses PC as operand A
    assign ALUSrcA = (opcode == 7'b0010111);

    // Write-back multiplexer
    mux_wb u_mux_wb (
        .alu_result(alu_result),
        .mem_data(mem_read_data),
        .pc_plus4(pc_plus4),
        .MemToReg(MemToReg),
        .wb_data(wb_data)
    );

endmodule
