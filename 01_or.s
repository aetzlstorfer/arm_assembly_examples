.global _start

_start:
	MOV R1, #4
	MOV R2, #1
	ORR R0, R1, R2
	MOV R7, #1
	SWI 0

