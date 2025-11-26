`timescale 1ns / 1ps
module immgen_tb;

    logic [31:0] instr;
    logic [31:0] imm_out;

    immgen uut (
        .instr(instr),
        .imm_out(imm_out)
    );

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, immgen_tb);

        // I-TYPE (ADDI x1, x0, 10)
        instr = 32'b00000000001000000000000100010011; #10;
        $display("I-type imm = %d", imm_out);

        // S-TYPE (sw x1, 8(x2))
        instr = 32'b00000000000100010010010000100011; #10;
        $display("S-type imm = %d", imm_out);

        // B-TYPE (beq x1, x2, -4)
        instr = 32'b11111110000100010000011011100011; #10;
        $display("B-type imm = %d", imm_out);

        // U-TYPE (lui x1, 0x12345)
        instr = 32'h12345037; #10;
        $display("U-type imm = %h", imm_out);

        // J-TYPE (jal x1, 16)
        instr = 32'b00000000000100000000000011101111; #10;
        $display("J-type imm = %d", imm_out);

        $finish;
    end

endmodule
