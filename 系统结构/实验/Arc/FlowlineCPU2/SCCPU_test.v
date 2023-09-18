`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:22:45 04/29/2023
// Design Name:   SCCPU
// Module Name:   D:/Documents/Arc/FlowlineCPU/SCCPU_test.v
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

module SCCPU_test;

	// Inputs
	reg Clock;
	reg Resetn;

	// Outputs
	wire [31:0] PC;
	wire [31:0] if_inst;
	wire [31:0] id_inst;
	wire [31:0] exe_Alu_Result;
	wire [31:0] mem_Alu_Result;
	wire [31:0] wb_Alu_Result;
	wire [31:0] mem_mo;
	wire [31:0] wb_mo;
	wire [1:0] pcsource;
	wire [31:0] if_inst_org;
	wire stall;
	wire [1:0] FwdA, FwdB;
	
	// Instantiate the Unit Under Test (UUT)
	SCCPU uut (
		.Clock(Clock), 
		.Resetn(Resetn), 
		.PC(PC), 
		.pcsource(pcsource),
		.if_inst_org(if_inst_org),
		.if_inst(if_inst),
		.id_inst(id_inst),
		.exe_Alu_Result(exe_Alu_Result), 
		.mem_Alu_Result(mem_Alu_Result), 
		.wb_Alu_Result(wb_Alu_Result), 
		.mem_mo(mem_mo), 
		.wb_mo(wb_mo),
		.pcsource(pcsource), 
		.if_inst_org(if_inst_org),
		.stall(stall),
		.FwdA(FwdA), 
		.FwdB(FwdB)
	);

	initial begin
		// Initialize Inputs
		Clock = 0;
		Resetn = 0;

		// Wait 100 ns for global reset to finish
		#50;
      Resetn = 1;  
		// Add stimulus here

	end
   always #50 Clock=~Clock;
	
endmodule

