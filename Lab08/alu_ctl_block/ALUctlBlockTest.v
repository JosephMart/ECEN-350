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
		
		{Opcode, ALUop} = {11'b00, 2'b01};
		#3;
		passTest(ALUCtrl, 4'b111, "Test", passed);
		#3;
		allPassed(passed, 1);
	end
      
endmodule

