`timescale 1ns / 1ps

// memory reads and writes must have a delay of 20. Be sure to use non-blocking assignments.

module DataMemory(ReadData, Address, WriteData,
                  MemoryRead, MemoryWrite, Clock);
	input [63:0] WriteData, Address;
	input MemoryRead, MemoryWrite, Clock;
	output reg [63:0] ReadData;

	reg [63:0] register [63:0];

	//memory write only commits to the memory on the negative edge of a clock, where 
	always @(negedge Clock) begin
		if (MemoryWrite == 1 && MemoryRead == 0)
			register[Address] <= #20 WriteData;
		else
			ReadData <= #20 64'b0;
	end

	// read operations occur on the positive edge of the clock
	always @(posedge Clock) begin
		if (MemoryRead == 1 && MemoryWrite == 0)
			ReadData <= #20 Address;
		else
			ReadData <= #20 64'b0;
	end
	
endmodule
