`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:48:27 05/15/2019 
// Design Name: 
// Module Name:    Regfile 
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
module Regfile(rna,rnb,d,wn,we,clk,clrn,qa,qb
    );
	 input [4:0] rna,rnb,wn;
    input [31:0] d;
	 input we,clk,clrn;
	 output [31:0] qa,qb;
	 reg [31:0] register [1:31];
	 assign qa=(rna==0)?0:register[rna];
	 assign qb=(rnb==0)?0:register[rnb];
	 integer i;
	 always @(posedge clk or negedge clrn)
	     if(clrn==0)		//如果复位信号有效，则进行寄存器初始化。
		  begin//:init
		  
		  for(i=1;i<32;i=i+1)		//所有寄存器清零
		      register[i]<=0;
		  
		  register[5'h01]<=32'h00000001;		//对指定寄存器的指定地址初始化值
		  register[5'h02]<=32'h00000002;
		  register[5'h03]<=32'h00000003;
		  register[5'h04]<=32'h00000004;		  
		  
		  end
		  else if((wn!=0)&&we)
		     register[wn]<=d;
	 
endmodule
