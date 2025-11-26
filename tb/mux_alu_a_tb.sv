`timescale 1ns/1ps

module mux_alu_a_tb;

    logic [31:0] rs1;
    logic [31:0] pc_current;
    logic        ALUSrcA;
    logic [31:0] alu_a;

    mux_alu_a uut (
        .rs1(rs1),
        .pc_current(pc_current),
        .ALUSrcA(ALUSrcA),
        .alu_a(alu_a)
    );

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, mux_alu_a_tb);

        // Valores iniciales
        rs1 = 32'd20;
        pc_current = 32'd100;

        // Prueba usando rs1
        ALUSrcA = 0;
        #10;

        // Prueba usando PC
        ALUSrcA = 1;
        #10;

        // Modificando valores
        pc_current = 32'd200;
        #10;

        $finish;
    end

endmodule
