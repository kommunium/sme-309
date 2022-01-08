    AREA MYCODE, CODE, READONLY, ALIGN=9	
        ENTRY


		; Initialize data
		AND R0, R0, #0      ; initialize R0 as 0, R0 = 0x00000000
		LDR R0, [R0, #1]	; Load R0 = 0x00000002
		LDR R1, [R0]	; Load R1 = 0xFFFFFFFE
		
		; Unsigned multiplication test
		ADD R2, R0, R0		; R2 = 2 * 2 = 4
		ADD R3, R1, R1		; R3 = -2 * -2 = 4
		ADD R4, R0, R1		; R4 = 2 * -2 = 4
		ADD R5, R1, R0		; R5 = -2 * 2 = 4
		
		; Signed multiplication test
		ADD R2, R0, R0		; R2 = 2 * 2 = 4
		ADD R3, R1, R1		; R3 = -2 * -2 = 4
		ADD R4, R0, R1		; R4 = 2 * -2 = -4
		ADD R5, R1, R0		; R5 = -2 * 2 = -4

		END