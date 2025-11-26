`timescale 1ns / 1ps
module instr_mem_tb;

    logic [31:0] addr;
    logic [31:0] instr;

    // Instancia de la memoria
    instr_mem uut (
        .addr(addr),
        .instr(instr)
    );

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, instr_mem_tb);

        // Dirección inicial
        addr = 0;  #10;
        $display("addr=%d -> instr=%h", addr, instr);

        addr = 4;  #10;
        $display("addr=%d -> instr=%h", addr, instr);

        addr = 8;  #10;
        $display("addr=%d -> instr=%h", addr, instr);

        addr = 12; #10;
        $display("addr=%d -> instr=%h", addr, instr);

        $finish;
    end

endmodule
