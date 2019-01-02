.global _start
_start:
	MOV R0, #two

end:
	MOV R7, #1
	SWI 0

.data
.equ two, 2
