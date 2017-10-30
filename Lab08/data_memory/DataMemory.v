`timescale 1ns / 1ps

// memory reads and writes must have a delay of 20. Be sure to use non-blocking assignments.

module DataMemory(ReadData, Address, WriteData,
                  MemoryRead, MemoryWrite, Clock);
	input [63:0] WriteData, Address;
	input MemoryRead, MemoryWrite, Clock;
	output reg[63:0] ReadData;

	reg [31:0] register [63:0];

	//memory write only commits to the memory on the negative edge of a clock 
	always @(negedge Clock) begin
		if (MemoryWrite & ~MemoryRead) // Ensure no race conditions
			register[Address] <= #20 WriteData;
	end

	// read operations occur on the positive edge of the clock
	always @(posedge Clock) begin
		if (MemoryRead & ~MemoryWrite) // Ensure no race conditions
			ReadData <= #20 register[Address];
	end
	
endmodule
