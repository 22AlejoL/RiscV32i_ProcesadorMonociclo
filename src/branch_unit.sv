//====================================================
// Branch Unit - RISC-V RV32I
//====================================================
module branch_unit (
    input  logic       branch,          // Señal desde Control Unit (1 si es instrucción branch)
    input  logic [2:0] funct3,          // Campo funct3 para saber tipo de branch
    input  logic [31:0] rs1_value,      // Valor del registro rs1
    input  logic [31:0] rs2_value,     // Valor del registro rs2
    input  logic [31:0] pc_current,     // PC actual
    input  logic [31:0] imm,            // Inmediato generado (offset del salto)
    output logic        take_branch,     // 1 si se toma el branch
    output logic [31:0] branch_target    // pc + imm
);

    always_comb begin
        // Valor por defecto
        take_branch = 0;

        if (branch) begin
            case (funct3)
                3'b000: take_branch = (rs1_value == rs2_value);               // BEQ
                3'b001: take_branch = (rs1_value != rs2_value);               // BNE
                3'b100: take_branch = ($signed(rs1_value) < $signed(rs2_value));   // BLT
                3'b101: take_branch = ($signed(rs1_value) >= $signed(rs2_value));  // BGE
                default: take_branch = 0;
            endcase
        end
    end

    // Dirección objetivo del salto
    assign branch_target = pc_current + imm;

endmodule
