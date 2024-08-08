`timescale 1ns / 1ps

module StoreFunction (
    input logic clk,
    input logic MemWrite,    // Sinal de escrita na memória
    input logic [31:0] addr, // Endereço de escrita
    input logic [31:0] write_data, // Dados a serem escritos
    input logic [2:0] funct3 // Campo Funct3 da instrução
);

    // Instância do módulo datamemory
    datamemory #(
        .DM_ADDRESS(9),
        .DATA_W(32)
    ) mem_inst (
        .clk(clk),
        .MemRead(1'b0),      // Sem operação de leitura
        .MemWrite(MemWrite), // Ativa operação de escrita
        .a(addr[8:0]),       // Endereço para escrita
        .wd(write_data),     // Dados a serem escritos
        .Funct3(funct3),
        .rd()                // Saída de leitura não usada
    );

    always_ff @(posedge clk) begin
        if (MemWrite) begin
            case (funct3)
                3'b000: begin // SB
                    // Escreve apenas o byte menos significativo
                    // Considerando a estrutura do `datamemory`, escrevemos no bloco de memória apropriado
                    mem_inst.Wr <= 4'b0001 << (addr[1:0]); // Seleciona o banco apropriado
                    mem_inst.Datain <= {24'b0, write_data[7:0]}; // Apenas o byte menos significativo é usado
                end
                3'b001: begin // SH
                    // Escreve os 16 bits menos significativos
                    // Considerando a estrutura do `datamemory`, escrevemos nos dois blocos de memória apropriados
                    mem_inst.Wr <= (addr[1:0] == 2'b00) ? 4'b0011 : 4'b1100; // Seleciona os bancos apropriados
                    mem_inst.Datain <= {16'b0, write_data[15:0]}; // Apenas os 16 bits menos significativos são usados
                end
                default: begin
                    // Caso padrão, sem operação de escrita
                    mem_inst.Wr <= 4'b0000;
                    mem_inst.Datain <= 32'b0;
                end
            endcase
        end
    end

endmodule

