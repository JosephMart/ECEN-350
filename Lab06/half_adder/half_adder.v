`timescale 1ns / 1ps
module HalfAdd (Cout, Sum, A, B );
	input A, B;
	output Sum , Cout ;
	wire W1, W2, W3;
	nand na0 (W1, A, B ) ;
	nand na1 (W2, A, W1) ;
	nand na2 (W3, B, W1) ;
	nand na3 (Sum , W2, W3) ;
	nand na4 ( Cout , W1, W1) ;
endmodule

