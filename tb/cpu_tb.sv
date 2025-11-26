`timescale 1ns/1ps
module cpu_tb;

    logic clk;
    logic reset;

    // Instantiate CPU
    cpu_top cpu (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns period
    end

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, cpu_tb);

        // Reset pulse
        reset = 1;
        #20;
        reset = 0;

        // Run for some cycles 
        #1000;

        $display("Simulación completa");
        $finish;
    end

endmodule
