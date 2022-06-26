`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:22:37 06/06/2022 
// Design Name: 
// Module Name:    CPU 
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
//��ģ�������շ�װ�γɵ�CPU��������Inst_mem��DATA_RAM��Data_Flow����ģ��
//��ʵ������������ź�ֻ��clock��reset��û�������Ϊ�˷���������������
module MainBoard(
			input Reset,
			input Clock,
			output [31:0] inst,			output [31:0] pc,			output [31:0] data_addr,				output [31:0] datain	    );
	 
	 
	 Inst_mem U1(	.address(pc),
						.inst(inst)	);
	 
	 
	 wire [31:0] dataout;
	 wire write, read;
	 
	 
	 DATA_RAM U2(	.Clock(Clock),
						.dataout(dataout),
						.datain(datain),
						.addr(data_addr),
						.write(write),
						.read(read)	);
						
	 Data_Flow U3(	.Reset(Reset),
						.Clock(Clock),
						.Inst(inst),
						.Data(dataout),
						.MemWrite(write),
						.MemRead(read),
						.Result(data_addr),
						.B_data(datain),
						.NextPC(pc)	);

endmodule
