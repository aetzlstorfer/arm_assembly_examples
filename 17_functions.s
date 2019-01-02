.data
.balign 4
question: .asciz "What is your favorite number?"

.balign 4
message: .asciz "%d is a great number\n"

.balign 4
pattern: .asciz "%d"

.balign
number: .word 0

.balign
lr_bu: .word 0

.text

.global main
.func main

main:
	LDR R1, addr_lr_bu
	STR lr, [R1]

	LDR R0, addr_question
	BL printf

	LDR R0, addr_pattern
	LDR R1, addr_number
	BL scanf

	LDR R0, addr_message
	LDR R1, addr_number
	LDR R1, [R1]
	BL printf

	LDR lr, addr_lr_bu
	LDR lr, [lr]
	BX lr

addr_question: .word question
addr_message: .word message
addr_pattern: .word pattern
addr_number: .word number
addr_lr_bu: .word lr_bu

.global printf
.global scanf






