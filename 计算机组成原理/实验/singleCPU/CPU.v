`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:22:37 06/06/2022 
// Design Name: 
// Module Name:    CPU 
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
module CPU(
			input Reset,
			input Clock
    );
	 
	 wire [31:0] inst_addr;
	 wire [31:0] inst;
	 
	 
	 Inst_mem U1(	.address(inst_addr),
						.inst(inst)	);
	 
	 
	 wire [31:0] dataout;
	 wire [31:0] datain;
	 wire [31:0] data_addr;
	 wire write, read;
	 
	 
	 
	 
	 DATA_RAM U2(	.Clock(Clock),
						.dataout(dataout),
						.datain(datain),
						.addr(data_addr),
						.write(write),
						.read(read)	);
						
	 Data_Flow U3(	.Reset(Reset),
						.Clock(Clock),
						.Inst(inst),
						.Data(dataout),
						.MemWrite(write),
						.MemRead(read),
						.Result(data_addr),
						.B_data(datain),
						.NextPC(inst_addr)	);

endmodule
