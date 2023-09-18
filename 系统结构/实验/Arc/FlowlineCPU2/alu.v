`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:27:17 05/15/2019 
// Design Name: 
// Module Name:    alu 
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
module alu(alua,alub,ealuc,ealu,z
    );
	 input [31:0] alua,alub;
	 input [2:0] ealuc;
	 output [31:0] ealu;
	 output z;
	 

    assign ealu = (ealuc == 3'b000) ? alua + alub :
	               (ealuc == 3'b001) ? alua & alub :
	               (ealuc == 3'b010) ? alua | alub :
	               (ealuc == 3'b011) ? alua ^ alub :
	               (ealuc == 3'b100) ? alub >> alua :
	               (ealuc == 3'b101) ? alub << alua :
	               (ealuc == 3'b110) ? alua - alub :					
	    				32'hxxxxxxxx;
	
	 assign z = ~|ealu;
	
endmodule
