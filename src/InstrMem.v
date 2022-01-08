module InstrMem(
    input wire[31:0] PC,
    output wire	[31:0] Instr
  );

  reg [31:0]  INSTR_MEM[0:127];

  // initial
  //   $readmemh("instr_mem.txt", INSTR_MEM);

  initial
    begin
      INSTR_MEM[0] = 32'hE2000000;  // AND       R0,R0,#0x00000000
      INSTR_MEM[1] = 32'hE5900001;  // LDR       R0,[R0,#0x0001]
      INSTR_MEM[2] = 32'hE5901000;  // LDR       R1,[R0,#0x0000]

      INSTR_MEM[3] = 32'hE0E02000;  // UMUL      R2,R0,R0
      INSTR_MEM[4] = 32'hE0E13001;  // UMUL      R3,R1,R1
      INSTR_MEM[5] = 32'hE0E04001;  // UMUL      R4,R0,R1
      INSTR_MEM[6] = 32'hE0E15000;  // UMUL      R5,R1,R0

      INSTR_MEM[7] = 32'hE1C02000;  // SMUL      R2,R0,R0
      INSTR_MEM[8] = 32'hE1C13001;  // SMUL      R3,R1,R1
      INSTR_MEM[9] = 32'hE1C04001;  // SMUL      R4,R0,R1
      INSTR_MEM[10] = 32'hE1C15000; // SMUL      R5,R1,R0
    end

  assign Instr = ((PC >= 32'h00000000) & (PC <= 32'h000001FC)) ? // To check if PC is in the valid range, assuming 128 word memory.
         INSTR_MEM[PC[8:2]] : 32'h00000000;

endmodule
