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
	 input [31:0] ea,eb,eimm;		//ea-由寄存器读出的操作数a；eb-由寄存器读出的操作数a；eimm-经过扩展的立即数；
	 input [2:0] ealuc;		//ALU控制码
	 input ealuimm,eshift;		//ALU输入操作数的多路选择器
	 output [31:0] ealu;		//alu操作输出
	 output z;
	 
	 wire [31:0] alua,alub,sa;

	 assign sa={27'b0,eimm[9:5]};//移位位数的生成

	 mux32_2_1 alu_ina (ea,sa,eshift,alua);//选择ALU a端的数据来源
	 mux32_2_1 alu_inb (eb,eimm,ealuimm,alub);//选择ALU b端的数据来源
 	 alu al_unit (alua,alub,ealuc,ealu,z);//ALU
	 
endmodule