`timescale 1ns / 1ps
module data_mem_tb;

    logic clk;
    logic MemWrite, MemRead;
    logic [31:0] addr;
    logic [31:0] write_data;
    logic [31:0] read_data;

    data_mem uut (
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Reloj
    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/waves.vcd");
        $dumpvars(0, data_mem_tb);

        clk = 0;
        MemWrite = 0;
        MemRead  = 0;
        addr = 0;
        write_data = 0;

        // 1️⃣ Leer la posición 0 inicializada
        MemRead = 1; addr = 0; #10;

        // 2️⃣ Escribir 1234 en la posición 4
        MemRead = 0;
        MemWrite = 1;
        addr = 4;
        write_data = 32'd1234;
        #10;

        // 3️⃣ Leer ahora la posición 4
        MemWrite = 0;
        MemRead = 1;
        addr = 4;
        #10;
        $display("data = %d", read_data);

        // 4️⃣ Leer posición 8 (si existe en data.mem)
        addr = 8; #10;

        $finish;
    end

endmodule
