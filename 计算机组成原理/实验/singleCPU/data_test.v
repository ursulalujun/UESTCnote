`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:17:48 06/09/2022
// Design Name:   Data_Flow
// Module Name:   C:/Users/Administrator/Desktop/singleCPU/data_test.v
// Project Name:  singleCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Data_Flow
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module data_test;

	// Inputs
	reg Reset;
	reg Clock;
	reg [31:0] Inst;
	reg [31:0] Data;

	// Outputs
	wire MemWrite;
	wire MemRead;
	wire [31:0] Result;
	wire [31:0] B_data;
	wire [31:0] NextPC;

	// Instantiate the Unit Under Test (UUT)
	Data_Flow uut (
		.Reset(Reset), 
		.Clock(Clock), 
		.Inst(Inst), 
		.Data(Data), 
		.MemWrite(MemWrite), 
		.MemRead(MemRead), 
		.Result(Result), 
		.B_data(B_data), 
		.NextPC(NextPC)
	);

	initial begin
		Reset = 0;
		Clock = 0;
		Inst = 0;
		Data = 0; 
		
		#100;
		Clock = 1;  
		Inst = 32'h00002820; //add $a1(00101) , $0(00000), $0
		#100; 
		Clock = 0;
		
		#100;
		Clock = 1; 
		Inst = 32'h8CB10000; //lw $s1,0($a1)  R[$s1]=Data=10 
		Data = 10;		
		#100;
		Clock = 0;
		
		#100;
		Clock = 1;
		Data = 5;
		Inst = 32'h8CB20004; //lw $s2,4($a1)	  R[$s2]=Data=5		
		#100;
		Clock = 0;	
		
		#100;
		Clock = 1;	
		Inst = 32'h02329822; //Sub $s3,$s1,$s2	  R[$s3]=5		
		#100;
		Clock = 0;
		
		#100;
		Clock = 1; 
		Inst = 32'h02328820; //Add $s1,$s1,$s2		R[$s1]=15	
		#100;
		Clock = 0;
		
      #100;  
		Clock = 1; 
		Inst = 32'h0800000C; //jump		
		#100;
		Clock = 0;
		
		#100;  
		Clock = 1;	
		#100;
		Clock = 0;
		// Add stimulus here

	end
      
endmodule

