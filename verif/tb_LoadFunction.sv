`timescale 1ns / 1ps

module tb_LoadFunction;

    // Declaração dos sinais
    logic clk;
    logic MemRead;
    logic [31:0] addr;
    logic [31:0] write_data;
    logic [2:0] funct3;
    logic [31:0] read_data;

    // Instância do módulo LoadFunction
    LoadFunction load_inst (
        .clk(clk),
        .MemRead(MemRead),
        .addr(addr),
        .write_data(write_data),
        .funct3(funct3),
        .read_data(read_data)
    );

    // Geração do clock
    always #5 clk = ~clk;

    initial begin
        // Inicialização dos sinais
        clk = 0;
        MemRead = 0;
        addr = 32'b0;
        write_data = 32'b0;
        funct3 = 3'b000; // Inicialmente para LB

        // Teste para LB
        MemRead = 1;
        addr = 32'h0000_0000; // Endereço de teste
        funct3 = 3'b000; // LB
        #10;
        $display("LB Test: Addr = %h, Data = %h", addr, read_data);

        // Teste para LH
        funct3 = 3'b001; // LH
        #10;
        $display("LH Test: Addr = %h, Data = %h", addr, read_data);

        // Teste para LW
        funct3 = 3'b010; // LW
        #10;
        $display("LW Test: Addr = %h, Data = %h", addr, read_data);

        // Teste para LBU
        funct3 = 3'b100; // LBU
        #10;
        $display("LBU Test: Addr = %h, Data = %h", addr, read_data);

        $finish;
    end

endmodule

