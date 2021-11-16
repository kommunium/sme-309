module DataMem(
    input wire CLK,

    //! write port
    input wire [31:0]	Address,
    input wire WE, //! Write Enable
    input wire [31:0]	WD, //! Write Data

    //! read port
    output wire	[31:0]	ReadData
  );

  reg [31:0] DATA_MEM [0:127];

  // initial
  //   $readmemh("data_mem.txt", DATA_MEM);

  initial
    begin
      DATA_MEM[0] = 32'h00000000;
      DATA_MEM[1] = 32'h00000001;
      DATA_MEM[2] = 32'h00000002;
      DATA_MEM[3] = 32'h00000003;
      DATA_MEM[4] = 32'h00000004;
      DATA_MEM[5] = 32'h00000005;
      DATA_MEM[6] = 32'h00000006;
      DATA_MEM[7] = 32'h00000007;
      DATA_MEM[8] = 32'h00000008;
      DATA_MEM[9] = 32'h00000009;
      DATA_MEM[10] = 32'h0000000A;
      DATA_MEM[11] = 32'h0000000B;
      DATA_MEM[12] = 32'h0000000C;
      DATA_MEM[13] = 32'h0000000D;
      DATA_MEM[14] = 32'h0000000E;
      DATA_MEM[15] = 32'h0000000F;
    end


  always @(posedge CLK)
    begin : mem_write
      if (WE)
        DATA_MEM[Address] <= WD;
      else
        DATA_MEM[Address] <= DATA_MEM[Address];
    end

  //! mem read
  assign ReadData = DATA_MEM[Address][31:0];

endmodule



