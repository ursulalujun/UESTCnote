`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:21:35 05/19/2023
// Design Name:   SCCPU
// Module Name:   C:/Users/Administrator/Desktop/FlowlineCPU4/SSCPU_test.v
// Project Name:  SSCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SCCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SSCPU_test;

	// Inputs
	reg Clock;
	reg Resetn;

	// Outputs
	wire [31:0] PC;
	wire [1:0] pcsource;
	wire [31:0] if_inst_org;
	wire [31:0] if_inst;
	wire [31:0] id_inst;
	wire [31:0] id_ra;
	wire [31:0] id_rb;
	wire [31:0] exe_Alu_Result;
	wire stall;
	wire [1:0] FwdA;
	wire [1:0] FwdB;

	// Instantiate the Unit Under Test (UUT)
	SCCPU uut (
		.Clock(Clock), 
		.Resetn(Resetn), 
		.PC(PC), 
		.pcsource(pcsource), 
		.if_inst_org(if_inst_org), 
		.if_inst(if_inst), 
		.id_inst(id_inst), 
		.id_ra(id_ra), 
		.id_rb(id_rb), 
		.exe_Alu_Result(exe_Alu_Result),  
		.stall(stall), 
		.FwdA(FwdA), 
		.FwdB(FwdB)
	);

	initial begin
		// Initialize Inputs
		Clock = 0;
		Resetn = 0;
		
		#50;
      Resetn = 1;  

	end
   always #50 Clock=~Clock;
	
endmodule

