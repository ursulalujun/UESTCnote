`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:38:22 06/16/2022
// Design Name:   Fetch
// Module Name:   C:/Users/Administrator/Desktop/singleCPU/fetch_tb.v
// Project Name:  singleCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Fetch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fetch_tb;

	// Inputs
	reg B;
	reg Z;
	reg J;
	reg Reset;
	reg Clock;
	reg [25:0] target;
	reg [31:0] B_addr;

	// Outputs
	wire [31:0] addr;
	wire [31:0] target2;
	wire [31:0] next_pc;

	// Instantiate the Unit Under Test (UUT)
	Fetch uut (
		.B(B), 
		.Z(Z), 
		.J(J), 
		.Reset(Reset), 
		.Clock(Clock), 
		.target(target), 
		.B_addr(B_addr), 
		.addr(addr),
		.target_addr(target2),
		.next_pc(next_pc)
	);

	initial begin
		// Initialize Inputs
		B = 0;
		Z = 0;
		J = 0;
		Reset = 0;
		Clock = 0;
		target = 0;
		B_addr = 0;

		// Wait 100 ns for global reset to finish
		#100;
		Clock = 1; 
		
		#100;
		Clock = 0; 
		//B = 1;
		J = 1; 
		target = 26'h0000005;
		
		#100;
		Clock = 1;
		
		#100;
		J = 0;
		Clock = 0;
		
		#100;		
		Clock = 1;
		
		#100;
		Clock = 0;
		
      #100;		
		Clock = 1;

	end
       
endmodule
 
