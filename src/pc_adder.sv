//====================================================
// PC Adder - Calcula la siguiente dirección del PC
//====================================================
module pc_adder (
    input  logic [31:0] pc_current,   // PC actual
    output logic [31:0] pc_next       // PC siguiente (pc + 4)
);

    assign pc_next = pc_current + 32'd4;

endmodule
