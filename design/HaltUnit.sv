`timescale 1ns / 1ps

module HaltUnit (
    input logic [31:0] Instruction, // Instrução atual no pipeline
    input logic [31:0] PC, // Contador de Programa (PC)
    output logic Halt, // Sinal de Halt para parar a execução
    output logic [31:0] Halt_PC // PC que será exibido quando o processador estiver parado
);

    // Definir a instrução HALT (por exemplo, assumindo que HALT é 0xFFFF_FFFF)
    localparam [31:0] HALT_INSTRUCTION = 32'hFFFF_FFFF;

    // Verifica se a instrução atual é HALT
    assign Halt = (Instruction == HALT_INSTRUCTION);

    // O PC é exibido quando o processador está parado
    assign Halt_PC = (Halt) ? PC : 32'b0;

endmodule

