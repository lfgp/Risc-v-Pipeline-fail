module tb_slt;

    parameter DATA_WIDTH = 32;
    parameter OPCODE_LENGTH = 4;

    logic [DATA_WIDTH-1:0] SrcA;
    logic [DATA_WIDTH-1:0] SrcB;
    logic [DATA_WIDTH-1:0] Rd;

    // Instanciar o módulo slt_operation
    slt_operation #(
        .DATA_WIDTH(DATA_WIDTH),
        .OPCODE_LENGTH(OPCODE_LENGTH)
    ) slt_inst (
        .SrcA(SrcA),
        .SrcB(SrcB),
        .Rd(Rd)
    );

    initial begin
        // Teste: Rs1 = 5, Rs2 = 10
        SrcA = 32'h00000005;
        SrcB = 32'h0000000A;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SLT: %h", Rd); // Deve exibir 0x00000001 (1 em decimal)
        
        // Teste: Rs1 = 10, Rs2 = 5
        SrcA = 32'h0000000A;
        SrcB = 32'h00000005;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SLT: %h", Rd); // Deve exibir 0x00000000 (0 em decimal)

        // Teste: Rs1 = -1 (0xFFFFFFFF), Rs2 = 1
        SrcA = 32'hFFFFFFFF;
        SrcB = 32'h00000001;

        #10; // Aguarda tempo para que a operação se complete

        $display("Resultado SLT: %h", Rd); // Deve exibir 0x00000001 (1 em decimal)

        $finish;
    end
endmodule

