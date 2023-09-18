`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:52:03 05/15/2019 
// Design Name: 
// Module Name:    MEM_STAGE 
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
module MEM_STAGE(we,addr,datain,clk,dataout
    );
	 input [31:0] datain;
	 input [4:0] addr;
	 input clk,we;
	 output [31:0] dataout;
	 
	 reg [31:0] ram [0:31];
	 assign dataout=ram[addr];		//��������Ч
	 always @(posedge clk)begin
	 if(we)ram[addr]=datain;
	 end
	 
	 integer i;
	 initial begin		//�洢����ʼ��
	 for(i=0;i<32;i=i+1)			//�洢������	
	    ram[i]=0;
	 ram[5'h01]=32'h0000000a;		//�洢����Ӧ��ַ��ʼ����ֵ
	 ram[5'h02]=32'h0000000b;
	 ram[5'h03]=32'h0000000c;
	 ram[5'h04]=32'h0000000d;

		 end
	 
endmodule
