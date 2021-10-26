`timescale 1ns/1ps
`include "Decoder.v"

module Decoder_tb();

  reg [31:0] Instr;
  wire MemtoReg, MemW, ALUSrc;
  wire [1:0] ImmSrc;
  wire RegW;
  wire [1:0] RegSrc, ALUControl, FlagW;
  wire PCS;


  initial
    begin
      #0 Instr = 32'hE59F27F8; // LDR R2,0x05
      #5 Instr = 32'hE5921004; // LDR R1, [R2, #4]
      #5 Instr = 32'hE5920000; // LDR R0, [R2]
      #5 Instr = 32'hE5821008; // STR R1, [R2, #8]
      #5 Instr = 32'hE5820000; // STR R0, [R2]
      #5 Instr = 32'hE2411001; // SUB R1, R1, #1
      #5 Instr = 32'hE0421003; // SUB R1, R2, R3
      #5 Instr = 32'hE2800002; // ADD R0, R0, #2
      #5 Instr = 32'hE0800003; // ADD R0, R0, R3
      #5 Instr = 32'hE2010000; // AND R0, R1, #0x0
      #5 Instr = 32'hE0010002; // AND R0, R1, R2
      #5 Instr = 32'hE3810000; // ORR R0, R1, #0x0
      #5 Instr = 32'hE1810002; // ORR R0, R1, R2
      #5 Instr = 32'hE39100FF; // ORRS R0, R1, #0xFF
      #5 Instr = 32'hE2511000; // SUBS R1, R1, #0
      #5 Instr = 32'hDA000000; // BLE done
      #5 Instr = 32'hEAFFFFEE; // B loop
    end

  Decoder D(
            Instr,
            MemtoReg,
            MemW,
            ALUSrc,
            ImmSrc,
            RegW,
            RegSrc,
            ALUControl,
            FlagW,
            PCS
          );

endmodule  // Decoder_tb
