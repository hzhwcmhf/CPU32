`include "defines.v"

module cpu_controller(
	input wire clk,
	input wire rst
	);

	wire isJump_id_to_pc;
	wire[31:0] jumpAddr_id_to_pc;

	wire[31:0] insAddr_pc_to_if;
	wire[31:0] pcPlusOne_pc_to_ifid;
	wire[1:0] PcOp_fc_to_pc;
	
	pc pc_instance(
		//input
		.clk(clk),
		.rst(rst),
		.isJump_i(isJump_id_to_pc),
		.jumpAddr_i(jumpAddr_id_to_pc),
		.PcOp_i(PcOp_fc_to_pc),
		//output
		.insAddr_o(insAddr_pc_to_if),
		.pcPlusOne_o(pcPlusOne_pc_to_ifid)
		);

	wire[31:0] ins_if_to_ifid;

	if_module if_instance(
		.insAddr_i(insAddr_pc_to_if),
		.ins_o(ins_if_to_ifid)
		);
	
	wire[31:0] pcPlusOne_ifid_to_id;
	wire[31:0] instruction_ifid_to_id;
	wire[1:0] IfIdOp_fc_to_ifid;

	if_id if_id_instance(
		//input
		.clk(clk),
		.rst(rst),
		.pcPlusOne_i(pcPlusOne_pc_to_ifid),
		.instruction_i(ins_if_to_ifid),
		.IfIdOp_i(IfIdOp_fc_to_ifid),

		//output
		.pcPlusOne_o(pcPlusOne_ifid_to_id),
		.instruction_o(instruction_ifid_to_id)
		);

	//register
	wire[31:0] regData1_regis_to_id;
	wire[31:0] regData2_regis_to_id;
	//from exe to id
	wire MemToReg_ex_to_id;
	wire ALUToReg_ex_to_id;
	wire[4:0] WriteRegDst_ex_to_id;
	wire[31:0] result_exe_to_exmem_and_id;
	//from mem to id
	wire RegWrite_mem_to_id;
	wire[4:0] WriteRegDst_mem_to_id;
	wire[31:0] WriteRegData_mem_to_memwb_and_id;
	//from id to registers
	wire[4:0] regSrc1_id_to_regis;
	wire[4:0] regSrc2_id_to_regis;
	//from id to id_ex
	wire[31:0] pcPlusOne_id_to_idex;
	wire[31:0] regData1_id_to_idex;
	wire[31:0] regData2_id_to_idex;
	wire[31:0] immNumber_id_to_idex;
	wire[3:0] ALUoperation_id_to_idex;
	wire[1:0] ALUdata2Src_id_to_idex;
	wire ALUToReg_id_to_idex;
	wire[2:0] memOp_id_to_idex;
	wire MemToReg_id_to_idex;
	wire RegWrite_id_to_idex;
	wire[4:0] WriteRegDst_id_to_idex;
	wire IdPauseRequest_id_to_fc;

	id id_instance(
		//input
		//pc
		.pcPlusOne_i(pcPlusOne_ifid_to_id),
		.ins_i(instruction_ifid_to_id),
		//registers
		.regData1_i(regData1_regis_to_id),
		.regData2_i(regData2_regis_to_id),
		//exe
		.ex_MemToReg_i(MemToReg_ex_to_id),
		.ex_ALUToReg_i(ALUToReg_ex_to_id),
		.ex_WriteRegDst_i(WriteRegDst_ex_to_id),
		.ex_result_i(result_exe_to_exmem_and_id),
		//mem
		.mem_RegWrite_i(RegWrite_mem_to_id),
		.mem_WriteRegDst_i(WriteRegDst_mem_to_id),
		.mem_WriteRegData_i(WriteRegData_mem_to_memwb_and_id),

		//output
		//registers
		.regSrc1_o(regSrc1_id_to_regis),
		.regSrc2_o(regSrc2_id_to_regis),
		//id_ex
		.pcPlusOne_o(pcPlusOne_id_to_idex),
		.regData1_o(regData1_id_to_idex),
		.regData2_o(regData2_id_to_idex),
		.immNumber_o(immNumber_id_to_idex),
		//id to pc
		.jumpAddr_o(jumpAddr_id_to_pc),
		.isJump_o(isJump_id_to_pc),
		//exe
		.ALUoperation_o(ALUoperation_id_to_idex),
		.ALUdata2Src_o(ALUdata2Src_id_to_idex),
		.ALUToReg_o(ALUToReg_id_to_idex),
		//mem
		.memOp_o(memOp_id_to_idex),
		.MemToReg_o(MemToReg_id_to_idex),
		.RegWrite_o(RegWrite_id_to_idex),
		.WriteRegDst_o(WriteRegDst_id_to_idex),
		//conflict
		.IdPauseRequest_o(IdPauseRequest_id_to_fc)
		);

	wire[4:0] writeRegDst_memwb_to_regis;
	wire[31:0] writeRegData_memwb_to_regis;
	wire RegWrite_memwb_to_regis;

	registers registers_instance(
		.clk(clk),
		.rst(rst),
		.regSrc1_i(regSrc1_id_to_regis),
		.regData1_o(regData1_regis_to_id),
		.regSrc2_i(regSrc2_id_to_regis),
		.regData2_o(regData2_regis_to_id),
		.writeRegDst_i(writeRegDst_memwb_to_regis),
		.writeRegData_i(writeRegData_memwb_to_regis),
		.RegWrite_i(RegWrite_memwb_to_regis)
		);

	wire[31:0] pcPlusOne_idex_to_exe;
	wire[31:0] reg1Data_idex_to_exe;
	wire[31:0] reg2Data_idex_to_exe;
	wire[31:0] imm_idex_to_exe;

	wire[3:0] ALUoperation_idex_to_exe;
	wire[1:0] ALUdata2Src_idex_to_exe;
	wire ALUToReg_idex_to_exe;
	wire MemDataSrc_idex_to_exe;

	wire MemToReg_idex_to_exe;
	wire[2:0] MemOp_idex_to_exmem;
	wire[4:0] WriteRegDst_idex_to_exe_and_exmem;
	wire RegWrite_idex_to_exmem;
	
	wire[1:0] IdExOp_fc_to_idex;
	
	`ifdef DEBUG_MODE
	wire[31:0] ins_idex_to_exmem;
	`endif
	
	id_ex id_ex_instance(
		.clk(clk),
		.rst(rst),
		//input
		//data
		.pcPlusOne_i(pcPlusOne_id_to_idex),
		.reg1Data_i(regData1_id_to_idex),
		.reg2Data_i(regData2_id_to_idex),
		.imm_i(immNumber_id_to_idex),
		//for exe
		.ALUoperation_i(ALUoperation_id_to_idex),
		.ALUdata2Src_i(ALUdata2Src_id_to_idex),
		.ALUToReg_i(ALUToReg_id_to_idex),
		//for mem
		.MemToReg_i(MemToReg_id_to_idex),
		.MemOp_i(memOp_id_to_idex),
		//MEM and WB
		.WriteRegDst_i(WriteRegDst_id_to_idex),
		//WB
		.RegWirte_i(RegWrite_id_to_idex),
		//flow control
		.IdExOp_i(IdExOp_fc_to_idex),
		//output
		//Data
		.pcPlusOne_o(pcPlusOne_idex_to_exe),
		.reg1Data_o(reg1Data_idex_to_exe),
		.reg2Data_o(reg2Data_idex_to_exe),
		.imm_o(imm_idex_to_exe),

		//Control Signal
		//EXE
		.ALUoperation_o(ALUoperation_idex_to_exe),
		.ALUdata2Src_o(ALUdata2Src_idex_to_exe),
		.ALUToReg_o(ALUToReg_idex_to_exe),

		//MEM
		.MemToReg_o(MemToReg_idex_to_exe),
		.MemOp_o(MemOp_idex_to_exmem),
		//MEM and WB
		.WriteRegDst_o(WriteRegDst_idex_to_exe_and_exmem),
		//WB
		.RegWrite_o(RegWrite_idex_to_exmem)
		
		`ifdef DEBUG_MODE
		,
		.ins_i(instruction_ifid_to_id),
		.ins_o(ins_idex_to_exmem)
		`endif
		);

	wire[31:0] MemData_exe_to_exmem;

	exe exe_instance(
		//input
		//from id-ex reg1
		.data1(reg1Data_idex_to_exe), //data1 is reg1

		.reg2_i(reg2Data_idex_to_exe),
		.imm_i(imm_idex_to_exe),
		.pcPlusOne_i(pcPlusOne_idex_to_exe),

		.ALUdata2Src_i(ALUdata2Src_idex_to_exe),
		.ALUoperation_i(ALUoperation_idex_to_exe),
		//bypass
		.ALUToReg_i(ALUToReg_idex_to_exe),
		.WriteRegDst_i(WriteRegDst_idex_to_exe_and_exmem),
		.MemToReg_i(MemToReg_idex_to_exe),

		.result_o(result_exe_to_exmem_and_id),
		.MemData_o(MemData_exe_to_exmem),
		//bypass
		.ALUToReg_o(ALUToReg_ex_to_id),
		.WriteRegDst_o(WriteRegDst_ex_to_id),
		.MemToReg_o(MemToReg_ex_to_id)
		); 

	wire[31:0] result_exmem_to_mem;
	wire[31:0] MemData_exmem_to_mem;
	wire[2:0] MemOp_exmem_to_mem;

	wire[4:0] WriteRegDst_exmem_to_mem_and_memwb;
	wire RegWrite_exmem_to_memwb_and_mem;
	
	wire[1:0] ExMemOp_fc_to_exmem;
	
	`ifdef DEBUG_MODE
	wire[31:0] ins_exmem_to_memwb;
	`endif
	
	ex_mem ex_mem_instance(
		.clk(clk),
		.rst(rst),
		//input
		//Data
		.result_i(result_exe_to_exmem_and_id),
		.MemData_i(MemData_exe_to_exmem),
		//MEM
		.MemOp_i(MemOp_idex_to_exmem),
		//MEM and WB
		.WriteRegDst_i(WriteRegDst_idex_to_exe_and_exmem),
		//WB
		.RegWirte_i(RegWrite_idex_to_exmem),
		//flow control
		.ExMemOp_i(ExMemOp_fc_to_exmem),
		//output
		//Data
		.result_o(result_exmem_to_mem),
		.MemData_o(MemData_exmem_to_mem),
		//Control Signal
		//MEM
		.MemOp_o(MemOp_exmem_to_mem),
		//MEM and WB
		.WriteRegDst_o(WriteRegDst_exmem_to_mem_and_memwb),
		//WB
		.RegWirte_o(RegWrite_exmem_to_memwb_and_mem)
		
		`ifdef DEBUG_MODE
		,
		.ins_i(ins_idex_to_exmem),
		.ins_o(ins_exmem_to_memwb)
		`endif
		);
	
	mem mem_instance(
		.clk(clk),
		.rst(rst),
		
		.result_i(result_exmem_to_mem),
		.MemData_i(MemData_exmem_to_mem),
		
		.RegWrite_i(RegWrite_exmem_to_memwb_and_mem),
		.WriteRegDst_i(WriteRegDst_exmem_to_mem_and_memwb),
		.MemOp_i(MemOp_exmem_to_mem),

		.WriteRegData_o(WriteRegData_mem_to_memwb_and_id),
		.RegWrite_o(RegWrite_mem_to_id),
		.WriteRegDst_o(WriteRegDst_mem_to_id)
		
		);

	
	wire[1:0] MemWbOp_fc_to_memwb;
	
	mem_wb mem_wb_instance(
		.clk(clk),
		.rst(rst),
		
		.WriteRegData_i(WriteRegData_mem_to_memwb_and_id),
		.WriteRegDst_i(WriteRegDst_exmem_to_mem_and_memwb),
		.RegWrite_i(RegWrite_exmem_to_memwb_and_mem),
		
		.MemWbOp_i(MemWbOp_fc_to_memwb),
		
		.WriteRegData_o(writeRegData_memwb_to_regis),
		.WriteRegDst_o(writeRegDst_memwb_to_regis),
		.RegWrite_o(RegWrite_memwb_to_regis)
		
		`ifdef DEBUG_MODE
		,
		.ins_i(ins_exmem_to_memwb),
		.ins_o()
		`endif
		);
	
	flow_controller flow_controller_instance(
		.IdPauseRequest_i(IdPauseRequest_id_to_fc),
		.PcOp_o(PcOp_fc_to_pc),
		.IfIdOp_o(IfIdOp_fc_to_ifid),
		.IdExOp_o(IdExOp_fc_to_idex),
		.ExMemOp_o(ExMemOp_fc_to_exmem),
		.MemWbOp_o(MemWbOp_fc_to_memwb)
		);

endmodule


