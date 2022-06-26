`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:42:06 06/06/2022 
// Design Name: 
// Module Name:    DATA_RAM 
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
//����ʵ����ԣ�32��32λ��Ԫ�����ݴ洢������������ʵ�����Ӧ�������ֽڱ�ַ��,���ֻ��ȡaddr��2-6λ��
//������Ҫ���沢д�����ݣ�����Ӧ����32��reg�ͱ�����Ҫ���ʼ��0��1��2�ŵ�Ԫ�����ݷֱ�Ϊ2��3��5��2��3��6��ʵ��J��ָ���ͬѧ����
module DATA_RAM(
	input Clock,
	output[31:0] dataout,
	input[31:0] datain,
	input[31:0] addr,
	input write,read
    );
	 
	reg [31:0] ram[31:0];
	
	assign dataout=read?ram[addr[6:2]]:32'hxxxxxxxx;
	
	always@(posedge Clock) begin
		if(write) ram[addr[6:2]]=datain;
	end
	
	integer i;
	
	initial begin
		ram[0]=2;
		ram[1]=3;
		ram[2]=6;
		for(i=3;i<=31;i=i+1) ram[i]=5;
	end

endmodule
