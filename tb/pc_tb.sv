`timescale 1ns / 1ps
module pc_tb;

    logic clk;
    logic reset;
    logic [31:0] pc_next;
    logic [31:0] pc_current;

    // Instancia del módulo PC
    pc uut (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc_current(pc_current)
    );

    // Generar reloj (periodo = 10ns)
    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, pc_tb);

        clk = 0;
        reset = 1; pc_next = 0; #10;   // Reset activo
        reset = 0; pc_next = 32'd4; #10;  // Avanza a 4
        pc_next = 32'd8; #10;              // Avanza a 8
        pc_next = 32'd12; #10;             // Avanza a 12
        pc_next = 32'd16; #10;             // Avanza a 16
        reset = 1; #10;                    // Reset nuevamente

        $display("Simulación terminada correctamente");
        $finish;
    end

endmodule
