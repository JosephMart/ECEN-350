.section .text
.globl array
array:
	ADRP X0, my_array
    ADD X0, X0, :lo12:my_array
    ORR X2, XZR, #3 // j = 3
    ORR X1, XZR, XZR // i = X1

loop:
	SUBS XZR, X1, #10
	B.EQ finish
	LSL X9, X1, #2
	ADD X10, X0, X9
	STUR X2, [X10, #0] // my_array[i] = j
	ADD X1, X1, #1 // i++
	ADD X2, X2, #1 // j++
	B loop

finish:
	BR X30

.section .data
	my_array: .space 40
