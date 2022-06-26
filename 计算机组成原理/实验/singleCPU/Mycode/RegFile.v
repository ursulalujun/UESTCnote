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
//有两个读口，一个写口的寄存器堆模块
module RegFile(
				input [4:0] Rn1,Rn2,Wn,
				input 		Write,
				input [31:0] Wd,
				output [31:0] A,B,
				input 		Clock
    );
	 
	 reg [31:0] Register[1:31];	//定义31个32位寄存器，$0寄存器固定存放0，直接在后面的代码中赋值为0即可
	 
	 //Read data
	 assign A = (Rn1 == 0) ? 0 : Register[Rn1];
	 assign B = (Rn2 == 0) ? 0 : Register[Rn2];
	 
	 //Write data
	 always@(posedge Clock) begin
		if(Write && (Wn!=0)) Register[Wn] <= Wd;
	 end

endmodule

