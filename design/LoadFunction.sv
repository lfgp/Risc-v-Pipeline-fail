`timescale 1ns / 1ps

module LoadFunction (
    input logic clk,
    input logic MemRead,     // Sinal de leitura da memória
    input logic [31:0] addr, // Endereço de leitura
    input logic [31:0] write_data, // Dados a serem escritos (se aplicável)
    input logic [2:0] funct3, // Campo Funct3 da instrução
    output logic [31:0] read_data // Dados lidos da memória
);

    // Instância do módulo datamemory
    datamemory #(
        .DM_ADDRESS(9),
        .DATA_W(32)
    ) mem_inst (
        .clk(clk),
        .MemRead(MemRead),
        .MemWrite(1'b0),  // Sem operação de escrita
        .a(addr[8:0]),    // Endereço para leitura
        .wd(write_data),  // Dados a serem escritos (não usados aqui)
        .Funct3(funct3),
        .rd(read_data)
    );

    // Processamento da leitura
    always_ff @(posedge clk) begin
        if (MemRead) begin
            case (funct3)
                3'b000: begin // LB
                    read_data <= {{24{read_data[7]}}, read_data[7:0]}; // Extensão de sinal para byte
                end
                3'b001: begin // LH
                    read_data <= {{16{read_data[15]}}, read_data[15:0]}; // Extensão de sinal para halfword
                end
                3'b010: begin // LW
                    read_data <= read_data; // Palavra inteira
                end
                3'b100: begin // LBU
                    read_data <= {24'b0, read_data[7:0]}; // Extensão zero para byte
                end
                default: begin
                    read_data <= 32'b0; // Caso padrão (não esperado)
                end
            endcase
        end
    end

endmodule

