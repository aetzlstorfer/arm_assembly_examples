.global _start

_start:
	MOV R0, #0x1
	B other
	MOV R0, #0x2

other:
	MOV R7, #1
	SWI 0
