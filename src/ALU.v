`include "Multiplier.v"

module ALU(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUControl,

    input CLK_MUL,
    input MReset,
    output Busy,

    output reg [31:0] Result,
    output [3:0] ALUFlags
  );


  //! FullAdder32
  reg [31:0] AddInA, AddInB;
  wire [31:0] Sum;
  wire Cout;
  reg Cin;
  FullAdder32 fulladder(AddInA, AddInB, Cin, Sum, Cout);

  //! Multiplier
  wire [31:0] MResult, MAddInA, MAddInB;
  wire MCin, MULOp, MUL_EN;
  Multiplier multiplier(
               .CLK_MUL(CLK_MUL),
               .Reset(MReset),
               .MUL_EN(MUL_EN),
               .MULOp(MULOp),
               .Operand1(A),
               .Operand2(B),

               .Sum(Sum),
               .MAddInA(MAddInA),
               .MAddInB(MAddInB),
               .MCin(MCin),

               .Result(MResult),
               .Busy(Busy)
             );

  //! Define control signal for the multiplier.
  assign MUL_EN = ALUControl[2:1] == 2'b10;
  assign MULOp = ALUControl[0];

  //! In multiplication, Multiplier takes control of the Fulladder
  always @(*)
    begin
      if (MUL_EN)
        begin
          AddInA = MAddInA;
          AddInB = MAddInB;
          if (MULOp)
            Cin = MCin;
        end
      else
        begin
          Cin = ALUControl[0];
          AddInA = A;
          if (Cin)
            AddInB = ~B;
          else
            AddInB = B;
        end
    end


  //! Result define
  always  @(*)
    begin: Result_Define
      case (ALUControl)
        3'b011:
          Result = A | B;
        3'b010:
          Result = A & B;
        3'b100:
          Result = MResult;
        3'b101:
          Result = MResult;
        default:
          Result = Sum;
      endcase
    end

  reg N, Z, C, V;
  //! Flags
  always @(*)
    begin: Flags_Set
      Z = ~(|Result);
      N = Result[31];
      C = ~ALUControl[1] & Cout;
      V = ~ALUControl[1] & (A[31] ^ Sum[31]) & ~(A[31] ^ B[31] ^ Cin);
    end

  assign ALUFlags = {N, Z, C, V};

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
