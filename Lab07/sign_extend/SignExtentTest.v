`define STRLEN 15

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
module SignExtenderTest_v;

   task passTest;
      input [63:0] actualOut, expectedOut;
      input [`STRLEN*8:0] testType;
      inout [7:0]         passed;
      
      if(actualOut == expectedOut) begin $display ("%f passed", expectedOut); passed = passed + 1; end
      else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
   endtask
   
   task allPassed;
      input [7:0] passed;
      input [7:0] numTests;
      
      if(passed == numTests) $display ("All tests passed");
      else $display("Some tests failed");
   endtask

   // Inputs
   reg [31:0]     Imm32;
   reg [7:0]      passed;

   // Outputs
   wire [63:0]    BusImm;

   // Instantiate the Device Under Test (DUT)
   SignExtender dutB(
		.BusImm(BusImm), 
		.Imm32(Imm32)
	        );

   initial begin
      // Initialize Inputs
      Imm32 = 0;
      passed = 0;

      // Add stimulus here
			// Testing B types
      #90; Imm32={`B, 26'b0}; #10; passTest({BusImm}, 64'b0, "Type(B) and 0s", passed);
      #90; Imm32={`BL, 1'b1, 25'b0}; #10; passTest({BusImm}, {{38{1'b1}}, 26'b0}, "Type(B) and 1s", passed);

			// Testing D types
      #90; Imm32={`STURB, 21'b0}; #10; passTest({BusImm}, 64'b0, "Type(D) and 0s", passed);
      #90; Imm32={`LDURD, 1'b1, 20'b0}; #10; passTest({BusImm}, {{43{1'b1}}, 21'b0}, "Type(D) and 1s", passed);

			// Testing CB types
      #90; Imm32={`BCOND, 24'b0}; #10; passTest({BusImm}, 64'b0, "Type(CB) and 0s", passed);
      #90; Imm32={`CBNZ, 1'b1, 23'b1}; #10; passTest({BusImm}, {{30{1'b1}}, 24'b0}, "Type(CB) and 1s", passed);
      
      allPassed(passed, 6);

   end
   
endmodule

