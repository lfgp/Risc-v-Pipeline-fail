`timescale 1ns / 1ps

module tb_HaltUnit;

    // Declaração dos sinais
    logic [31:0] Instruction;
    logic [31:0] PC;
    logic Halt;
    logic [31:0] Halt_PC;

    // Instância do módulo HaltUnit
    HaltUnit halt_inst (
        .Instruction(Instruction),
        .PC(PC),
        .Halt(Halt),
        .Halt_PC(Halt_PC)
    );

    initial begin
        // Teste 1: Instrução HALT
        Instruction = 32'hFFFF_FFFF; // Instrução HALT
        PC = 32'h0000_1234; // Valor do PC de teste
        #10;
        assert (Halt == 1) else $fatal("Test 1 Failed: Expected Halt = 1");
        assert (Halt_PC == PC) else $fatal("Test 1 Failed: Expected Halt_PC = %h", PC);

        // Teste 2: Instrução diferente de HALT
        Instruction = 32'h0000_0000; // Instrução diferente de HALT
        PC = 32'h0000_5678; // Novo valor do PC de teste
        #10;
        assert (Halt == 0) else $fatal("Test 2 Failed: Expected Halt = 0");
        assert (Halt_PC == 32'b0) else $fatal("Test 2 Failed: Expected Halt_PC = 0");

        $finish;
    end

endmodule

