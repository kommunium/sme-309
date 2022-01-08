//`timescale 1ns/1ps
`include "../src/Multiplier.v"

module Multiplier_tb();

  reg CLK, Reset, MUL_EN, MULOp;
  reg [31:0] A, B;
  wire [31:0] Sum, AddInA, AddInB, Result;
  wire Busy, Cin;

  initial
    begin
      CLK = 1'b0;
      forever
        #1 CLK = ~CLK;
    end

  initial
    begin
      #0 MULOp = 1'b0;
      #0 MUL_EN = 1'b0;

      #0 A = 32'h00000002;
      #0 B = 32'h00000002;

      #5 MUL_EN = 1'b1;
      #70 MUL_EN = 1'b0;

      #0 A = 32'h00000002;
      #0 B = 32'hfffffffe;

      #5 MUL_EN = 1'b1;
      #70 MUL_EN = 1'b0;

      #0 A = 32'hfffffffe;
      #0 B = 32'h00000002;

      #5 MUL_EN = 1'b1;
      #70 MUL_EN = 1'b0;

      #0 A = 32'hfffffffe;
      #0 B = 32'hfffffffe;

      #5 MUL_EN = 1'b1;
      #70 MUL_EN = 1'b0;

      #0 MULOp = 1'b1;

      #0 A = 32'h00000002;
      #0 B = 32'h00000002;

      #5 MUL_EN = 1'b1;
      #70 MUL_EN = 1'b0;

      #0 A = 32'h00000002;
      #0 B = 32'hfffffffe;

      #5 MUL_EN = 1'b1;
      #70 MUL_EN = 1'b0;

      #0 A = 32'hfffffffe;
      #0 B = 32'h00000002;

      #5 MUL_EN = 1'b1;
      #70 MUL_EN = 1'b0;

      #0 A = 32'hfffffffe;
      #0 B = 32'hfffffffe;

      #5 MUL_EN = 1'b1;
      #70 MUL_EN = 1'b0;
    end


  FullAdder32 fulladder(AddInA, AddInB, Cin, Sum, Cout);
  Multiplier multiplier(
               .CLK_MUL(CLK),
               .Reset(Reset),
               .MUL_EN(MUL_EN),
               .MULOp(MULOp),
               .Operand1(A),
               .Operand2(B),

               .Sum(Sum),
               .MAddInA(AddInA),
               .MAddInB(AddInB),
               .MCin(Cin),

               .Result(Result),
               .Busy(Busy)
             );

endmodule

module FullAdder1(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout);

  assign Sum = A ^ B ^ Cin;
  assign Cout = (A & B) | (A ^ B) & Cin;
endmodule

module FullAdder32 (
    input [31:0] A,
    input [31:0] B,
    input Cin,
    output [31:0] Sum,
    output Cout);

  wire [31:0] Cout_tmp;

  FullAdder1 fulladder0(
               A[0],
               B[0],
               Cin,
               Sum[0],
               Cout_tmp[0]);

  genvar i;
  generate
    for(i = 1; i <= 31; i = i + 1)
      begin: adder_gen
        FullAdder1  fulladder(
                      .A(A[i]),
                      .B(B[i]),
                      .Cin(Cout_tmp[i - 1]),
                      .Sum(Sum[i]),
                      .Cout(Cout_tmp[i]))
                    ;
      end
  endgenerate

  assign Cout = Cout_tmp[31];
endmodule
