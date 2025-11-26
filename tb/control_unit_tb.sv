`timescale 1ns / 1ps
module control_unit_tb;

    logic [6:0] opcode;
    logic RegWrite, ALUSrc, MemRead, MemWrite, MemToReg, Branch;
    logic [1:0] ALUOp;

    control_unit uut (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, control_unit_tb);

        opcode = 7'b0110011; #10; // R-type
        opcode = 7'b0010011; #10; // ADDI
        opcode = 7'b0000011; #10; // LW
        opcode = 7'b0100011; #10; // SW
        opcode = 7'b1100011; #10; // BEQ
        opcode = 7'b0110111; #10; // LUI
        opcode = 7'b1101111; #10; // JAL

        $finish;
    end

endmodule
