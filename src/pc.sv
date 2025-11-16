//====================================================
// Program Counter (PC) - RISC-V RV32I
//====================================================
module pc (
    input  logic clk,              // Señal de reloj
    input  logic reset,            // Reset síncrono o asíncrono (según diseño)
    input  logic [31:0] pc_next,   // Nueva dirección a cargar
    output logic [31:0] pc_current // Dirección actual
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            pc_current <= 32'b0;        // Reinicia el PC a 0
        else
            pc_current <= pc_next;      // Actualiza el PC con la siguiente dirección
    end

endmodule
