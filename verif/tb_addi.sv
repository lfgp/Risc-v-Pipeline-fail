module tb_addi;

    parameter DATA_WIDTH = 32;
    parameter OPCODE_LENGTH = 4;

    logic [DATA_WIDTH-1:0] SrcA;
    logic [DATA_WIDTH-1:0] Immediate;
    logic [DATA_WIDTH-1:0] Rd;

    // Instanciar o módulo addi_operation
    addi_operation #(
        .DATA_WIDTH(DATA_WIDTH),
        .OPCODE_LENGTH(OPCODE_LENGTH)
    ) addi_inst (
        .SrcA(SrcA),
        .Immediate(Immediate),
        .Rd(Rd)
    );

    initial begin
        // Teste: Rs1 = 10, Immediate = 5
        SrcA = 32'h0000000A;
        Immediate = 32'h00000005;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado ADDI: %h", Rd); // Deve exibir 0x0000000F (15 em decimal)
        
        // Teste: Rs1 = -5, Immediate = 3
        SrcA = 32'hFFFFFFFB;
        Immediate = 32'h00000003;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado ADDI: %h", Rd); // Deve exibir 0xFFFFFFFE (-2 em decimal)

        $finish;
    end
endmodule

