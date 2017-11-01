`timescale 1ns / 1ps

`define STRLEN 32
module ALUctlBlock_v;

	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;

		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask

	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;

		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask


	// Inputs
	reg [1:0] ALUop;
	reg [10:0] Opcode;
	reg [7:0] passed;

	// Outputs
	wire [3:0] ALUCtrl;

	// Instantiate the Unit Under Test (UUT)
	ALUControl uut (
		.ALUop(ALUop),
		.Opcode(Opcode),
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		ALUop = 0;
		Opcode = 0;

		// LDUR
		{Opcode, ALUop} = {11'b00, 2'b00};
		#90;passTest(ALUCtrl, 4'b0010, "LDUR Test", passed);

		// STUR
		{Opcode, ALUop} = {11'b00, 2'b00};
		#90;passTest(ALUCtrl, 4'b0010, "STUR Test", passed);

		// CBZ
		{Opcode, ALUop} = {11'b00, 2'b01};
		#90;passTest(ALUCtrl, 4'b0111, "CBZ Test", passed);

		// R-type ADD
		{Opcode, ALUop} = {11'b100_0101_1000, 2'b10};
		#90;passTest(ALUCtrl, 4'b0010, "R-type ADD Test", passed);

		// R-type SUB
		{Opcode, ALUop} = {11'b110_0101_1000, 2'b10};
		#90;passTest(ALUCtrl, 4'b0110, "R-type SUB Test", passed);

		// R-type AND
		{Opcode, ALUop} = {11'b100_0101_0000, 2'b10};
		#90;passTest(ALUCtrl, 4'b0000, "R-type AND Test", passed);

		// R-type ORR
		{Opcode, ALUop} = {11'b101_0101_0000, 2'b10};
		#90;passTest(ALUCtrl, 4'b0001, "R-type ORR Test", passed);
	end

endmodule
