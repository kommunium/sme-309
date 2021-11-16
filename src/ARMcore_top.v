module ARMcore_top(
    input wire CLK,
    input wire Reset
  );


  //! ALU instance
  reg [31:0] SrcA, SrcB;
  wire [1:0] ALUControl;

  wire [31:0] ALUResult;
  wire [3:0] ALUFlags;

  ALU alu(
        .A(SrcA),
        .B(SrcB),
        .ALUControl(ALUControl),

        .Result(ALUResult),
        .ALUFlags(ALUFlags)
      );


  //! ControlUnit instance
  wire [31:0] Instr;

  wire MemtoReg, MemWrite, ALUSrc;
  wire [1:0] ImmSrc;
  wire RegWrite;
  wire [1:0] RegSrc;
  wire PCSrc;

  ControlUnit controlUnit(
                .Instr(Instr),
                .ALUFlags(ALUFlags),
                .CLK(CLK),

                .MemtoReg(MemtoReg),
                .MemWrite(MemWrite),
                .ALUSrc(ALUSrc),
                .ImmSrc(ImmSrc),
                .RegWrite(RegWrite),
                .RegSrc(RegSrc),
                .ALUControl(ALUControl),
                .PCSrc(PCSrc)
              );


  //! Extend instance
  wire [23:0] InstrImm = Instr[23:0];
  wire [31:0] ExtImm;

  Extend extend(
           .InstrImm(InstrImm),
           .ImmSrc(ImmSrc),

           .ExtImm(ExtImm)
         );


  //! ProgramCounter instance
  wire [31:0] PC;
  wire [31:0] PCPlus4;
  reg [31:0] Result;

  ProgramCounter programCounter(
                   .CLK(CLK),
                   .Reset(Reset),
                   .PCSrc(PCSrc),
                   .Result(Result),

                   .PC(PC),
                   .PC_Plus_4(PCPlus4)
                 );


  //! RegisterFile instance
  reg [3:0] A1, A2;
  wire [3:0] A3 = Instr[15:12];
  wire [31:0] PCPlus8 = PCPlus4 + 4;
  wire [31:0] RD1, RD2;

  RegisterFile registerFile(
                 .CLK(CLK),
                 .WE3(RegWrite),
                 .A1(A1),
                 .A2(A2),
                 .A3(A3),
                 .WD3(Result),
                 .R15(PCPlus8),

                 .RD1(RD1),
                 .RD2(RD2)
               );

  always @(*)
    begin
      if (RegSrc[0])
        A1 = 4'b1111;
      else
        A1 = Instr[19:16];

      if (RegSrc[1])
        A2 = Instr[15:12];
      else
        A2 = Instr[3:0];

      if (ALUSrc)
        SrcB = ExtImm;
      else
        SrcB = RD2;

      SrcA = RD1;
    end


  //! InstrMem instance
  InstrMem instrMem(
             .PC(PC),
             .Instr(Instr)
           );


  //! DataMem instance
  wire [31:0] RD;
  DataMem dataMem(
            .CLK(CLK),
            .Address(ALUResult),
            .WE(MemWrite),
            .WD(RD2),

            .ReadData(RD)
          );

  always @(*)
    if (MemtoReg)
      Result = RD;
    else
      Result = ALUResult;

endmodule
