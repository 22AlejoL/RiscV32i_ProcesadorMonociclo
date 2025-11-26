//====================================================
// MUX Write-Back (WB) para el Register File
// Selecciona entre: ALU, Mem, PC+4
//====================================================

module mux_wb (
    input  logic [31:0] alu_result,   // Desde la ALU
    input  logic [31:0] mem_data,     // Desde la memoria de datos (LW)
    input  logic [31:0] pc_plus4,     // PC + 4 (JAL, JALR)
    input  logic [1:0]  MemToReg,     // Señal desde Control Unit
    output logic [31:0] wb_data       // Dato final hacia el regfile
);

    always_comb begin
        case (MemToReg)
            2'b00: wb_data = alu_result; // Operaciones normales
            2'b01: wb_data = mem_data;   // Load
            2'b10: wb_data = pc_plus4;   // JAL / JALR
            default: wb_data = alu_result;
        endcase
    end

endmodule
