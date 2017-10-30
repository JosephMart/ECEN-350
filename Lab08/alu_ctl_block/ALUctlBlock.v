`timescale 1ns / 1ps

`define ADD 11'b100_0101_1000
`define SUB 11'b110_0101_1000
`define AND 11'b100_0101_0000
`define ORR 11'b101_0101_0000

module ALUControl(ALUCtrl, ALUop, Opcode);
	input [1:0] ALUop;
	input [10:0] Opcode;
	output reg [3:0] ALUCtrl;

	always @(*) begin
		case(ALUop)
			2'b00: ALUCtrl <= #2 4'b010;
			2'b01: ALUCtrl <= #2 4'b111;
			2'b10:
				case(Opcode)
					`ADD: ALUCtrl <= #2 4'b010;
					`SUB: ALUCtrl <= #2 4'b110;
					`AND: ALUCtrl <= #2 4'b000;
					`ORR: ALUCtrl <= #2 4'b001;
				endcase
		endcase
		
	end
endmodule
