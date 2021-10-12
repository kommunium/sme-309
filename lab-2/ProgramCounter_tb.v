`timescale 1ns/1ps
`include "ProgramCounter.v"

module ProgramCounter_tb();

    reg CLK, Reset, PCSrc;
    reg [31:0] Result;
    wire [31:0] current_PC;
    wire [31:0] PC_Plus_4;

    initial begin
        CLK = 1'b0;
        forever
            #1 CLK = ~CLK;
    end

    initial begin
        #0  Reset = 1'b1; // reset high enable
        #10 Reset = 1'b0;
    end

    initial begin
        #0  PCSrc = 0;
        #60 PCSrc = 1;
    end

    initial begin
        #0 Result  = 32'h00000001;
        #10 Result = 32'h00000002;
        #10 Result = 32'h00000003;
        #10 Result = 32'h00000004;
        #10 Result = 32'h00000005;
        #10 Result = 32'h00000006;
        #10 Result = 32'h00000007;
        #10 Result = 32'h00000008;
        #10 Result = 32'h00000009;
        #10 Result = 32'h0000000A;
        #10 Result = 32'h0000000B;
    end


    ProgramCounter PC1(
        CLK,
        Reset,
        PCSrc,
        Result,

        current_PC,
        PC_Plus_4
    );


    /*ProgramCounter PC1(
     .CLK(CLK),
     .Reset(Reset),
     .PCSrc(PCSrc),
     .Result(Result),
     
     .current_PC(current_PC),
     .PC(PC_Plus_4)PC_Plus_4
     );*/

endmodule

