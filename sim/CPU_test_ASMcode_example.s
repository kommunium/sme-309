
;A simple ASM code as an example for you to test your ARM CPU core, but it is not enogh to test all type of the conditions
;You can modify or extend it to test all kinds of conditions in our subset instructions of  ARMv3 ! !

     AREA MYCODE, CODE, READONLY, ALIGN=9	
        ENTRY
		
		AND R0, R0, #0      ; initialize R0 as 0, i.e. R0 = 0x00000000
		LDR R1, [R0, #1]    ; R1 = DATA_MEM[1]  // you need to initialize your data memory manually, make sure there are some data prestored in the data memory
		LDR R2, [R0, #2]	; R2 = DATA_MEM[2]
		LDR R3, [R0, #3]	; R3 = DATA_MEM[3]
		LDR R4, [R0, #4]	; R4 = DATA_MEM[4]
		
		ADD R5, R15, #0     ; R5 = current PC + 8
LOOP
		ADD R6, R1, R2	 	; R6 = R1 + R2
		SUB R7, R3, R4		; R7 = R3 + R4
		ORR R1, R6, R7		; R1 = R6 | R7  //update R1
		AND R3, R6, R7		; R3 = R6 & R7  //update R3
		SUB R8, R6, R7		; R8 = R6 + R7
		STR R8, [R0]		; DATA_MEM[R0] = R8   // save R8 to different memory adresses, you can observe the data memory after the loop ended
		ADD R0, R0, #1		; Update R0, R0 = R0 + 1
		
		SUBS R5, R5, #1		; Update R5 and set flags, R5 = R5 - 1
		BNE LOOP			; LOOP until R5=0, //you can also try to use other conditions to end the loop
		
		LDR R9, [R0]		; What value has been loaded into R9 ? you can calculate and compare it with the results of your CPU.
		
		END
							;launch your Keil, convert these ASM code into machine code, 
							;and then put the machine code into your insruction memory,
							;and then run and test your CPU core, observe if they can be performed as you wish ! !
		
		