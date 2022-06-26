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
//对于实验而言，32个32位单元的数据存储器已满足需求（实际情况应该是以字节编址）,因此只用取addr的2-6位。
//由于需要保存并写入数据，所以应设置32个reg型变量，要求初始化0、1、2号单元的内容分别为2、3、5及2、3、6（实现J型指令的同学）。
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
