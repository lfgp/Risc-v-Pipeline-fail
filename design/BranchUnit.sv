`timescale 1ns / 1ps

module BranchUnit #(
        parameter PC_W = 9
    )(
    input logic [PC_W-1:0] Cur_PC,
     input logic [31:0] Imm,
     input logic JalrSel,
     input logic Branch,
     input logic Halt,
     input logic [31:0] AluResult,
     output logic [31:0] PC_Imm,
     output logic [31:0] PC_Four,
     output logic [31:0] BrPC,
     output logic PcSel);

    logic Branch_Sel;
    logic [31:0] PC_Full;
    logic Halt_sel;
    
    assign PC_Full = {23'b0, Cur_PC};
    assign Halt_sel = Halt;
    assign PC_Imm = PC_Full + Imm;
    assign PC_Four = PC_Full + 32'b100;

    assign Branch_Sel = Branch && AluResult[0]; // 0:Branch is taken; 1:Branch is not taken
    
    assign BrPC = (JalrSel) ? AluResult :     // Jalr -> AluResult
                  (Branch_Sel) ? PC_Imm :
                  (Halt_sel) ? PC_Full : 32'b0;  // Branch/Jal -> PC+Imm   // Otherwise, BrPC value is not important
    assign PcSel = JalrSel || Branch_Sel || Halt_sel;  // 1:branch (b/jal/jalr) is taken; 0:branch is not taken(choose pc+4)

endmodule
