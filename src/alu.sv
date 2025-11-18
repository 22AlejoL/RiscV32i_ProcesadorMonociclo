//====================================================
// ALU - Unidad Aritmético Lógica para RISC-V RV32I
//====================================================
module alu (
    input  logic [31:0] a,         // Operando A
    input  logic [31:0] b,         // Operando B
    input  logic [3:0]  alu_ctrl,  // Señal de control
    output logic [31:0] result,    // Resultado
    output logic        zero       // Bandera: 1 si resultado = 0
);

    always_comb begin
        case (alu_ctrl)
            4'b0000: result = a + b;                       // ADD
            4'b0001: result = a - b;                       // SUB
            4'b0010: result = a & b;                       // AND
            4'b0011: result = a | b;                       // OR
            4'b0100: result = a ^ b;                       // XOR
            4'b0101: result = a << b[4:0];                 // SLL
            4'b0110: result = a >> b[4:0];                 // SRL
            4'b0111: result = $signed(a) >>> b[4:0];       // SRA
            4'b1000: result = ($signed(a) < $signed(b)) ? 1 : 0; // SLT
            default: result = 32'b0;
        endcase
    end

    assign zero = (result == 0);

endmodule
