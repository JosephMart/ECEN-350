.globl test
test:
	ADD X1, XZR, XZR // i = 0
	MOVZ X2, #9
	ADRP X4, UIN
    ADD X4,X4, :lo12:UIN
    LDUR X0, [X4,0]

loop:
	CBZ X3, finish
	SUB X3, X2, X1
	ADD X1, X1, #1
	SUB X0, X0, #1
	B loop

finish:
	STUR X0, [X4,0]
	BR X30

.section .data
UIN:
	.word 33
