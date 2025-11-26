`timescale 1ns/1ps
module alu_control_tb;

    logic [1:0] ALUOp;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [3:0] alu_ctrl;

    alu_control uut (
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        .alu_ctrl(alu_ctrl)
    );

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, alu_control_tb);

        // LOAD/STORE → ADD
        ALUOp = 2'b00; #10;

        // BRANCH → SUB
        ALUOp = 2'b01; #10;

        // R-type: ADD
        ALUOp = 2'b10; funct3 = 3'b000; funct7 = 7'b0000000; #10;

        // R-type: SUB
        funct7 = 7'b0100000; #10;

        // R-type: SRA
        funct3 = 3'b101; funct7 = 7'b0100000; #10;

        // R-type: SRL
        funct7 = 7'b0000000; #10;

        $finish;
    end

endmodule
