`timescale 1ns / 1ps

module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
	input [63:0] CurrentPC, SignExtImm64;
	input Branch, ALUZero, Uncondbranch;
	output [63:0] NextPC;
	
	always @(*) begin
		if(Branch && ~ALUZero)
	                NextPC <= #2 SignExtImm64 + CurrentPC;
            else if (Uncondbranch)
                        NextPC <= #2 SignExtImm64 + CurrentPC;
            else
                        NextPC <= #2 PC + 4;
	end
endmodule
