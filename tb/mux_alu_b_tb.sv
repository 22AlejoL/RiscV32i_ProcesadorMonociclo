`timescale 1ns/1ps

module mux_alu_b_tb;

    logic [31:0] rs2;
    logic [31:0] imm;
    logic        ALUSrc;
    logic [31:0] alu_b;

    mux_alu_b uut (
        .rs2(rs2),
        .imm(imm),
        .ALUSrc(ALUSrc),
        .alu_b(alu_b)
    );

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, mux_alu_b_tb);

        // Prueba 1: usar rs2
        rs2 = 32'd50;
        imm = 32'd999;
        ALUSrc = 0;
        #10;

        // Prueba 2: usar inmediato
        ALUSrc = 1;
        #10;

        // Prueba 3: otro valor
        imm = 32'd1234;
        #10;

        $finish;
    end

endmodule
