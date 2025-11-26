`timescale 1ns / 1ps
module alu_tb;

    logic [31:0] a, b;
    logic [3:0] alu_ctrl;
    logic [31:0] result;
    logic zero;

    // Instancia de la ALU
    alu uut (
        .a(a),
        .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .zero(zero)
    );

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, alu_tb);

        // Pruebas básicas
        a = 10; b = 5; alu_ctrl = 4'b0000; #10; // ADD
        $display("ADD: %d", result);

        a = 10; b = 5; alu_ctrl = 4'b0001; #10; // SUB
        $display("SUB: %d", result);

        a = 32'hA; b = 32'h3; alu_ctrl = 4'b0101; #10; // SLL
        $display("SLL: %h", result);

        a = 32'h10; b = 32'h2; alu_ctrl = 4'b0110; #10; // SRL
        $display("SRL: %h", result);

        a = 32'hFFFFFFFF; b = 32'h00000001; alu_ctrl = 4'b0111; #10; // SRA
        $display("SRA: %h", result);

        a = 32'd3; b = 32'd7; alu_ctrl = 4'b1000; #10; // SLT
        $display("SLT: %d", result);

        $finish;
    end
endmodule
