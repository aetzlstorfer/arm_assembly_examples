.global _start

_start:
	MOV R7, #4  @ 4 = syscall nr. 4 = print
	MOV R0, #1  @ 1 = screen
	MOV R2, #12 @ 12 characters
	LDR R1, =message
	SWI 0

end:
	MOV R7, #1
	SWI 0

.data
message:
	.ascii "Hello World\n"
