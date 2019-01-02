.global _start
_start:
	MOV R1, #1
	MOV R2, #2

	@ put R1 and R2 onto the stack
	STR R1, [sp, #-4]!
	STR R2, [sp, #-4]!

	LDR R0, [sp], #+4
	LDR R0, [sp], #+4

end:
	MOV R7, #1
	SWI 0
