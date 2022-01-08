//`timescale 1ns/1ps
`include "../src/ARMcore_top.v"

module ARMcore_top_tb();

  reg CLK;
  reg CLK_MUL;
  reg Reset;

  initial
    begin
      CLK = 1'b0;
      forever
        #10 CLK = ~CLK;
    end

  initial
    begin
      CLK_MUL = 1'b0;
      forever
        #1 CLK_MUL = ~CLK_MUL;
    end

  initial
    begin
      #0 Reset = 1'b1;
      #25 Reset = 1'b0;
    end

  ARMcore_top ARMcore0(
                .CLK(CLK),
                .Reset(Reset),
                .CLK_MUL(CLK_MUL)
              );
endmodule
