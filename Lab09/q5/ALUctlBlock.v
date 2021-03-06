`timescale 1ns / 1ps

`define ADD  11'b100_0101_1000
`define SUB  11'b110_0101_1000
`define AND  11'b100_0101_0000
`define ORR  11'b101_0101_0000
`define ORRI 11'b101_1001_000?
`define LSL  11'b110_1001_1011

module ALUControl(ALUCtrl, ALUOp, Opcode);
	input [1:0] ALUOp;
	input [10:0] Opcode;
	output reg [3:0] ALUCtrl;

	always @(*) begin
		casez(ALUOp)
			2'b00: ALUCtrl <= #2 4'b010;
			2'b01: ALUCtrl <= #2 4'b111;
			2'b10:
				casez(Opcode)
					`ADD: ALUCtrl 		 <= #2 4'b010;
					`SUB: ALUCtrl 		 <= #2 4'b110;
					`AND: ALUCtrl 		 <= #2 4'b000;
					`ORR, `ORRI: ALUCtrl <= #2 4'b001;
					`LSL: ALUCtrl 		 <= #2 4'b011;
				endcase
		endcase
		
	end
endmodule
