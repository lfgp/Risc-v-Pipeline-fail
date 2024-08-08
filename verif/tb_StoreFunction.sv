`timescale 1ns / 1ps

module tb_StoreFunction;

    // Declaração dos sinais
    logic clk;
    logic MemWrite;
    logic [31:0] addr;
    logic [31:0] write_data;
    logic [2:0] funct3;

    // Instância do módulo StoreFunction
    StoreFunction store_inst (
        .clk(clk),
        .MemWrite(MemWrite),
        .addr(addr),
        .write_data(write_data),
        .funct3(funct3)
    );

    // Geração do clock
    always #5 clk = ~clk;

    initial begin
        // Inicialização dos sinais
        clk = 0;
        MemWrite = 0;
        addr = 32'b0;
        write_data = 32'b0;
        funct3 = 3'b000; // Inicialmente para SB

        // Teste para SB
        MemWrite = 1;
        addr = 32'h0000_0000; // Endereço de teste
        write_data = 32'hFF00_0000; // Dados para o teste
        funct3 = 3'b000; // SB
        #10;
        $display("SB Test: Addr = %h, Data = %h", addr, write_data);

        // Teste para SH
        funct3 = 3'b001; // SH
        write_data = 32'hFFFF_0000; // Dados para o teste
        #10;
        $display("SH Test: Addr = %h, Data = %h", addr, write_data);

        $finish;
    end

endmodule

