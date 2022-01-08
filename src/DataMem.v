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
      DATA_MEM[1] = 32'h00000002;
      DATA_MEM[2] = 32'hFFFFFFFE;
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



