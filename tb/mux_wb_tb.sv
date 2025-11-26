`timescale 1ns/1ps

module mux_wb_tb;

    logic [31:0] alu_result;
    logic [31:0] mem_data;
    logic [31:0] pc_plus4;
    logic [1:0]  MemToReg;
    logic [31:0] wb_data;

    mux_wb uut (
        .alu_result(alu_result),
        .mem_data(mem_data),
        .pc_plus4(pc_plus4),
        .MemToReg(MemToReg),
        .wb_data(wb_data)
    );

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, mux_wb_tb);

        // Inicializamos
        alu_result = 100;
        mem_data   = 555;
        pc_plus4   = 204;

        // Caso 00 -> ALU
        MemToReg = 2'b00; #10;

        // Caso 01 -> Memoria
        MemToReg = 2'b01; #10;

        // Caso 10 -> PC + 4
        MemToReg = 2'b10; #10;

        $finish;
    end

endmodule
