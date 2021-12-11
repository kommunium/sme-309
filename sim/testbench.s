    AREA MYCODE, CODE, READONLY, ALIGN=9	
        ENTRY


		; Test for LDR
		AND R0, R0, #0      ; initialize R0 as 0, R0 = 0x00000000
		LDR R1, [R0, #1]    ; R1 = DATA_MEM[1], 0x0000_000F
		LDR R2, [R0, #2]	; R2 = DATA_MEM[2], 0x0000_00F0
		LDR R3, [R0, #3]	; R3 = DATA_MEM[3], 0x0000_0F00
		LDR R4, [R0, #4]	; R4 = DATA_MEM[4], 0x0000_F000
		LDR R5, [R0, #5]	; R5 = DATA_MEM[5], 0x0F0F_0F0F
		LDR R6, [R0, #6]	; R6 = DATA_MEM[6], 0xF0F0_F0F0
	
	
		; Test for STR
		STR R4, [R0, #1]	; DATA_MEM[1] = R4, 0x0000_F000
		STR R3, [R0, #2]	; DATA_MEM[2] = R3, 0x0000_0F00
		STR R2, [R0, #3]	; DATA_MEM[3] = R2, 0x0000_00F0
		STR R1, [R0, #4]	; DATA_MEM[4] = R1, 0x0000_000F


		; Test for DP instructions
		ADD R7, R3, R4  	; R7 = 0x0000_FF00
		ADD R7, R7, #0xFF	; R7 = 0x0000_FFFF
		SUB R7, R7, R2		; R7 = 0x0000_FF0F
		SUB R7, R7, #0xE		; R7 = 0x0000_FF01
		AND R7, R7, R5		; R7 = 0x0000_0F01
		AND R7, R7, #0xFF	; R7 = 0x0000_0001
		ORR R7, R7, R6		; R7 = 0xF0F0_F0F1
		ORR R7, R7, #0		; R7 = 0xF0F0_F0F1
		
		
		; Test for Branch instruction
		ORR R8, R1, #0		; R8 = R1 = 0xF
		AND R9, R9, #0		; R9 = 0x0
LOOP	
		SUBS R8, R8, #1		; Update R8 and set flags, R8--
		ADD R9, R9, #1		; Update R9, R9++
		BNE LOOP			; LOOP until R8 = 0

		
		; Test for flags and condition
		SUBS R10, R2, R1	
		ANDGT R11, R0, #0 		; GT should be TRUE, R11 = 0
		ADDLE R11, R11, #0xF	; LE should be FALSE, R11 = 0
		ANDHI R12, R0, #0		; HI should be TRUE, R12 = 0
		ADDLS R12, R12, #0xF	; LS should be FALSE, R12 = 0
		END