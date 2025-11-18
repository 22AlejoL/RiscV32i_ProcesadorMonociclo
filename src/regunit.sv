//====================================================
// Register Unit - RISC-V RV32I
//====================================================
module regunit (
    input  logic        clk,       // Reloj
    input  logic        we,        // Write enable
    input  logic [4:0]  rs1,       // Registro fuente 1
    input  logic [4:0]  rs2,       // Registro fuente 2
    input  logic [4:0]  rd,        // Registro destino
    input  logic [31:0] wd,        // Dato a escribir
    output logic [31:0] rd1,       // Salida registro fuente 1
    output logic [31:0] rd2        // Salida registro fuente 2
);

    // 32 registros de 32 bits
    logic [31:0] registers [31:0];

    // Escritura sincronizada
    always_ff @(posedge clk) begin
        if (we && (rd != 0))
            registers[rd] <= wd; // Escribir sólo si no es x0
    end

    // Lecturas combinacionales
    assign rd1 = (rs1 == 0) ? 32'b0 : registers[rs1];
    assign rd2 = (rs2 == 0) ? 32'b0 : registers[rs2];

endmodule
