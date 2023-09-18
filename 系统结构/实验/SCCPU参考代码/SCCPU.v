`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:33:59 05/14/2019 
// Design Name: 
// Module Name:    SCCPU 
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
module SCCPU(Clock, Resetn, PC, Inst, Alu_Result
    );
	 input Clock, Resetn;
	 output [31:0] PC, Inst, Alu_Result;
	 
	 wire [1:0] pcsource;
	 wire [31:0] bpc, jpc, pc4; 
	 
	 wire [31:0] wdi, ra, rb, imm;
	 wire m2reg, wmem, aluimm, shift, z;
	 wire [2:0] aluc;
	 
	 wire [31:0] mo;


	 IF_STAGE stage1 (Clock, Resetn, pcsource, bpc, jpc, pc4, Inst, PC);
	 
	 ID_STAGE stage2 (pc4, Inst, wdi, Clock, Resetn, bpc, jpc, pcsource,
				   m2reg, wmem, aluc, aluimm, ra, rb, imm, shift, z);	 

	 EXE_STAGE stage3 (aluc, aluimm, ra, rb, imm, shift, Alu_Result, z);
	 
	 MEM_STAGE stage4 (wmem, Alu_Result[6:2], rb, Clock, mo);		
	 
	 WB_STAGE stage5 (Alu_Result, mo, m2reg, wdi);


endmodule
