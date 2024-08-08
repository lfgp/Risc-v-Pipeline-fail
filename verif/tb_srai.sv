module tb_srai;

    parameter DATA_WIDTH = 32;
    parameter OPCODE_LENGTH = 4;

    logic [DATA_WIDTH-1:0] SrcA;
    logic [DATA_WIDTH-1:0] Immediate;
    logic [DATA_WIDTH-1:0] Rd;

    // Instanciar o módulo srai_operation
    srai_operation #(
        .DATA_WIDTH(DATA_WIDTH),
        .OPCODE_LENGTH(OPCODE_LENGTH)
    ) srai_inst (
        .SrcA(SrcA),
        .Immediate(Immediate),
        .Rd(Rd)
    );

    initial begin
        // Teste: Rs1 = -8 (0xFFFFFFF8), Immediate = 2
        SrcA = 32'hFFFFFFF8;
        Immediate = 32'h00000002;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SRAI: %h", Rd); // Deve exibir 0xFFFFFFFE (-2 em decimal)
        
        // Teste: Rs1 = 16, Immediate = 2
        SrcA = 32'h00000010;
        Immediate = 32'h00000002;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SRAI: %h", Rd); // Deve exibir 0x00000004 (4 em decimal)

        // Teste: Rs1 = -1 (0xFFFFFFFF), Immediate = 1
        SrcA = 32'hFFFFFFFF;
        Immediate = 32'h00000001;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SRAI: %h", Rd); // Deve exibir 0xFFFFFFFF (-1 em decimal)

        $finish;
    end
endmodule

