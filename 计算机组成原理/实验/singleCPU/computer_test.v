`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:13:17 06/09/2022
// Design Name:   Computer
// Module Name:   C:/Users/Administrator/Desktop/singleCPU/computer_test.v
// Project Name:  singleCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Computer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module computer_test;

	// Inputs
	reg Reset;
	reg Clock;

	// Outputs
	wire [31:0] inst;
	wire [31:0] pc;
	wire [31:0] data_addr;
	wire [31:0] datain;

	// Instantiate the Unit Under Test (UUT)
	MainBoard uut (
		.Reset(Reset), 
		.Clock(Clock), 
		.inst(inst), 
		.pc(pc), 
		.data_addr(data_addr), 
		.datain(datain)
	);

	initial begin
		// Initialize Inputs
		Reset = 0;
		Clock = 0;

		// Wait 100 ns for global reset to finish
		#100;
		Clock = 0;
		
		#100;
		Clock = 1;
		
		#100;
		Clock = 0;
		
		#100;
		Clock = 1;
		
		#100;
		Clock = 0;
		
		#100;
		Clock = 1;
		
		#100;
		Clock = 0;
		
		#100;
		Clock = 1;
		
		#100;
		Clock = 0;
		
		#100;
		Clock = 1;
		
		#100;
		Clock = 0;
		
		#100;
		Clock = 1;
		
		#100;
		Clock = 0;
		
		#100;
		Clock = 1;
		
		#100;
		Clock = 0;
		
		#100;
		Clock = 1;
		
		#100;
		Clock = 0;
		
		#100;
		Clock = 1;
		
		#100;
		Clock = 0;
		
        
		// Add stimulus here

	end
      
endmodule

