`timescale 1ns / 1ps

module SignExtender_tb;
	reg [31:0] Inst;
	wire [63:0] Extended;
	reg [63:0] expected_out;
	SignExtender uut(.BusImm(Extended),
					 .Imm32(Inst));

	task passTest;
		input[63:0] actualOut, expectedOut;
		if(actualOut == expectedOut)
		begin
			$display ("%0t - Test Passed.", $time);
		end
		else
		begin
			$display ("%0t - Test Failed.", $time);
			$display ("actualOut - %B", actualOut);
			$display ("expectedOut - %B", expectedOut);
		end
	endtask
	
	initial 
	begin
		Inst = 0;
		// expected_out = 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
		//expected_out = 64'b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111;
		#1 Inst = 32'b000101_01_0101_0101_0101_0101_0101_0101;
		expected_out = 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_00_01_0101_0101_0101_0101_0101_0101;
		passTest(Extended, expected_out);
		#5 Inst = 32'b000101_10_1010_1010_1010_1010_1010_1010; // 22369622
		expected_out = 64'b1111_1111_1111_1111_1111_1111_1111_1111_1111_11_10_1010_1010_1010_1010_1010_1010;  // 22369622
		#1 passTest(Extended, expected_out);
		#5 Inst = 32'b0101_0100_010_0101_0101_0101_0101_0_0000;
		expected_out = 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0010_0101_0101_0101_0101;
		#1 passTest(Extended, expected_out);
		#5 Inst = 32'b1011_0101_101_1010_1010_1010_1010_0_0000;
		expected_out = 64'b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1101_1010_1010_1010_1010;
		#1 passTest(Extended, expected_out);
		#5 Inst = 32'b111_1100_0000_0_1010_1010_00_0_0000_0_0000;
		expected_out = 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1010_1010;
		#1 passTest(Extended, expected_out);
		#5 Inst = 32'b111_1100_0010_1_0101_0101_00_0_0000_0_0000;
		expected_out = 64'b1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_1111_0101_0101;
		#1 passTest(Extended, expected_out);
		$finish;
	end
		
		
		
		
endmodule
