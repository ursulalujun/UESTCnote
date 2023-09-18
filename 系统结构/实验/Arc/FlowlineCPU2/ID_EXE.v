`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:17 04/28/2023 
// Design Name: 
// Module Name:    ID_EXE 
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
module ID_EXE(clk, clrn,
				id_m2reg,id_wmem,id_aluc,id_aluimm,id_shift,id_wreg,
				id_qa,id_qb,id_imm,id_rn,
				exe_m2reg,exe_wmem,exe_aluc,exe_aluimm,exe_shift,exe_wreg,
				exe_qa,exe_qb,exe_imm,exe_rn
    );
	 
	 input clk, clrn;
	 input id_m2reg,id_wmem,id_aluimm,id_shift,id_wreg;
	 input[2:0] id_aluc;
	 input[31:0] id_qa,id_qb,id_imm;
	 input[4:0] id_rn;
	 
	 output exe_m2reg,exe_wmem,exe_aluimm,exe_shift,exe_wreg;
	 output[2:0] exe_aluc;
	 output[31:0] exe_qa,exe_qb,exe_imm;
	 output[4:0] exe_rn;
	
	 reg exe_m2reg,exe_wmem,exe_aluimm,exe_shift,exe_wreg;
	 reg[2:0] exe_aluc;
	 reg[31:0] exe_qa,exe_qb,exe_imm;
	 reg[4:0] exe_rn;
	 
	 always @ (posedge clk or negedge clrn)
		if(clrn==0)
			begin
				exe_m2reg<=0;
				exe_wmem<=0;
				exe_aluc<=0;
				exe_aluimm<=0;
				exe_shift<=0;
				exe_wreg<=0;
				exe_qa<=0;
				exe_qb<=0;
				exe_imm<=0;
				exe_rn<=0;
			end
		else
			begin
				exe_m2reg<=id_m2reg;
				exe_wmem<=id_wmem;
				exe_aluc<=id_aluc;
				exe_aluimm<=id_aluimm;
				exe_shift<=id_shift;
				exe_wreg<=id_wreg;
				exe_qa<=id_qa;
				exe_qb<=id_qb;
				exe_imm<=id_imm;
				exe_rn<=id_rn;
			end
endmodule
