`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:21:52 06/01/2022 
// Design Name: 
// Module Name:    Fetch 
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
// 用于计算下一条指令的地址的模块，使用32位的数据线实现
module Fetch(
			input B, Z, J, Reset, Clock,
			input [25:0] target,
			input [31:0] B_addr,
			output [31:0] addr,
			output [31:0] target_addr,
			output [31:0] next_pc
    );
	 
	 reg [31:0] PC;
	 
	 wire [31:0] sum0, sum1, tmp_pc, B_addr1;
	 wire sel;
	 //当分支信号和0标志都为1时选择跳转
	 assign sel = B & Z;
	 
	 // 计算PC+4
	 ADD32 U0( .a(PC), .b(4), .result(sum0));
	 
	 //计算跳转之后的地址
	 Left_2_Shifter U2( .B_addr(B_addr), .B_addr1(B_addr1));
	 ADD32 U1( .a(B_addr1), .b(sum0), .result(sum1));
	 
	 // 选择是否需要跳转
	 MUX32_2_1 U3( .A(sum0), .B(sum1), .Sel(sel), .O(tmp_pc));
	 
	 //实现jump
	 assign target_addr = { 4'b0000, target[25:0], 2'b00};
	 assign next_pc = J ? target_addr : tmp_pc;
		
	 //MUX32_2_1 U4( .A(tmp_pc), .B(target_addr), .Sel(J), .O(next_pc));
	  
	 assign addr = PC; 
	 //当前更新的是下一个周期，即下一条指令的PC 
	 always @ (posedge Clock) begin
		PC = Reset ? 32'h00000000 : next_pc;
	 end
	 
	 initial PC = 0;

endmodule
