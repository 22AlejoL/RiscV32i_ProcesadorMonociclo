`timescale 1ns/1ps

module mux_pc_tb;

    logic [31:0] pc_plus4;
    logic [31:0] branch_target;
    logic [31:0] jump_target;
    logic [1:0]  PCSrc;
    logic [31:0] next_pc;

    mux_pc uut (
        .pc_plus4(pc_plus4),
        .branch_target(branch_target),
        .jump_target(jump_target),
        .PCSrc(PCSrc),
        .next_pc(next_pc)
    );

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, mux_pc_tb);

        pc_plus4      = 32'd100;
        branch_target = 32'd500;
        jump_target   = 32'd900;

        // Caso 00 → PC + 4
        PCSrc = 2'b00; #10;

        // Caso 01 → Branch target
        PCSrc = 2'b01; #10;

        // Caso 10 → Jump target
        PCSrc = 2'b10; #10;

        $finish;
    end

endmodule
