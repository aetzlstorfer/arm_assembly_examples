# ARM (32 bit) assembly snippets
These snippets were built from the tutorial provided by Derek Banas: http://www.newthinktank.com/2016/04/assembly-language-tutorial/. All these examples were built on Raspberry Pi 3 Model B (Plus Rev 1.3).

# How to build
When compiling regular assembly files then use either the `compile.sh` or `compile_and_run.sh` command:

Examples: Don't use the file ending, rather use the file name. E.g. `01_or` instead of `01_or.s`
```bash
./compile.sh 01_or
./compile_and_run.sh 01_or
```

Furthermore there is the possibility to compile the source with debug options on. Afterwards you can start the GDB debugger.
```bash
compile.sh 01_or
gdb bin/01_or
```

When using C libraries within the assembly code then compile it with gcc:
```bash
./gcc_compile.sh 17_functions
./gcc_compile_and_run.sh 17_functions
```

# My personal ASM learning notes
## Comments
```asm
@ comment
```
## Sections (aka labels)
```asm
.section
```
## Make section global
Global sections can be picked up by the linker
```asm
.global section
```
## Build assembler file
```bash
as -o <object file> <assembler file>
```
**Examples**:
```bash
as -o mystuff.o mystuff.s
```
## Link everything together
```bash
ld -o <executable> <object files>
```

**Examples*:
```bash
ld -o mystuff mystuff.o
ld -o alltogether 01.o 02.o
```

## Store values
* **MOV**: puts (or moves) a value onto a register
* **MOV** `<dest register>`, `value`
	
**Examples**:
```asm
		MOV R0, #15  @ puts the value 15 onto the first register
		MOV R1, #0xF @ the same, but as hex decimal
```

## Software interrupt
**SWI** `<value>`

**Examples**:
```asm
		MOV R0, <return value>
		MOV R7, #1 @ escape back to console
		SWI 0
```

## Branching: ????
**BAL**: Branch always

## Load an Address
**LDR**: load address of given string onto register

**Examples**:
```asm
		LDR R1, =message
		
		.data
		message:
			.ascii "Hello World\n"
```
## Arithmetical operation: Addition
**ADD** adds two values and stores onto a register
**ADD** `<target register>` `<source 1>` `<source 2>`

**Examples**:
```asm
		ADD R0, R1, R2   @ adds R1 and R2 and stores it onto register R0
		ADD R0, R1, #65  @ adds R1 and decimal 65 and stores it onto register R0
```

**Other operations**:
* **Subtraction**: SUB
* **Multiplication**: MUL
* **Combined Addition and Subtraction**: SUBGT `<dest>` `<a>` `<b>` (This operation carries out a subtraction, but only if `a > b` then `dest = a - b`)
* **Multiplication and Addition**: MLA `<target>` `<m1>` `<m2>` `<a>` (This operation multiplies m1 and m2 and adds a: `target = m1 * m2 + a`).

**MLA Example**:
```asm
	MOV R0, 2
	MOV R1, 4
	MOV R2, 5
	MLA R3, R0, R1, R2 @ R3 = (R0*R1) + R2
```
## Comparison
* **CMP**: Compares two registers
* **BEQ**: Branch if the last comparison was equal
* **BGT**: Branch if the last comparison was greater
* **BLT**: Branch if the last comparison was less
* **??? BLE**: less or equal? TODO
* **??? BGE**: greater or equal? TODO

## Comparison with CMP vs. TST
TODO: ??? TST: tests only for equality

## Bitwise operations
* **AND**: Bitwise AND operation
* **ORR**: Bitwise OR operation
* **EOR (=xor)**: Exclusive OR operation
* TODO ???BIC (bit clear)

## Logical shift operations:
**LSL/LSR**: shifting the bits left/right by x bits

**Example**:
```asm
		MOV R0, R1, LSL #1 @ moves from R1 the shifted by one bit  value to R0
```
 
## Memory allocation
On top of the program a .data section needs to be written.
```asm
		.data
		.balign 4 @ number of bytes needed
		mydata:
			.word 15 @init a word with the value 15 and give it the name mydata
```

## Loading/storing
Load/storing data: Loading or storing data from the memory could be done in two ways
```asm
	LDR R1, <label>  @ loads the address at the label on register R1
	LDR R1, [R1]     @ [] indicates to fetch the data for the given address
	STR R4, [R3]     @ stores the value of R4 onto the R3
	LDR R1, [R1, #8] @ loades the data at the address R1 + 4 bytes (=1 word)
``` 
	
**Loading just bytes**:
Use `LDRB` for byte length values
	
## Block load
Loading a block of data into multiple registers:
```asm
    ADR R3, numbers
    LDMIA R3, {R5-R8} @ loads the data from R3 onto the registers R5 to R8
 ```
 
## Stack
Store value at the stack:
	STR <register>, [sp, #-4]!  @ the exclamation mark is used to define that
								@ address is written back to the register
	LDR <register>, [sp], #+4

## Load/Store multiple (TODO)
* `LDMIA`, `STMIA` (increment after)
* `LDMIB`, `STMIB` (increment before)
* `LDMDA`, `STMDA` (decrement after)
* `LDMDB`, `STMDB` (decrement before)
 
## How to debug a program
* Assemble the program with the debug option
```bash
		as -g -o program.o program.s
		ld -o program program.o 
```
* Run gdb with the program
```bash
		gdb ./program
```
* In gdb you can use many sub commands
** `list` shows the first 10 lines of the program
** `disassemble _label` disassembles the code
* But a breakpoint at a line with the command `b line number`. (A breakpoint can be deleted with `delete line-number`)
* Run the program with `run` command
* After gdb stepped onto the breakpoint you can use `r info` command or `r frame` (or others, use help command).
* The coommand `continue` continues the debugger until the next breakpoint is hit
