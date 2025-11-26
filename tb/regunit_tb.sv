`timescale 1ns / 1ps
module regunit_tb;

    logic clk;
    logic we;
    logic [4:0] rs1, rs2, rd;
    logic [31:0] wd;
    logic [31:0] rd1, rd2;

    regunit uut (
        .clk(clk),
        .we(we),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, regunit_tb);

        clk = 0;
        we = 0;
        rs1 = 0;
        rs2 = 0;
        rd = 0;
        wd = 0;

        // Escribir x1 = 10
        #5 we = 1; rd = 1; wd = 10; #10;

        // Escribir x2 = 20
        rd = 2; wd = 20; #10;

        // Leer
        we = 0; rs1 = 1; rs2 = 2; #10;
        $display("x1=%d x2=%d", rd1, rd2);

        // Intentar escribir en x0
        we = 1; rd = 0; wd = 999; #10;

        // Leer x0 = 0
        we = 0; rs1 = 0; #10;
        $display("x0=%d (esperado 0)", rd1);

        $finish;
    end

endmodule
