module Extend(
    input [23:0] InstrImm,
    input [1:0] ImmSrc,

    output reg [31:0] ExtImm
  );

  always @(*)
    case (ImmSrc)
      2'b00 :
        ExtImm = {24'b0, InstrImm[7:0]};
      2'b01 :
        ExtImm = {20'b0, InstrImm[11:0]};
      default:
        ExtImm = {{6{InstrImm[23]}}, InstrImm[23:0], 2'b0};
    endcase

endmodule  //module_name
