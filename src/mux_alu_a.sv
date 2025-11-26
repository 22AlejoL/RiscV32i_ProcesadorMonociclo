//====================================================
// MUX para la entrada A de la ALU
// Selecciona entre rs1 y pc_current
//====================================================

module mux_alu_a (
    input  logic [31:0] rs1,
    input  logic [31:0] pc_current,
    input  logic        ALUSrcA,   // 0 = rs1, 1 = PC
    output logic [31:0] alu_a
);

    assign alu_a = (ALUSrcA == 1'b1) ? pc_current : rs1;

endmodule
