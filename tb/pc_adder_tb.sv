`timescale 1ns / 1ps
module pc_adder_tb;

    logic [31:0] pc_current;
    logic [31:0] pc_next;

    // Instancia del sumador
    pc_adder uut (
        .pc_current(pc_current),
        .pc_next(pc_next)
    );

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, pc_adder_tb);

        pc_current = 32'd0;  #10;
        $display("pc_current=%d -> pc_next=%d", pc_current, pc_next);

        pc_current = 32'd4;  #10;
        $display("pc_current=%d -> pc_next=%d", pc_current, pc_next);

        pc_current = 32'd8;  #10;
        $display("pc_current=%d -> pc_next=%d", pc_current, pc_next);

        pc_current = 32'd100; #10;
        $display("pc_current=%d -> pc_next=%d", pc_current, pc_next);

        $finish;
    end

endmodule
