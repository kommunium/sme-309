//`timescale 1ns/1ps
`include "../src/ALU.v"

module ALU_tb();
  reg [31:0] A, B;
  wire [31:0] Result;
  reg [2:0] ALUControl;
  wire [3:0] ALUFlags;

  reg MReset, CLK;
  wire Busy;

  initial
    begin
      CLK = 1'b0;
      forever
        #1 CLK = ~CLK;
    end

  initial
    begin
      #0 ALUControl = 3'b000;

      #5 ALUControl = 3'b100;
      A = 32'h00000002;
      B = 32'h00000002;

      #65 ALUControl = 3'b101;
      A = 32'hfffffffe;
      B = 32'hfffffffe;
    end

  ALU alu(
        A,
        B,
        ALUControl,

        CLK,
        MReset,
        Busy,

        Result,
        ALUFlags
      );

endmodule
