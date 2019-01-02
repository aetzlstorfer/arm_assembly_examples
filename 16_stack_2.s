.global _start
_start:
	MOV R4, #1
	MOV R5, #2

	STMDB SP!, {R4, R5}
	MOV R4, #3
	MOV R5, #4
	ADD R0, R4, #0
	ADD R0, R0, R5

	LDMIA SP!, {R4, R5}
	ADD R0, R0, R4
	ADD R0, R0, R5

end:
	MOV R7, #1
	SWI 0
