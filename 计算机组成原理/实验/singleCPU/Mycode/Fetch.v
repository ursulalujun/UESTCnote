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
// ���ڼ�����һ��ָ��ĵ�ַ��ģ�飬ʹ��32λ��������ʵ��
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
	 //����֧�źź�0��־��Ϊ1ʱѡ����ת
	 assign sel = B & Z;
	 
	 // ����PC+4
	 ADD32 U0( .a(PC), .b(4), .result(sum0));
	 
	 //������ת֮��ĵ�ַ
	 Left_2_Shifter U2( .B_addr(B_addr), .B_addr1(B_addr1));
	 ADD32 U1( .a(B_addr1), .b(sum0), .result(sum1));
	 
	 // ѡ���Ƿ���Ҫ��ת
	 MUX32_2_1 U3( .A(sum0), .B(sum1), .Sel(sel), .O(tmp_pc));
	 
	 //ʵ��jump
	 assign target_addr = { 4'b0000, target[25:0], 2'b00};
	 assign next_pc = J ? target_addr : tmp_pc;
		
	 //MUX32_2_1 U4( .A(tmp_pc), .B(target_addr), .Sel(J), .O(next_pc));
	  
	 assign addr = PC; 
	 //��ǰ���µ�����һ�����ڣ�����һ��ָ���PC 
	 always @ (posedge Clock) begin
		PC = Reset ? 32'h00000000 : next_pc;
	 end
	 
	 initial PC = 0;

endmodule
