`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:50:48 06/01/2022
// Design Name:   ALU
// Module Name:   D:/CPU/singleCPU/Mycode/ALU_test.v
// Project Name:  singleCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ALU_test;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg [2:0] ALU_operation;

	// Outputs
	wire [31:0] Result;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.A(A), 
		.B(B), 
		.ALU_operation(ALU_operation), 
		.Result(Result), 
		.Zero(Zero)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		ALU_operation = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		A = 32'h00000001;
		B = 32'h00000002;
		ALU_operation = 3'b000;
		
		#100;
		A = 32'h00000003;
		B = 32'h00000003;
		ALU_operation = 3'b100;
		
		#100;
		A = 32'h00000003;
		B = 32'h00000004;
		ALU_operation = 3'b100;
	end
      
endmodule

