`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:40:03 06/06/2022 
// Design Name: 
// Module Name:    Sign_Extender 
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
//������չ������ʵ���õ���ָ��ֻ�漰������չ�����ֻʵ�ַ�����չģ��
module Sign_Extender(
				input [15:0] a,
				output [31:0] b
    );

	assign b = {a[15] ? 16'hffff : 15'h0 , a};

endmodule
