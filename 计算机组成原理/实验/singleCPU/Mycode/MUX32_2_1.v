`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:01:26 06/01/2022 
// Design Name: 
// Module Name:    MUX32_2_1 
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
//32位的多路选择器模块
module MUX32_2_1(
			input [31:0] A,
			input [31:0] B,
			input 		 Sel,
			output [31:0] O
    );
		assign O = Sel?B:A;

endmodule
