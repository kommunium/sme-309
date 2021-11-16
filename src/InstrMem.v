module InstrMem(
    input wire[31:0] PC,
    output wire	[31:0] Instr
  );

  reg [31:0]  INSTR_MEM[0:127];

  // initial
  //   $readmemh("instr_mem.txt", INSTR_MEM);

  initial
    begin
      INSTR_MEM[0] = 32'hE2000000;
      INSTR_MEM[1] = 32'hE5901001;
      INSTR_MEM[2] = 32'hE5902002;
      INSTR_MEM[3] = 32'hE5903003;
      INSTR_MEM[4] = 32'hE5904004;
      INSTR_MEM[5] = 32'hE28F5000;
      INSTR_MEM[6] = 32'hE0816002;
      INSTR_MEM[7] = 32'hE0437004;
      INSTR_MEM[8] = 32'hE1861007;
      INSTR_MEM[9] = 32'hE0063007;
      INSTR_MEM[10] = 32'hE0468007;
      INSTR_MEM[11] = 32'hE5808000;
      INSTR_MEM[12] = 32'hE2800001;
      INSTR_MEM[13] = 32'hE2555001;
      INSTR_MEM[14] = 32'h1AFFFFF6;
      INSTR_MEM[15] = 32'hE5909000;
    end

  assign Instr = ((PC >= 32'h00000000) & (PC <= 32'h000001FC)) ? // To check if PC is in the valid range, assuming 128 word memory.
         INSTR_MEM[PC[8:2]] : 32'h00000000;

endmodule
