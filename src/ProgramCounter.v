module ProgramCounter (
        input CLK,
        input Reset, // reset is high-active
        input PCSrc, // PC source
        input [31:0] Result, // From ALU
        output reg [31:0] current_PC,
        output [31:0] PC_Plus_4
    );


    //! Intermediate wire `next_PC`
    reg [31:0] next_PC;
    //! Combinational, defines `PC_Plus_4`
    assign PC_Plus_4 = current_PC + 4;


    //! Sequential, synchronous reset, and updates `current_PC`
    always @(posedge CLK)
        if (Reset == 1'b1)
            current_PC <= 0;
        else
            current_PC <= next_PC;


    //! Combinational, defines `next_PC`
    always @(*)
        if (PCSrc == 1'b0)
            next_PC = PC_Plus_4;
        else
            next_PC = Result;


endmodule
