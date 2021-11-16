module ALU(
    input [31:0] A,
    input [31:0] B,
    input [1:0] ALUControl,

    output reg [31:0] Result,
    output [3:0] ALUFlags
  );


  //! FullAdder32
  reg [31:0] AddIn;
  wire [31:0] Sum;
  wire Cout;
  wire Cin = ALUControl[0];
  FullAdder32 fulladder(A, AddIn, Cin, Sum, Cout);

  //! Result
  always  @(*)
    begin: Result_Define
      if (Cin)
        AddIn = ~B;
      else
        AddIn = B;

      case (ALUControl)
        2'b11:
          Result = A | B;
        2'b10:
          Result = A & B;
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
                      .Cout(Cout_tmp[i]));
      end
  endgenerate

  assign Cout = Cout_tmp[31];
endmodule
