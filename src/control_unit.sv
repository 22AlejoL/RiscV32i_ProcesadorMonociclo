//====================================================
// Control Unit - RISC-V RV32I
//====================================================
module control_unit (
    input  logic [6:0] opcode,    // 7-bit opcode from instruction
    output logic       RegWrite,
    output logic       ALUSrc,
    output logic       MemRead,
    output logic       MemWrite,
    output logic       MemToReg,
    output logic       Branch,
    output logic [1:0] ALUOp
);

    always_comb begin
        // Valores por defecto (evita latches)
        RegWrite = 0;
        ALUSrc   = 0;
        MemRead  = 0;
        MemWrite = 0;
        MemToReg = 0;
        Branch   = 0;
        ALUOp    = 2'b00;

        case (opcode)

            // R-TYPE (ADD, SUB...)
            7'b0110011: begin
                RegWrite = 1;
                ALUSrc   = 0;
                ALUOp    = 2'b10;
            end

            // I-TYPE (ADDI)
            7'b0010011: begin
                RegWrite = 1;
                ALUSrc   = 1;
                ALUOp    = 2'b00;
            end

            // LOAD (LW)
            7'b0000011: begin
                RegWrite = 1;
                ALUSrc   = 1;
                MemRead  = 1;
                MemToReg = 1;
                ALUOp    = 2'b00;
            end

            
            // STORE (SW)
            7'b0100011: begin
                ALUSrc   = 1;
                MemWrite = 1;
                ALUOp    = 2'b00;
            end

            // BRANCH (BEQ)
            7'b1100011: begin
                Branch   = 1;
                ALUSrc   = 0;
                ALUOp    = 2'b01;
            end

            // LUI / AUIPC / JAL
            7'b0110111, // LUI
            7'b0010111, // AUIPC
            7'b1101111: // JAL
            begin
                RegWrite = 1;
                ALUSrc   = 1;
                ALUOp    = 2'b11;
            end

            // JALR
            7'b1100111: begin
                RegWrite = 1;
                ALUSrc   = 1;
                ALUOp    = 2'b00;
            end

        endcase
    end

endmodule
