//====================================================
// MUX para la entrada B de la ALU
// Selecciona entre rs2 y el inmediato
//====================================================

module mux_alu_b (
    input  logic [31:0] rs2,
    input  logic [31:0] imm,
    input  logic        ALUSrc,     // 1 = usa inmediato, 0 = usa rs2
    output logic [31:0] alu_b
);

    assign alu_b = (ALUSrc == 1'b1) ? imm : rs2;

endmodule
