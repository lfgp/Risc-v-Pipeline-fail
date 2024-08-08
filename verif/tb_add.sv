module tb_add;

    parameter OPCODE_LENGTH = 4;

    // Teste para 1 bit
    logic [0:0] SrcA_1bit;
    logic [0:0] SrcB_1bit;
    logic [0:0] Rd_1bit;

    add_operation #(
        .DATA_WIDTH(1),
        .OPCODE_LENGTH(OPCODE_LENGTH)
    ) add_inst_1bit (
        .SrcA(SrcA_1bit),
        .SrcB(SrcB_1bit),
        .Rd(Rd_1bit)
    );

    // Teste para 8 bits
    logic [7:0] SrcA_8bit;
    logic [7:0] SrcB_8bit;
    logic [7:0] Rd_8bit;

    add_operation #(
        .DATA_WIDTH(8),
        .OPCODE_LENGTH(OPCODE_LENGTH)
    ) add_inst_8bit (
        .SrcA(SrcA_8bit),
        .SrcB(SrcB_8bit),
        .Rd(Rd_8bit)
    );

    // Teste para 16 bits
    logic [15:0] SrcA_16bit;
    logic [15:0] SrcB_16bit;
    logic [15:0] Rd_16bit;

    add_operation #(
        .DATA_WIDTH(16),
        .OPCODE_LENGTH(OPCODE_LENGTH)
    ) add_inst_16bit (
        .SrcA(SrcA_16bit),
        .SrcB(SrcB_16bit),
        .Rd(Rd_16bit)
    );

    // Teste para 32 bits
    logic [31:0] SrcA_32bit;
    logic [31:0] SrcB_32bit;
    logic [31:0] Rd_32bit;

    add_operation #(
        .DATA_WIDTH(32),
        .OPCODE_LENGTH(OPCODE_LENGTH)
    ) add_inst_32bit (
        .SrcA(SrcA_32bit),
        .SrcB(SrcB_32bit),
        .Rd(Rd_32bit)
    );

    initial begin
        // Teste para 1 bit
        SrcA_1bit = 1'b1;
        SrcB_1bit = 1'b0;
        #10;
        $display("Resultado ADD 1 bit: %b", Rd_1bit); // Deve exibir 1

        // Teste para 8 bits
        SrcA_8bit = 8'h0A;
        SrcB_8bit = 8'h05;
        #10;
        $display("Resultado ADD 8 bits: %h", Rd_8bit); // Deve exibir 0x0F

        // Teste para 16 bits
        SrcA_16bit = 16'h00AA;
        SrcB_16bit = 16'h0055;
        #10;
        $display("Resultado ADD 16 bits: %h", Rd_16bit); // Deve exibir 0x00FF

        // Teste para 32 bits
        SrcA_32bit = 32'h0000000A;
        SrcB_32bit = 32'h00000005;
        #10;
        $display("Resultado ADD 32 bits: %h", Rd_32bit); // Deve exibir 0x0000000F

        $finish;
    end
endmodule

