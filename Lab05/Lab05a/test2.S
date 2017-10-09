
.section .text
.globl test2

test2:
	SUB X1, X0, X1
	ADRP X0, my_string
   	ADD X0,X0, :lo12:my_string
    BL printf
	br	X30


.section .data
	my_string: .asciz "Result of test(6, 5) = %d\n"

