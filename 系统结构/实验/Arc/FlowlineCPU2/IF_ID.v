`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:57:20 04/28/2023 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID( if_pc4, if_inst, clk, clrn, stall, id_pc4, id_inst
    );
	 
	 input[31:0] if_pc4, if_inst;
	 input clk, clrn;
	 input stall;
	 output[31:0] id_pc4, id_inst;
	
	 // if_pc4, if_inst�����ߴ�����ź�
	 // ����Ĵ���id_pc4, id_inst�б���
	 reg[31:0] id_pc4, id_inst;
	 
	 // ʱ�������أ�clrn=0����Ĵ����ź�����
	 // ���򣬽�if�׶ε��źŴ���Ĵ����У���Ϊid�׶ε�����
	 always @ (posedge clk or negedge clrn)
		if(clrn==0)
			begin
				id_pc4<=0;
				id_inst<=0;
			end
		else if(~stall)
			begin
				id_pc4<=if_pc4;
				id_inst<=if_inst;
			end
			
endmodule
