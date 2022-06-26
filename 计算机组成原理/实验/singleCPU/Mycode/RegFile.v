`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:10:10 06/01/2022 
// Design Name: 
// Module Name:    RegFile 
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
//���������ڣ�һ��д�ڵļĴ�����ģ��
module RegFile(
				input [4:0] Rn1,Rn2,Wn,
				input 		Write,
				input [31:0] Wd,
				output [31:0] A,B,
				input 		Clock
    );
	 
	 reg [31:0] Register[1:31];	//����31��32λ�Ĵ�����$0�Ĵ����̶����0��ֱ���ں���Ĵ����и�ֵΪ0����
	 
	 //Read data
	 assign A = (Rn1 == 0) ? 0 : Register[Rn1];
	 assign B = (Rn2 == 0) ? 0 : Register[Rn2];
	 
	 //Write data
	 always@(posedge Clock) begin
		if(Write && (Wn!=0)) Register[Wn] <= Wd;
	 end

endmodule

