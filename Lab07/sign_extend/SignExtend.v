// B Codes
`define B 6'b000101
`define BL 6'b100101

// D Codes
`define STURB 11'b00111000000
`define LDURB 11'b00111000010
`define STURH 11'b01111000000
`define LDURH 11'b01111000010
`define STURW 11'b10111000000
`define LDURSW 11'b10111000100
`define STXR 11'b11001000000
`define LDXR 11'b11001000010
`define STURD 11'b11111000000
`define LDURD 11'b11111000010

// CB Codes
`define BCOND 8'b01010100
`define CBZ 8'b10110100
`define CBNZ 8'b10110101


module SignExtender(BusImm, Imm32); 
  output reg [63:0] BusImm; 
  input [31:0] Imm32;

	always @(*)
	begin
		if(Imm32[31:26] == `B || Imm32[31:26] == `BL) // Check B
			BusImm = {{38{Imm32[25]}}, Imm32[25:0]};
		else if(   (Imm32[31:21] == `STURB) 
			|| (Imm32[31:21] == `LDURB) 
			|| Imm32[31:21] == `STURH 
			|| Imm32[31:21] == `LDURH 
			|| Imm32[31:21] == `STURW 
			|| Imm32[31:21] == `LDURSW 
			|| Imm32[31:21] == `STXR 
			|| Imm32[31:21] == `LDXR 
			|| Imm32[31:21] == `STURD 
			|| Imm32[31:21] == `LDURD)
			BusImm = {{55{Imm32[20]}}, Imm32[20:12]};
		else if( Imm32[31:24] == `BCOND || Imm32[31:24] == `CBZ || Imm32[31:24] == `CBNZ) // Check CB
			BusImm = {{45{Imm32[23]}}, Imm32[23:5]};
		else
			BusImm = 64'b0;
	end
endmodule
