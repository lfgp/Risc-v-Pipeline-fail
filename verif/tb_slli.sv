module tb_slli;

    parameter DATA_WIDTH = 32;
    parameter OPCODE_LENGTH = 4;

    logic [DATA_WIDTH-1:0] SrcA;
    logic [DATA_WIDTH-1:0] Immediate;
    logic [DATA_WIDTH-1:0] Rd;

    // Instanciar o módulo slli_operation
    slli_operation #(
        .DATA_WIDTH(DATA_WIDTH),
        .OPCODE_LENGTH(OPCODE_LENGTH)
    ) slli_inst (
        .SrcA(SrcA),
        .Immediate(Immediate),
        .Rd(Rd)
    );

    initial begin
        // Teste: Rs1 = 1, Immediate = 1
        SrcA = 32'h00000001;
        Immediate = 32'h00000001;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SLLI: %h", Rd); // Deve exibir 0x00000002 (2 em decimal)
        
        // Teste: Rs1 = 1, Immediate = 4
        SrcA = 32'h00000001;
        Immediate = 32'h00000004;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SLLI: %h", Rd); // Deve exibir 0x00000010 (16 em decimal)

        // Teste: Rs1 = 15, Immediate = 2
        SrcA = 32'h0000000F;
        Immediate = 32'h00000002;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SLLI: %h", Rd); // Deve exibir 0x0000003C (60 em decimal)

        $finish;
    end
endmodule

