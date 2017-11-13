`timescale 1ns / 1ps
/*
 * Module: InstructionMemory
 *
 * Implements read-only instruction memory
 * 
 */
module InstructionMemory(Data, Address);
  	parameter T_rd = 20;
  	parameter MemSize = 40;
   
  	output [31:0] Data;
  	input [63:0]  Address;
  	reg [31:0] 	 Data;
   
	/*
	* ECEN 350 Processor Test Functions
	* Texas A&M University
	*/
   
   	always @ (Address) begin
      	case(Address)
			/* Test Program 1:
			 * Program loads constants from the data memory. Uses these constants to test
			 * the following instructions: LDUR, ORR, AND, CBZ, ADD, SUB, STUR and B.
			 * 
			 * Assembly code for test:
			 * 
			 * 0: LDUR X9, [XZR, 0x0]    //Load 1 into x9
			 * 4: LDUR X10, [XZR, 0x8]   //Load a into x10
			 * 8: LDUR X11, [XZR, 0x10]  //Load 5 into x11
			 * C: LDUR X12, [XZR, 0x18]  //Load big constant into x12
			 * 10: LDUR X13, [XZR, 0x20]  //load a 0 into X13
			 * 
			 * 14: ORR X10, X10, X11  //Create mask of 0xf
			 * 18: AND X12, X12, X10  //Mask off low order bits of big constant
			 * 
			 * loop:
			 * 1C: CBZ X12, end  //while X12 is not 0
			 * 20: ADD X13, X13, X9  //Increment counter in X13
			 * 24: SUB X12, X12, X9  //Decrement remainder of big constant in X12
			 * 28: B loop  //Repeat till X12 is 0
			 * 2C: STUR X13, [XZR, 0x20]  //store back the counter value into the memory location 0x20
			 */
			

			63'h000: Data = 32'hF84003E9;
			63'h004: Data = 32'hF84083EA;
			63'h008: Data = 32'hF84103EB;
			63'h00c: Data = 32'hF84183EC;
			63'h010: Data = 32'hF84203ED;
			63'h014: Data = 32'hAA0B014A;
			63'h018: Data = 32'h8A0A018C;
			63'h01c: Data = 32'hB400008C;
			63'h020: Data = 32'h8B0901AD;
			63'h024: Data = 32'hCB09018C;
			63'h028: Data = 32'h17FFFFFD;
			63'h02c: Data = 32'hF80203ED;
			63'h030: Data = 32'hF84203ED;  //One last load to place stored value on memdbus for test checking.

			/* Test Program 2:
			*  This program uses the ORRI and LSL to construct the following constant 
			*  (using only the ORR immediate values) 0x123456789abcdef0 in register X9
			*  it then stores this immediate value to memory at memory address 0x28
			*  Finally, load this value back to register X10 
			*
			*  34: ADD X9, XZR, XZR
			*  38: ORRI X9, XZR, 0x123
			*  3C: LSL X9, X9, 0xC
			*  40: ORRI X9, X9, 0x456
			*  44: LSL X9, X9, 0xC
			*  48: ORRI X9, X9, 0x789
			*  4C: LSL X9, X9, 0xC
			*  50: ORRI X9, X9, 0xabc
			*  54: LSL X9, X9, 0xC
			*  58: ORRI X9, X9, 0xdef
			*  5C: LSL, X9, X9, 0x4
			*  60: STUR X9, [XZR, 0x28]
			*  64: LDUR X10, [XZR, 0x28]*/
			
			63'h034: Data = 32'h4581F099;
			63'h038: Data = 32'hB2048FE9;
			63'h03C: Data = 32'hD3603129;
			63'h040: Data = 32'hB2115929;
			63'h044: Data = 32'hD3603129;
			63'h048: Data = 32'hB21E2529;
			63'h04C: Data = 32'hD3603129;
			63'h050: Data = 32'hB22AF129;
			63'h054: Data = 32'hD3603129;
			63'h058: Data = 32'hB237BD29;
			63'h05C: Data = 32'hD3601129;
			63'h060: Data = 32'hF80283E9;
			63'h064: Data = 32'hF84283EA;
					
			default: Data = 32'hXXXXXXXX;
      	endcase
   	end
endmodule
