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
      INSTR_MEM[1] = 32'hE5901001;  // LDR       R1,[R0,#0x0001]
      INSTR_MEM[2] = 32'hE5902002;  // LDR       R2,[R0,#0x0002]
      INSTR_MEM[3] = 32'hE5903003;  // LDR       R3,[R0,#0x0003]
      INSTR_MEM[4] = 32'hE5904004;  // LDR       R4,[R0,#0x0004]
      INSTR_MEM[5] = 32'hE5905005;  // LDR       R5,[R0,#0x0005]
      INSTR_MEM[6] = 32'hE5906006;  // LDR       R6,[R0,#0x0006]

      INSTR_MEM[7] = 32'hE5804001;  // STR       R4,[R0,#0x0001]
      INSTR_MEM[8] = 32'hE5803002;  // STR       R3,[R0,#0x0002]
      INSTR_MEM[9] = 32'hE5802003;  // STR       R2,[R0,#0x0003]
      INSTR_MEM[10] = 32'hE5801004; // STR       R1,[R0,#0x0004]

      INSTR_MEM[11] = 32'hE0837004; // ADD       R7,R3,R4
      INSTR_MEM[12] = 32'hE28770FF; // ADD       R7,R7,#0x000000FF
      INSTR_MEM[13] = 32'hE0477002; // SUB       R7,R7,R2
      INSTR_MEM[14] = 32'hE247700E; // SUB       R7,R7,#0x0000000E
      INSTR_MEM[15] = 32'hE0077005; // AND       R7,R7,R5
      INSTR_MEM[16] = 32'hE20770FF; // AND       R7,R7,#0x000000FF
      INSTR_MEM[17] = 32'hE1877006; // ORR       R7,R7,R6
      INSTR_MEM[18] = 32'hE3877000; // ORR       R7,R7,#0x00000000
      INSTR_MEM[19] = 32'hE3818000; // ORR       R8,R1,#0x00000000

      INSTR_MEM[20] = 32'hE2099000; // AND       R9,R9,#0x00000000
      INSTR_MEM[21] = 32'hE2588001; // SUBS      R8,R8,#0x00000001
      INSTR_MEM[22] = 32'hE2899001; // ADD       R9,R9,#0x00000001
      INSTR_MEM[23] = 32'h1AFFFFFC; // BNE       0x00000054

      INSTR_MEM[24] = 32'hE052A001; // SUBS      R10,R2,R1
      INSTR_MEM[25] = 32'hC200B000; // ANDGT     R11,R11,#0x00000000
      INSTR_MEM[26] = 32'hD28BB00F; // ADDLE     R11,R11,#0x0000000F
      INSTR_MEM[27] = 32'h8200C000; // ANDHI     R12,R12,#0x00000000
      INSTR_MEM[28] = 32'h928CC00F; // ADDLS     R12,R12,#0x0000000F
    end

  assign Instr = ((PC >= 32'h00000000) & (PC <= 32'h000001FC)) ? // To check if PC is in the valid range, assuming 128 word memory.
         INSTR_MEM[PC[8:2]] : 32'h00000000;

endmodule
