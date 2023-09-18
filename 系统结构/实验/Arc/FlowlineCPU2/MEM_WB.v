`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:42:33 04/28/2023 
// Design Name: 
// Module Name:    MEM_WB 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MEM_WB(clk, clrn,
				mem_Alu_Result,mem_m2reg,mem_wreg,mem_rn,mem_mo,
				wb_Alu_Result,wb_m2reg,wb_wreg,wb_rn,wb_mo
    );
	 
	 input clk, clrn;
	 input[31:0] mem_Alu_Result,mem_mo;
	 input mem_m2reg,mem_wreg;
	 input[4:0] mem_rn;
	 
	 output[31:0] wb_Alu_Result,wb_mo;
	 output wb_m2reg,wb_wreg;
	 output[4:0] wb_rn;
	 
	 reg[31:0] wb_Alu_Result,wb_mo;
	 reg wb_m2reg,wb_wreg;
	 reg[4:0] wb_rn;

	 always @ (posedge clk or negedge clrn)
		if(clrn==0)
			begin
				wb_Alu_Result<=0;
				wb_mo<=0;
				wb_m2reg<=0;
				wb_wreg<=0;
				wb_rn<=0;
			end
		else
			begin
				wb_Alu_Result<=mem_Alu_Result;
				wb_mo<=mem_mo;
				wb_m2reg<=mem_m2reg;
				wb_wreg<=mem_wreg;
				wb_rn<=mem_rn;
			end
			
endmodule
