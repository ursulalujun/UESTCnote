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
module MEM_STAGE(we,addr,datain,clk,dataout,m5
    );
	 input [31:0] datain;
	 input [31:0] addr;
	 input clk,we;
	 output [31:0] dataout;
	 output [31:0] m5; // ������ַΪ5���ڴ�Ľ������չʾ
	 
	 reg [31:0] ram [0:31];
	 assign dataout=ram[addr];		//��������Ч
	 always @(posedge clk)begin
	 if(we)ram[addr]=datain;
	 end
	 
	 integer i;
	 initial begin		//�洢����ʼ��
	 for(i=0;i<32;i=i+1)			//�洢������	
	    ram[i]=0;
	 
	 ram[5'h01]=32'h00000001;	//�洢����Ӧ��ַ��ʼ����ֵ
	 ram[5'h02]=32'h00000002;
	 ram[5'h03]=32'h00000003;
	 ram[5'h04]=32'h00000004;
	 ram[5'h05]=32'h00000005;
	 ram[5'h06]=32'h00000006;
	 ram[5'h07]=32'h00000007;
	 ram[5'h08]=32'h00000008;


		 end
		 
	 assign m5=ram[5'h05];
	
	 
endmodule
