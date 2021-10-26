module Decoder(
    input [31:0] Instr,
    output reg MemtoReg,
    output reg MemW,
    output reg ALUSrc,
    output reg [1:0] ImmSrc,
    output reg RegW,
    output reg [1:0] RegSrc,
    output reg [1:0] ALUControl,
    output reg [1:0] FlagW,
    output reg PCS);

  reg ALUOp;
  reg Branch;

  reg [9:0] Main;
  //! Main Decoder
  always @(*)
    begin
      casex ({Instr[27:26], Instr[25], Instr[20]}) // Op, Funct5, Funct0
        4'b000x :
          Main = 10'b0000xx1001; // DP reg
        4'b001x :
          Main = 10'b0001001x01; // DP imm
        4'b01x0 :
          Main = 10'b0x11010100; // STR
        4'b01x1 :
          Main = 10'b0101011x00; // LDR
        default:
          Main = 10'b1001100x10; // B
      endcase
      {Branch, MemtoReg, MemW, ALUSrc, ImmSrc, RegW, RegSrc, ALUOp} = Main;
    end

  always @(*)
    begin

    end

  reg [3:0] ALU;
  //! ALU Decoder
  always @(*)
    begin
      case ({ALUOp, Instr[24:21], Instr[20]}) // ALUOp, Funct4:1, Funct0
        6'b101000 :
          ALU = 0000; // ADD
        6'b101001 :
          ALU = 0011; // ADDS
        6'b100100 :
          ALU = 0100; // SUB
        6'b100101 :
          ALU = 0111; // SUBS
        6'b100000 :
          ALU = 1000; // AND
        6'b100001 :
          ALU = 1011; // ANDS
        6'b111000 :
          ALU = 1100; // ORR
        6'b111001 :
          ALU = 1110; // ORRS
        default:
          ALU = 0000; // Not DP
      endcase
      {ALUControl, FlagW} = ALU;
    end

  //! PC Logic
  always @(*)
    PCS <= Branch;

endmodule
