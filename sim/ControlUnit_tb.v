`timescale 1ns/1ps
`include "../src/ControlUnit.v"

module ControlUnit_tb();


  reg   [31:0]  Instr;
  reg   [3:0] ALUFlags;
  reg   CLK;

  wire PCSrc;
  wire MemtoReg;
  wire MemWrite;
  wire ALUSrc;
  wire [1:0] ImmSrc;
  wire RegWrite;
  wire [1:0] RegSrc;
  wire [1:0] ALUControl;
  // wire [1:0] FlagW;

  initial
    begin
      #0 Instr = 32'hE59F17F8;   // LDR R1, variable1, variable1=0x01
      #5 Instr = 32'hE5831004;  // STR R1, [R3, #4]
      #5 Instr = 32'hE2412000;  // SUB R2, R1, #0
      #5 Instr = 32'hE0911001;  // ADDS R1, R1, R1
      #5 Instr = 32'h00811001;  // ADDEQ R1, R1, R1
      #5 Instr = 32'h10811001;  // ADDNE R1, R1, R1
      #5 Instr = 32'h20811001;  // ADDCS R1, R1, R1
      #5 Instr = 32'h30811001;  // ADDCC R1, R1, R1
      #5 Instr = 32'h40811001;  // ADDMI R1, R1, R1
      #5 Instr = 32'h50811001;  // ADDPL R1, R1, R1
      #5 Instr = 32'h60811001;  // ADDVS R1, R1, R1
      #5 Instr = 32'h70811001;  // ADDVC R1, R1, R1
      #5 Instr = 32'h80811001;  // ADDHI R1, R1, R1
      #5 Instr = 32'h90811001;  // ADDLS R1, R1, R1
      #5 Instr = 32'hA0811001;  // ADDGE R1, R1, R1
      #5 Instr = 32'hB0811001;  // ADDLT R1, R1, R1
      #5 Instr = 32'hC0811001;  // ADDGT R1, R1, R1
      #5 Instr = 32'hD0811001;  // ADDLE R1, R1, R1
      #5 Instr = 32'hEAFFFFEC;  // B loop

    end

  initial
    begin
      CLK = 1'b1;
      forever
        #2.5 CLK = ~CLK;
    end

  initial
    begin
      #0  ALUFlags=4'b1010;
    end

  ControlUnit ControlUnit1(
                Instr,
                ALUFlags,
                CLK,

                MemtoReg,
                MemWrite,
                ALUSrc,
                ImmSrc,
                RegWrite,
                RegSrc,
                ALUControl,
                PCSrc
              );


endmodule
