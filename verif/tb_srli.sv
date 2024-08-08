module tb_srli;

    parameter DATA_WIDTH = 32;
    parameter OPCODE_LENGTH = 4;

    logic [DATA_WIDTH-1:0] SrcA;
    logic [DATA_WIDTH-1:0] Immediate;
    logic [DATA_WIDTH-1:0] Rd;

    // Instanciar o módulo srli_operation
    srli_operation #(
        .DATA_WIDTH(DATA_WIDTH),
        .OPCODE_LENGTH(OPCODE_LENGTH)
    ) srli_inst (
        .SrcA(SrcA),
        .Immediate(Immediate),
        .Rd(Rd)
    );

    initial begin
        // Teste: Rs1 = 16, Immediate = 2
        SrcA = 32'h00000010;
        Immediate = 32'h00000002;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SRLI: %h", Rd); // Deve exibir 0x00000004 (4 em decimal)
        
        // Teste: Rs1 = 1, Immediate = 1
        SrcA = 32'h00000001;
        Immediate = 32'h00000001;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SRLI: %h", Rd); // Deve exibir 0x00000000 (0 em decimal)

        // Teste: Rs1 = 0xFFFFFFFF, Immediate = 4
        SrcA = 32'hFFFFFFFF;
        Immediate = 32'h00000004;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SRLI: %h", Rd); // Deve exibir 0x0FFFFFFF

        $finish;
    end
endmodule

