`include "Decoder.v"
`include "CondLogic.v"

module ControlUnit(
    input [31:0] Instr,
    input [3:0] ALUFlags,
    input CLK,

    output MemtoReg,
    output MemWrite,
    output ALUSrc,
    output [1:0] ImmSrc,
    output RegWrite,
    output [1:0] RegSrc,
    output [1:0] ALUControl,
    output PCSrc);

  wire [3:0] Cond = Instr[31:28];
  wire PCS, RegW, MemW;
  wire [1:0] FlagW;


  CondLogic CondLogic1(
              CLK,
              PCS,
              RegW,
              MemW,
              FlagW,
              Cond,
              ALUFlags,

              PCSrc,
              RegWrite,
              MemWrite);

  Decoder Decoder1(
            Instr,

            MemtoReg,
            MemW,
            ALUSrc,
            ImmSrc,
            RegW,
            RegSrc,
            ALUControl,
            FlagW,
            PCS);

endmodule
