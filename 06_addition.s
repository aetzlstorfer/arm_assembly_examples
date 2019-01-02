.global _start

_start:
	MOV R1, #0x5
	MOV R2, #0xA
	ADD R0, R1, R2
	MOV R7, #1
	SWI 0
