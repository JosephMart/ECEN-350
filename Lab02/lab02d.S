.section .text
.globl lab02d

lab02d:
		ADD X1, X0, #1000
		ADRP X2, myvalue
       	ADD X2,X2, :lo12:myvalue
       	STUR X1, [X2, 0]
       	ORR X0, XZR, X2
       	BR X30
.section .data
myvalue:
	.byte 2


//;STURB W1, [X0,3]         //store the new letter
