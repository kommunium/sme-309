// RegisterFile.v
module RegisterFile(
        input CLK,
        input WE3, // high active
        input [3:0] A1, // Read index1
        input [3:0] A2, // Read index2
        input [3:0] A3, // Write index
        input [31:0] WD3,// Write data
        input [31:0] R15, // R15 Data in

        output reg [31:0] RD1, // Read data1
        output reg [31:0] RD2 // Read data2
    );


    reg [31:0] RegBankCore[0:14];


    //! Sequential, writes `WD3` into `RegBankCore` at the rising edge of clk
    always @(posedge CLK)
        if (WE3 == 1'b1)
            RegBankCore[A3] <= WD3;
    // else?


    //! Combinational, defines `RD1`
    always @(*)
        if (A1 == 15)
            RD1 = R15;
        else
            RD1 = RegBankCore[A1];


    //! Combinational, defines `RD2`
    always @(*)
        if (A2 == 15)
            RD2 = R15;
        else
            RD2 = RegBankCore[A2];


endmodule
