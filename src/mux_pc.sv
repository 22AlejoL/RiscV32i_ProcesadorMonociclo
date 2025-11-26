//====================================================
// MUX del PC (selección del próximo PC)
//====================================================

module mux_pc (
    input  logic [31:0] pc_plus4,
    input  logic [31:0] branch_target,
    input  logic [31:0] jump_target,
    input  logic [1:0]  PCSrc,        // Señal desde Control Unit
    output logic [31:0] next_pc      // Próxima dirección de PC
);

    always_comb begin
        case (PCSrc)
            2'b00: next_pc = pc_plus4;       // Normal
            2'b01: next_pc = branch_target;  // Branch
            2'b10: next_pc = jump_target;    // Jump (JAL/JALR)
            default: next_pc = pc_plus4;
        endcase
    end

endmodule
