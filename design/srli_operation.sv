module srli_operation #(
    parameter DATA_WIDTH = 32,
    parameter OPCODE_LENGTH = 4
    ) (
    input logic [DATA_WIDTH-1:0]    SrcA,       // Registrador Rs1
    input logic [DATA_WIDTH-1:0]    Immediate,  // Valor imediato (número de posições de deslocamento)
    output logic [DATA_WIDTH-1:0]   Rd          // Registrador de destino
    );

    // Sinal de controle da ALU para a operação de Shift Right Logical
    logic [OPCODE_LENGTH-1:0] ALUControl;
    logic [DATA_WIDTH-1:0] ALUResult;  // Resultado da ALU

    // Configurando a ALU para realizar a operação SRL (Shift Right Logical)
    assign ALUControl = 4'b1010; // Código de controle para Shift Right Logical (SRL)

    // Instanciando a ALU
    alu #(
        .DATA_WIDTH(DATA_WIDTH),
        .OPCODE_LENGTH(OPCODE_LENGTH)
    ) alu_inst (
        .SrcA(SrcA),
        .SrcB(Immediate),
        .Operation(ALUControl),
        .ALUResult(ALUResult)
    );

    // O resultado da operação SRLI é armazenado no registrador de destino
    assign Rd = ALUResult;

endmodule

