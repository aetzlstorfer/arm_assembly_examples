.global _start

_start:
	MOV R1, #2
	MOV R2, #1
	CMP R1, R2
	BEQ vals_equal
	BGT vals_greater
	BLT vals_lesser
	B end

vals_equal:
	MOV R7, #4
	MOV R0, #1
	MOV R2, #21
	LDR R1, =txtequal
	SWI 0
	B end

vals_greater:
	MOV R7, #4
	MOV R0, #1
	MOV R2, #21
	LDR R1, =txtgreater
	SWI 0
	B end

vals_lesser:
	MOV R7, #4
	MOV R0, #1
	MOV R2, #20
	LDR R1, =txtlesser
	SWI 0
	B end

end:
	MOV R0, #0
	MOV R7, #1
	SWI 0

.data
txtequal:
	.ascii "the values are equal\n"
txtgreater:
	.ascii "the value is greater\n"
txtlesser:
	.ascii "the value is lesser\n"
