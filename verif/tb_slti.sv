module tb_slti;

    parameter DATA_WIDTH = 32;
    parameter OPCODE_LENGTH = 4;

    logic [DATA_WIDTH-1:0] SrcA;
    logic [DATA_WIDTH-1:0] Immediate;
    logic [DATA_WIDTH-1:0] Rd;

    // Instanciar o módulo slti_operation
    slti_operation #(
        .DATA_WIDTH(DATA_WIDTH),
        .OPCODE_LENGTH(OPCODE_LENGTH)
    ) slti_inst (
        .SrcA(SrcA),
        .Immediate(Immediate),
        .Rd(Rd)
    );

    initial begin
        // Teste: Rs1 = 5, Immediate = 10
        SrcA = 32'h00000005;
        Immediate = 32'h0000000A;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SLTI: %h", Rd); // Deve exibir 0x00000001 (1 em decimal)
        
        // Teste: Rs1 = 15, Immediate = 10
        SrcA = 32'h0000000F;
        Immediate = 32'h0000000A;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SLTI: %h", Rd); // Deve exibir 0x00000000 (0 em decimal)

        // Teste: Rs1 = -5, Immediate = 3
        SrcA = 32'hFFFFFFFB;
        Immediate = 32'h00000003;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SLTI: %h", Rd); // Deve exibir 0x00000001 (1 em decimal)

        $finish;
    end
endmodule

