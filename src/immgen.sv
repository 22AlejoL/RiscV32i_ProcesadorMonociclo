//====================================================
// Immediate Generator - RISC-V RV32I
//====================================================
module immgen (
    input  logic [31:0] instr,        // Instrucción completa
    output logic [31:0] imm_out       // Inmediato generado
);

    logic [6:0] opcode;
    assign opcode = instr[6:0];

    always_comb begin
        case (opcode)

            // I-TYPE
            7'b0010011,   // ADDI
            7'b0000011,   // LW
            7'b1100111:   // JALR
                imm_out = {{20{instr[31]}}, instr[31:20]};

            // S-TYPE 
            7'b0100011:
                imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};

            // B-TYPE 
            7'b1100011:
                imm_out = {{19{instr[31]}},   // Sign extend
                           instr[31],          // bit 12
                           instr[7],           // bit 11
                           instr[30:25],       // bits 10:5
                           instr[11:8],        // bits 4:1
                           1'b0};              // Lowest bit is 0 (alignment)

            // U-TYPE 
            7'b0110111,   // LUI
            7'b0010111:   // AUIPC
                imm_out = {instr[31:12], 12'b0};

            // J-TYPE 
            7'b1101111:
                imm_out = {{11{instr[31]}},     // sign extend
                           instr[31],           // bit 20
                           instr[19:12],        // bits 19:12
                           instr[20],           // bit 11
                           instr[30:21],        // bits 10:1
                           1'b0};               // bit 0 = 0
            // DEFAULT
            default:
                imm_out = 32'b0;
        endcase
    end

endmodule
