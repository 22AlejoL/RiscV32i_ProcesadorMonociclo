//====================================================
// Instruction Memory - RISC-V RV32I
//====================================================
module instr_mem (
    input  logic [31:0] addr,        // Dirección (PC actual)
    output logic [31:0] instr        // Instrucción leída
);

    // Memoria de instrucciones (256 palabras de 32 bits)
    logic [31:0] memory [0:255];

    // Carga inicial de instrucciones desde un archivo externo
    initial begin
        $readmemh("src/program.hex", memory);
    end

    // Lectura de instrucción (dividir dirección entre 4)
    assign instr = memory[addr[9:2]];

endmodule
