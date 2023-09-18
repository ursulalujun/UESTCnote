`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:26:48 05/15/2019 
// Design Name: 
// Module Name:    ID_STAGE 
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
module ID_STAGE(pc4,inst,
              wdi,clk,clrn,bpc,jpc,pcsource,
				  m2reg,wmem,aluc,aluimm,a,b,imm,
				  shift,rsrtequ
    );
	 input [31:0] pc4,inst,wdi;		//pc4-PC值用于计算jpc；inst-读取的指令；wdi-向寄存器写入的数据
	 input clk,clrn;		//clk-时钟信号；clrn-复位信号；
	 input rsrtequ;		//branch控制信号
	 output [31:0] bpc,jpc,a,b,imm;		//bpc-branch_pc；jpc-jump_pc；a-寄存器操作数a；b-寄存器操作数b；imm-立即数操作数
	 output [2:0] aluc;		//ALU控制信号
	 output [1:0] pcsource;		//下一条指令地址选择
	 output m2reg,wmem,aluimm,shift;		
	 
	 wire wreg;
	 wire [4:0] rn;		//写回寄存器号
	 wire [5:0] op,func;
	 wire [4:0] rs,rt,rd;
	 wire [31:0] qa,qb,br_offset;
	 wire [15:0] ext16;
	 wire regrt,sext,e;
	 
	 assign func=inst[25:20];  
	 assign op=inst[31:26];
	 assign rs=inst[9:5];
	 assign rt=inst[4:0];
	 assign rd=inst[14:10];
	 Control_Unit cu(rsrtequ,func,                          //控制部件
	             op,wreg,m2reg,wmem,aluc,regrt,aluimm,
					 sext,pcsource,shift);
			 
     Regfile rf (rs,rt,wdi,rn,wreg,clk,clrn,qa,qb);//寄存器堆，有32个32位的寄存器，0号寄存器恒为0
	 mux5_2_1 des_reg_num (rd,rt,regrt,rn); //选择目的寄存器是来自于rd,还是rt

	 assign a=qa;
	 assign b=qb;

	 assign e=sext&inst[25];//符号拓展或0拓展
	 assign ext16={16{e}};//符号拓展
	 assign imm={ext16,inst[25:10]};		//将立即数进行符号拓展

	 assign br_offset={imm[29:0],2'b00};		//计算偏移地址
	 add32 br_addr (pc4,br_offset,bpc);		//beq,bne指令的目标地址的计算
	 assign jpc={pc4[31:28],inst[25:0],2'b00};		//jump指令的目标地址的计算
	 
endmodule
