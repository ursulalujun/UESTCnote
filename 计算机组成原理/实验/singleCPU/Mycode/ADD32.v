`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:30 06/01/2022 
// Design Name: 
// Module Name:    ADD32 
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
module ADD32(
			input [31:0] a, b,
			output [31:0] result
    );
	 
	 assign result = a + b;

endmodule
