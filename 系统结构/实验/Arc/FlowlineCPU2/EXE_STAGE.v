`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:19:13 05/15/2019 
// Design Name: 
// Module Name:    EXE_STAGE 
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
module EXE_STAGE(ealuc,ealuimm,ea,eb,eimm,eshift,ealu,z
    );
	 input [31:0] ea,eb,eimm;		//ea-�ɼĴ��������Ĳ�����a��eb-�ɼĴ��������Ĳ�����a��eimm-������չ����������
	 input [2:0] ealuc;		//ALU������
	 input ealuimm,eshift;		//ALU����������Ķ�·ѡ����
	 output [31:0] ealu;		//alu�������
	 output z;
	 
	 wire [31:0] alua,alub,sa;

	 assign sa={27'b0,eimm[9:5]};//��λλ��������

	 mux32_2_1 alu_ina (ea,sa,eshift,alua);//ѡ��ALU a�˵�������Դ
	 mux32_2_1 alu_inb (eb,eimm,ealuimm,alub);//ѡ��ALU b�˵�������Դ
 	 alu al_unit (alua,alub,ealuc,ealu,z);//ALU
	 
endmodule