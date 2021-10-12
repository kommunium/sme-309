`timescale 1ns/1ps
`include"RegisterFile.v"

module RegisterFile_tb();

    reg CLK, WE3;
    reg [3:0] A1, A2, A3;
    reg [31:0] R15, WD3;

    wire [31:0] RD1, RD2;

    initial
        begin
            CLK = 1'b0;
            forever
                #1 CLK = ~CLK;
        end


    initial
        begin
            #0 WE3  = 1'b0;
            #10 WE3 = 1'b1;

        end

    initial
        fork
            #0 R15   = 32'h00000001;
            #40 R15  = 32'h00000002;
            #70 R15  = 32'h00000003;
            #100 R15 = 32'h00000004;
            #150 R15 = 32'h00000005;
        join

    initial
        begin
            #0 WD3 = 32'd0;
            #0 A3  = 4'd0;
            #0 A1  = 4'd0;
            #0 A2  = 4'd1;
        end

    always @(posedge CLK)
        begin
            if (!WE3)
                WD3 <= 0;
            else
                WD3 <= WD3 + 1;
        end

    always @(posedge CLK)
        begin
            if (!WE3)
                A3 <= 0;
            else
                A3 <= A3+1;
        end

    reg read_flag = 1'b0;

    initial
        begin
            #25 read_flag = 1'b1;
        end


    always @(posedge CLK)
        begin
            if (read_flag)
                A1 <= A1+1;
            else
                A1 <= 0;
        end

    always @(posedge CLK)
        begin
            if (read_flag)
                A2 <= A2+1;
            else
                A2 <= 1;
        end


    RegisterFile RF1(
                     CLK,
                     WE3,  // high active
                     A1, // Read index1
                     A2, // Read index2
                     A3, // Write index
                     WD3, // Write data
                     R15, // R15 Data in

                     RD1, // Read data1
                     RD2  // Read data2
                 );

endmodule
