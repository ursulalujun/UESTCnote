`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:08:11 06/09/2022
// Design Name:   RegFile
// Module Name:   C:/Users/Administrator/Desktop/singleCPU/reg_tb.v
// Project Name:  singleCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegFile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module reg_tb;

	// Inputs
	reg [4:0] Rn1;
	reg [4:0] Rn2;
	reg [4:0] Wn;
	reg Write;
	reg [31:0] Wd;
	reg Clock;

	// Outputs
	wire [31:0] A;
	wire [31:0] B;

	// Instantiate the Unit Under Test (UUT)
	RegFile uut (
		.Rn1(Rn1), 
		.Rn2(Rn2), 
		.Wn(Wn), 
		.Write(Write), 
		.Wd(Wd), 
		.A(A), 
		.B(B), 
		.Clock(Clock)
	);

	initial begin
		// Initialize Inputs
		Rn1 = 0;
		Rn2 = 0;
		Wn = 0;
		Write = 0;
		Wd = 0;
		Clock = 0;

		// Wait 100 ns for global reset to finish
		#100;
      Rn1 = 0;
		Rn2 = 0;
		Wn = 1;
		Write = 1;
		Wd = 1023;	
		Clock = 1;
		
		#100;
      Rn1 = 1;
		Rn2 = 3;
		Wn = 0;
		Write = 0;
		Wd = 0;
		Clock = 0;
		
		
		#100;
      Rn1 = 0;
		Rn2 = 0;
		Wn = 3;
		Write = 1;
		Wd =2047;
		Clock = 1;
		
		#100;
      Rn1 = 1;
		Rn2 = 3;
		Wn = 0;
		Write = 0;
		Wd = 0;
		Clock = 0;
	end
      
endmodule

