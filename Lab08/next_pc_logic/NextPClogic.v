`timescale 1ns / 1ps

module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
	input [63:0] CurrentPC, SignExtImm64;
	input Branch, ALUZero, Uncondbranch;
	output reg [63:0] NextPC;

	reg [63:0] PC_4;

	always @(*) begin
		PC_4 = CurrentPC + 64'b100;
		if(Branch & ALUZero)
          NextPC <= #2 (SignExtImm64 << 2) + PC_4;
    else if (Uncondbranch)
          NextPC <= #2 SignExtImm64 + CurrentPC;
    else
          NextPC <= #2 PC_4;
	end
endmodule
