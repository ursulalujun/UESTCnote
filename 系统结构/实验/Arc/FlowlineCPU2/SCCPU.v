`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:33:59 05/14/2019 
// Design Name: 
// Module Name:    SCCPU 
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
// �������ڽ׶�֮�����ˮ�μĴ���
module SCCPU(Clock, Resetn, PC, pcsource, 
	if_inst_org, if_inst, id_inst, 
	id_ra, id_rb, 
	exe_Alu_Result, 
	stall, FwdA, FwdB
    );
	 input Clock, Resetn;
	 output [31:0] PC, if_inst, id_inst, exe_Alu_Result;
	 
	 // �����ð����ص��źţ����ð�մ����Ƿ���ȷ
	 output stall;
	 output [1:0] FwdA, FwdB;	 
	 output [1:0] pcsource;
	 output [31:0] if_inst_org;
	 output [31:0] id_ra, id_rb;
	 
	 wire [31:0] bpc, jpc, if_pc4, id_pc4; 
	 
	 wire [31:0] wdi;
	 wire [31:0] exe_ra, exe_rb, mem_rb;
	 wire [31:0] id_imm, exe_imm;
	 wire [31:0] mem_Alu_Result, wb_Alu_Result, mem_mo, wb_mo;
	 wire [4:0] id_rn, exe_rn, mem_rn, wb_rn;
	 
	 wire id_wreg, exe_wreg, mem_wreg, wb_wreg;
	 wire id_m2reg, exe_m2reg, mem_m2reg, wb_m2reg;
	 wire id_wmem, exe_wmem, mem_wmem, id_aluimm, exe_aluimm;
	 wire [2:0] id_aluc, exe_aluc;
	 wire id_shift, exe_shift, z;
	 wire id_wmem_org, id_wreg_org;
	 
	 // ������ð����ص�wire����
	 wire [4:0] rs, rt;
	 wire regrt;
	 wire [31:0] id_ra_org, id_rb_org;
	 wire [31:0] m5, r9; 			// ���rom5��reg9�����ݣ�����ָ���Ƿ���ȷִ��
	 
	 // ��stall�źŴ���PC��IR
	 IF_STAGE stage1 (Clock, Resetn, pcsource, bpc, jpc, stall, if_pc4, if_inst_org, PC);
	 
	 // �ϳ���֧��ת��ָ��֮���ָ�����32'h0
	 assign if_inst = (pcsource ==2'b01 || pcsource ==2'b10) ? 32'h0 : if_inst_org;
	 
	 IF_ID IR (if_pc4, if_inst, Clock, Resetn, stall, id_pc4, id_inst);
	 
	 assign id_z = (id_ra == id_rb)?1'b1:1'b0;  // ���������ıȽ���ǰ��ID �׶�
	 // ���� id_z = ~|( id_a ^ id_b );			  // ʹ����ѡһMUXѡ����ra��rb���������ð��
	 
	 // ��ID_stage����rs, rt, regrt
	 // ��id_z����ID_STAGE��Control Unit�У������µ�pcsource
	 ID_STAGE stage2 (id_pc4, id_inst, id_rn, wdi, Clock, Resetn, bpc, jpc, pcsource,
				   id_m2reg, id_wmem_org, id_aluc, id_aluimm, id_ra_org, id_rb_org, id_imm, r9, 
					id_shift, id_wreg_org,
					id_z, wb_wreg, wb_rn, rs, rt, regrt);	 
	 
	 // ���load-useð�գ������ͣ�ź�
	 assign stall= ((rs == exe_rn) | (rt == exe_rn)&~regrt)&(exe_rn!=5'b0)&(exe_wreg&exe_m2reg);
	 assign id_wmem = id_wmem_org & ~stall;
	 assign id_wreg = id_wreg_org & ~stall;
	
	 // �����ź�FwdA��FwdB��������MUX4_1
	 // ����Ҫ��ⵥ���ų�shift��I��ָ���Ϊ���滹��һ����·ѡ����
	 assign FwdA = ((exe_rn != 5'b0) & exe_wreg & (exe_rn == rs) &  ~exe_m2reg) ? 2'b01 : // ѡ E_Alu
						((mem_rn != 5'b0) & mem_wreg & (mem_rn == rs) &  ~mem_m2reg) ? 2'b10 : // ѡ M_Alu
						((mem_rn != 5'b0) & mem_wreg & (mem_rn == rs) &  ~mem_m2reg) ? 2'b10 : // ѡ M_Alu
						((mem_rn != 5'b0) & mem_wreg & (mem_rn == rs) &  mem_m2reg) ? 2'b11 :  
						2'b00;  // 2'b11 ѡM_mo(load)��2b'00 ֱ��ѡregfile���
	
	 assign FwdB = ((exe_rn != 5'b0) & exe_wreg & (exe_rn == rt) &  ~exe_m2reg) ? 2'b01 : // ѡ E_Alu
						((mem_rn != 5'b0) & mem_wreg & (mem_rn == rt) &  ~mem_m2reg) ? 2'b10 : // ѡ M_Alu
						((mem_rn != 5'b0) & mem_wreg & (mem_rn == rt) &  mem_m2reg) ? 2'b11 : 
						2'b00;  // 2'b11 ѡM_mo(load)��2b'00 ֱ��ѡregfile���

	 mux32_4_1 id_ina(id_ra_org,exe_Alu_Result,mem_Alu_Result,mem_mo,FwdA,id_ra);
	 mux32_4_1 id_inb(id_rb_org,exe_Alu_Result,mem_Alu_Result,mem_mo,FwdB,id_rb);
	 
	 ID_EXE id_exe_reg (Clock, Resetn,
					id_m2reg,id_wmem,id_aluc,id_aluimm,id_shift,id_wreg,
					id_ra,id_rb,id_imm,id_rn,
					exe_m2reg,exe_wmem,exe_aluc,exe_aluimm,exe_shift,exe_wreg,
					exe_ra,exe_rb,exe_imm,exe_rn
					);
					
	 //z�ź�ֱ������pcģ�飬��ʹ��nop������²�����ȷת��				
	 EXE_STAGE stage3 (exe_aluc, exe_aluimm, exe_ra, exe_rb, exe_imm, exe_shift, exe_Alu_Result, z);
		
	 EXE_MEM exe_mem_reg (Clock, Resetn,
				exe_Alu_Result, exe_rb, exe_wmem, exe_m2reg, exe_wreg, exe_rn,
				mem_Alu_Result, mem_rb, mem_wmem, mem_m2reg, mem_wreg, mem_rn
    );
	 
	 // Alu_Result[6:2]����Cannot index into non-array mem_Alu_Result
	 // ��Alu_Result[6:2]��Ϊֱ�Ӵ���������Alu_Result�ź�
	 MEM_STAGE stage4 (mem_wmem, mem_Alu_Result[4:0], mem_rb, Clock, mem_mo, m5);		
	 
	 MEM_WB mem_wb_reg (Clock, Resetn,
					mem_Alu_Result,mem_m2reg,mem_wreg,mem_rn,mem_mo,
					wb_Alu_Result,wb_m2reg,wb_wreg,wb_rn,wb_mo);
					
	 WB_STAGE stage5 (wb_Alu_Result, wb_mo, wb_m2reg, wdi); 

endmodule
