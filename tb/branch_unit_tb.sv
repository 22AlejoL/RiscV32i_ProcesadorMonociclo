`timescale 1ns / 1ps
module branch_unit_tb;

    logic branch;
    logic [2:0] funct3;
    logic [31:0] rs1_value, rs2_value;
    logic [31:0] pc_current, imm;
    logic take_branch;
    logic [31:0] branch_target;

    branch_unit uut (
        .branch(branch),
        .funct3(funct3),
        .rs1_value(rs1_value),
        .rs2_value(rs2_value),
        .pc_current(pc_current),
        .imm(imm),
        .take_branch(take_branch),
        .branch_target(branch_target)
    );

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, branch_unit_tb);

        pc_current = 100;
        imm = 16;

        // BEQ (true)
        branch = 1; funct3 = 3'b000;
        rs1_value = 5; rs2_value = 5; #10;

        // BEQ (false)
        rs1_value = 5; rs2_value = 8; #10;

        // BNE (true)
        funct3 = 3'b001;
        rs1_value = 3; rs2_value = 2; #10;

        // BLT (true)
        funct3 = 3'b100;
        rs1_value = -1; rs2_value = 5; #10;

        // BGE (false)
        funct3 = 3'b101;
        rs1_value = 3; rs2_value = 7; #10;

        $finish;
    end

endmodule
