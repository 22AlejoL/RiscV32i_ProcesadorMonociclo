//====================================================
// ALU Control - RISC-V RV32I
//====================================================
module alu_control (
    input  logic [1:0] ALUOp,         // Desde la Control Unit
    input  logic [2:0] funct3,        // Campo funct3
    input  logic [6:0] funct7,        // Campo funct7
    output logic [3:0] alu_ctrl       // Señal para ALU
);

    always_comb begin
        case (ALUOp)

            // 00 → LOAD/STORE → ADD
            2'b00: alu_ctrl = 4'b0000;   // ADD

            // 01 → BRANCH → SUB
            2'b01: alu_ctrl = 4'b0001;   // SUB

            // 10 → R-type
            2'b10: begin
                case (funct3)
                    3'b000: alu_ctrl = (funct7 == 7'b0100000) ? 4'b0001 : 4'b0000; // SUB : ADD
                    3'b111: alu_ctrl = 4'b0010;  // AND
                    3'b110: alu_ctrl = 4'b0011;  // OR
                    3'b100: alu_ctrl = 4'b0100;  // XOR
                    3'b001: alu_ctrl = 4'b0101;  // SLL
                    3'b101: alu_ctrl = (funct7 == 7'b0100000) ? 4'b0111 : 4'b0110; // SRA : SRL
                    3'b010: alu_ctrl = 4'b1000;  // SLT
                    default: alu_ctrl = 4'b0000;
                endcase
            end
 
            // 11 → I-type (ADDI, ANDI, ORI, XORI, SLTI, SLLI...)
            2'b11: begin
                case (funct3)
                    3'b000: alu_ctrl = 4'b0000; // ADDI
                    3'b111: alu_ctrl = 4'b0010; // ANDI
                    3'b110: alu_ctrl = 4'b0011; // ORI
                    3'b100: alu_ctrl = 4'b0100; // XORI
                    3'b010: alu_ctrl = 4'b1000; // SLTI
                    3'b001: alu_ctrl = 4'b0101; // SLLI
                    3'b101: alu_ctrl = (funct7 == 7'b0100000) ? 4'b0111 : 4'b0110; // SRAI : SRLI
                    default: alu_ctrl = 4'b0000;
                endcase
            end

            default: alu_ctrl = 4'b0000;

        endcase
    end

endmodule
