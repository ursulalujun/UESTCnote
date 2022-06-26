`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:20:50 06/06/2022 
// Design Name: 
// Module Name:    Inst_mem 
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
//在数据存储器Data Mem的0、1、2号单元分别存放了三个32位操作数，完成0号和1号单元相加，
//与2号单元比较，如果相等，设置3号单元的值为和；否则设置为0号与1号单元的差。
module Inst_mem(
		input [31:0] address,
		output [31:0] inst
    );
	 wire[31:0] ram[0:31];
	 
	 assign ram[5'h00] = 32'h00002820; //add $a1(00101) , $0(00000), $0    
	 assign ram[5'h01] = 32'h8CB10000; //lw   $s1, 0($a1)		R[$s1]=M[0]=2   指令地址:1 00
	 assign ram[5'h02] = 32'h8CB20004; //lw   $s2, 4($a1)		R[$s2]=M[1]=3 注意取的是addr的2-6位作为RAM的访问地址, 指令地址:10 00
	 assign ram[5'h03] = 32'h02329822; //Sub $s3,$s1,$s2		R[$s3]=-1  指令地址:11 00
	 assign ram[5'h04] = 32'h02328820; //Add $s1,$s1,$s2		R[$s1]=5   指令地址:100 00
	 assign ram[5'h05] = 32'h8CB20008; //lw   $s2, 8($a1)		R[$s2]=M[2]=6  指令地址:101 00
	 assign ram[5'h06] = 32'h12320002; //Beq $s1, $s2, 2		   指令地址:110 00
	 assign ram[5'h07] = 32'hACB3000C; //Sw   $s3, 12($a1)	M[3]=R[$s3]=-1 不相等跳转到这条指令, 指令地址:111 00
	 assign ram[5'h08] = 32'h0800000A; //J 0000 0000 0000 0000 0000 0010 10 ,跳过到最后一条指令, 指令地址:1000 00
    assign ram[5'h09] = 32'hACB1000C; //Sw   $s1, 12($a1)	M[3]=R[$s1]=5  相等跳转到这条指令, 指令地址:1001 00
	 assign ram[5'h0A] = 32'h02328820; //Add $s1,$s1,$s2		R[$s3]=11, 指令地址:1010 00
	 assign inst=ram[address[6:2]];
	 

endmodule
