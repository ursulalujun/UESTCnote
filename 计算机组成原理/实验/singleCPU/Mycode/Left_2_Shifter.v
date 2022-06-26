`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:27:56 06/01/2022 
// Design Name: 
// Module Name:    Left_2_Shifter 
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
module Left_2_Shifter(
			input [31:0] B_addr,
			output [31:0] B_addr1	
    );
	 
	assign B_addr1 = { B_addr[29:0], 2'b00 };

endmodule
