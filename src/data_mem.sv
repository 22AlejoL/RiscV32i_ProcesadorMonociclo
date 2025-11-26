//====================================================
// Data Memory - RISC-V RV32I
//====================================================
module data_mem (
    input  logic        clk,
    input  logic        MemWrite,
    input  logic        MemRead,
    input  logic [31:0] addr,         // Dirección (word address)
    input  logic [31:0] write_data,   // Dato a escribir (SW)
    output logic [31:0] read_data     // Dato leído (LW)
);

    // Memoria de datos (256 palabras de 32 bits)
    logic [31:0] memory [0:255];

    // Inicializar memoria opcionalmente desde archivo
    initial begin
        $readmemh("src/data.mem", memory);
    end

    // Escritura sincrónica (solo SW)
    always_ff @(posedge clk) begin
        if (MemWrite)
            memory[addr[9:2]] <= write_data;  // word aligned
    end

    // Lectura combinacional (solo LW)
    always_comb begin
        if (MemRead)
            read_data = memory[addr[9:2]];
        else
            read_data = 32'b0;
    end

endmodule
