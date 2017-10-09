        .globl factorial

factorial:
	SUB SP, SP, #32 // Increment the stack pointer
    STUR X30, [SP, #16] // STORE LINK
    STUR X0, [SP, #0] // STORE X0
    SUBS XZR, X0, #1 // END IF INPUT <= 1
    B.EQ end // base case
    B.LT return_1 // hack because 0! = 1
    SUB X0, X0, #1 // X0 = n-1
    BL factorial // X0 = factorial(n-1)
    LDUR X1, [SP, #0] // Load previouse X0 to X1
    BL my_mul // factorial(n-1) * n
    B end

return_1:
	ADD X0, X0, #1
	B end

end:
	LDUR X30, [SP, #16] // Load link back
	ADD SP, SP, #32 // Add stack pointer back
	BR X30
