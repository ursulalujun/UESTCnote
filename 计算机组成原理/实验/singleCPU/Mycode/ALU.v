`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:28:06 06/01/2022 
// Design Name: 
// Module Name:    ALU 
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
//ALU模块，根据ALUop判断运算类型
module ALU(
			input [31:0] A,B,
			input [2:0] ALU_op,
			output [31:0] Result,
			output Zero
    );

		assign Result = (ALU_op == 3'b000) ? A + B:
							 (ALU_op == 3'b100) ? A - B:
							 (ALU_op == 3'b001) ? A & B:
							 (ALU_op == 3'b101) ? A | B:
							 (ALU_op == 3'b010) ? A ^ B:
							 (ALU_op == 3'b110) ? {B[15:0],16'h0}:
							 32'hxxxxxxxx;
		
		assign Zero = ~|Result;
		
endmodule
