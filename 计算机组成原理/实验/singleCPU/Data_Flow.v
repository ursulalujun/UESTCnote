`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:42:29 06/06/2022 
// Design Name: 
// Module Name:    Data_Flow 
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
//��ȥָ��洢��Instruction ROM�����ݴ洢��DATA MEM����ʣ��ĵ�·��װ��һ�������ڵ�CPU����ͨ·��Data_Flow��ģ��
module Data_Flow(
			input Reset,				//��λ�ź�
			input Clock,				//ʱ���ź�
			input [31:0] Inst,		//��ָ��洢��������ָ���루32λ��
			input [31:0] Data,		//Data Mem�������Ϊ���һ��MUX���������ݣ�32λ��
			output MemWrite,			//���ݴ洢��DATA MEM��дʹ���ź�
			output MemRead,			//���ݴ洢��DATA MEM�Ķ�ʹ���ź�
			output [31:0] Result,	//������ALU����������32λ��
			output [31:0] B_data,	//�Ĵ�����B�������Ϊ���ݴ洢��DATA MEM��д�����ݣ�32λ��		
			output [31:0] NextPC		//ȡָ��·�γɵ�����ָ��ĵ�ַ��32λ��
    );
	 
	 wire Branch, Jump;
	 wire Zero;
	 wire [31:0] After_Extend;
	 
	 Fetch U1(.B(Branch),
				 .Z(Zero),
				 .J(Jump), 
				 .Reset(Reset),
				 .Clock(Clock),
				 .target(Inst[25:0]),
				 .B_addr(After_Extend),
				 .addr(NextPC)	);  
				 
				 
				 
	 
	 wire [5:0] op = Inst[31:26];
	 wire [5:0] func = Inst[5:0];
	 wire RegDst, RegWrite, ALUSrc, MemtoReg;
	 wire [2:0] ALU_op;
	 
	 Control_Unit U2(	.op(op),
							.func(func),
							.RegDst(RegDst),
							.RegWrite(RegWrite),
							.ALUSrc(ALUSrc),
							.MemWrite(MemWrite),
							.MemRead(MemRead),
							.MemtoReg(MemtoReg),
							.Branch(Branch),
							.Jump(Jump),
							.ALU_op(ALU_op)	);
	 
	 
	 wire [4:0] Rn1 = Inst[25:21];
	 wire [4:0] Rn2 = Inst[20:16];
	 wire [4:0] Rn3 = Inst[15:11];
	 wire [4:0] Wn;
	 
	 MUX5_2_1 Left_MUX(	.A(Rn2),
								.B(Rn3),
								.Sel(RegDst),
								.O(Wn) );
	 
	 
	 
	 wire [31:0] Wd;
	 wire [31:0] A_data,C;
	 
	 RegFile U3(	.Rn1(Rn1),
						.Rn2(Rn2),
						.Wn(Wn),
						.Write(RegWrite),
						.Wd(Wd),
						.A(A_data),
						.B(B_data),
						.Clock(Clock)	);
	 
	 
	 wire [15:0] Before_Extend = Inst[15:0];
	 
	 Sign_Extender Extender(	.a(Before_Extend),
										.b(After_Extend)	);
	 
	 
	 MUX32_2_1 Med_MUX(	.A(B_data),
								.B(After_Extend),
								.Sel(ALUSrc),
								.O(C)	);
								
	 ALU U4(	.A(A_data),
				.B(C),
				.ALU_op(ALU_op),
				.Result(Result),
				.Zero(Zero)	);
	 
	 MUX32_2_1 Right_MUX(.A(Result),
								.B(Data),
								.Sel(MemtoReg),
								.O(Wd) );	 
endmodule
