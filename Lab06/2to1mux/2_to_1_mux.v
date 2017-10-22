`timescale 1ns / 1ps
module Mux21(out, in, sel);
	input sel;
	input [1:0] in;
	output out;
	wire w1, w2, notSel;
	not (notSel , sel);
	and(w1, in[0], notSel);
	and(w2, in[1], sel);
	or (out, w1, w2);
endmodule


