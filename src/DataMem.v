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
      DATA_MEM[0] = 32'h0000_0000;
      DATA_MEM[1] = 32'h0000_000F;
      DATA_MEM[2] = 32'h0000_00F0;
      DATA_MEM[3] = 32'h0000_0F00;
      DATA_MEM[4] = 32'h0000_F000;
      DATA_MEM[5] = 32'h0F0F_0F0F;
      DATA_MEM[6] = 32'hF0F0_F0F0;
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



