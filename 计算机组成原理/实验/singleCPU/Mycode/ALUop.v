`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:23:05 06/01/2022 
// Design Name: 
// Module Name:    ALUop 
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
module ALUop(
			input [5:0] func,
			input [1:0] ALUctr,
			output [2:0] ALU_op
		);
		
		wire i_Rt = ALUctr[1] & ~ALUctr[0];
		
		assign ALU_op[2] = (i_Rt & ((~func[2] & func[1] & ~func[0]) | (func[2] & ~func[1] & func[0]))) | ALUctr[0];
		assign ALU_op[1] = (i_Rt & (func[2] & func[1] & ~func[0])) | (ALUctr[1] & ALUctr[0]);
		assign ALU_op[0] = i_Rt & ((func[2] & ~func[1] & ~func[0]) | (func[2] & ~func[1] & func[0]));

endmodule