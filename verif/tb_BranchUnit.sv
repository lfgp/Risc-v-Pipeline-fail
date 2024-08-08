`timescale 1ns / 1ps

module tb_BranchUnit;

  logic [8:0] Cur_PC;
  logic [31:0] Imm;
  logic [31:0] AluResult;
  logic Branch;
  logic [2:0] BranchType;
  logic [31:0] PC_Imm;
  logic [31:0] PC_Four;
  logic [31:0] BrPC;
  logic PcSel;

  // Instância do módulo BranchUnit
  BranchUnit #(9) branch_unit (
    .Cur_PC(Cur_PC),
    .Imm(Imm),
    .AluResult(AluResult),
    .Branch(Branch),
    .BranchType(BranchType),
    .PC_Imm(PC_Imm),
    .PC_Four(PC_Four),
    .BrPC(BrPC),
    .PcSel(PcSel)
  );

  initial begin
    // Teste para BNE (Branch if Not Equal)
    Cur_PC = 9'd100;
    Imm = 32'd20;
    AluResult = 32'd1;  // Valor diferente de zero
    Branch = 1;
    BranchType = 3'b000;
    #10;
    assert (PcSel == 1) else $fatal("BNE Test Failed");
    assert (BrPC == (Cur_PC + Imm)) else $fatal("BNE Test Failed");

    // Teste para BGE (Branch if Greater or Equal)
    Cur_PC = 9'd100;
    Imm = 32'd20;
    AluResult = 32'd0;  // Valor igual a zero
    Branch = 1;
    BranchType = 3'b001;
    #10;
    assert (PcSel == 1) else $fatal("BGE Test Failed");
    assert (BrPC == (Cur_PC + Imm)) else $fatal("BGE Test Failed");

    // Teste para BLT (Branch if Less Than)
    Cur_PC = 9'd100;
    Imm = 32'd20;
    AluResult = -32'd1;  // Valor menor que zero
    Branch = 1;
    BranchType = 3'b010;
    #10;
    assert (PcSel == 1) else $fatal("BLT Test Failed");
    assert (BrPC == (Cur_PC + Imm)) else $fatal("BLT Test Failed");

    // Teste para JAL
    Cur_PC = 9'd100;
    Imm = {12'b0, 8'hFF, 1'b0};  // Exemplo de imediato para JAL
    Branch = 1;
    BranchType = 3'b000;  // Não utilizado para JAL
    #10;
    assert (PcSel == 1) else $fatal("JAL Test Failed");
    assert (BrPC == (Cur_PC + Imm)) else $fatal("JAL Test Failed");

    // Teste para JALR
    Cur_PC = 9'd100;
    Imm = 32'd20;  // Exemplo de imediato para JALR
    Branch = 1;
    BranchType = 3'b000;  // Não utilizado para JALR
    #10;
    assert (PcSel == 1) else $fatal("JALR Test Failed");
    assert (BrPC == (Cur_PC + Imm)) else $fatal("JALR Test Failed");

    $finish;
  end

endmodule

