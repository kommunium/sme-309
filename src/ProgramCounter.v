module ProgramCounter (
    input CLK,
    input Reset, //! reset is high-active
    input PCSrc, //! PC source
    input [31:0] Result, //! From ALU
    input Busy, //! From Multilier

    output reg [31:0] PC,
    output [31:0] PC_Plus_4
  );


  //! Intermediate wire `next_PC`
  reg [31:0] next_PC;
  //! Combinational, defines `PC_Plus_4`
  assign PC_Plus_4 = PC + 4;


  //! Sequential, synchronous reset, and updates `current_PC`
  reg [31:0] PC_tmp;

  always @(posedge CLK)
    if (Reset)
      PC <= 0;
    else if (~Busy)
      PC <= next_PC;


  //! Combinational, defines `next_PC`
  always @(*)
    if (PCSrc == 1'b0)
      next_PC = PC_Plus_4;
    else
      next_PC = Result;


endmodule
