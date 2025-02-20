`timescale 1ns / 1ps

module Controller (
    //Input
    input logic [6:0] Opcode,
    //7-bit opcode field from the instruction

    //Outputs
    output logic Halt,
    output logic ALUSrc,
    //0: The second ALU operand comes from the second register file output (Read data 2); 
    //1: The second ALU operand is the sign-extended, lower 16 bits of the instruction.
    output logic MemtoReg,
    //0: The value fed to the register Write data input comes from the ALU.
    //1: The value fed to the register Write data input comes from the data memory.
    output logic RegWrite, //The register on the Write register input is written with the value on the Write data input 
    output logic MemRead,  //Data memory contents designated by the address input are put on the Read data output
    output logic MemWrite, //Data memory contents designated by the address input are replaced by the value on the Write data input.
    output logic [1:0] ALUOp,  //00: LW/SW; 01:Branch; 10: Rtype
    output logic Branch  //0: branch is not taken; 1: branch is taken
    output logic JalrSel,      //0: Jalr is not taken; 1: jalr is taken
    output logic [1:0] RWSel    //00：Register Write Back; 01: PC+4 write back(JAL/JALR); 10: imm-gen write back(LUI); 11: pc+imm-gen write back(AUIPC)
);

    logic [6:0] R_TYPE, LW, SW, RTypeI, BR, JAL, JALR, LUI, AUIPC,HALT;

  assign R_TYPE = 7'b0110011;  //add,and
  assign LW = 7'b0000011;  //lb,lh,lw
  assign SW = 7'b0100011;  //sb,sh,sw
  assign  RTypeI = 7'b0010011;    //addi,ori,andi
  assign BR = 7'b1100011;  //beq
  assign  JAL    = 7'b1101111;
  assign  JALR   = 7'b1100111;
  assign  LUI    = 7'b0110111; 
  assign  AUIPC  = 7'b0010111;
  assign HALT=  7'b1111111; // halt

  assign ALUSrc = (Opcode == LW || Opcode == SW || Opcode == RTypeI || Opcode == JALR);
  assign MemtoReg = (Opcode == LW);
  assign RegWrite = (Opcode == R_TYPE || Opcode == LW || Opcode == RTypeI || Opcode == JAL || Opcode == JALR || Opcode == LUI || Opcode == AUIPC);
  assign MemRead = (Opcode == LW);
  assign MemWrite = (Opcode == SW);
  assign ALUOp[0] = (Opcode == BR || Opcode == JAL || Opcode == LUI);
  assign ALUOp[1] = (Opcode == R_TYPE || Opcode == JAL || Opcode == LUI || Opcode == RTypeI);
  assign Branch = (Opcode == BR || Opcode == JAL);
  assign JalrSel  = (Opcode == JALR);
  assign RWSel[0] = (Opcode == JALR || Opcode == JAL || Opcode == AUIPC);
  assign RWSel[1] = (Opcode == LUI || Opcode == AUIPC);
  assign Halt =    (Opcode == HALT);
endmodule
