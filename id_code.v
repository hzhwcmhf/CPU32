`OP_ADD:begin
	`ifdef DEBUG_MODE
	$display("ins: ADD");
	`endif
	ALUdata2Src_o = `reg2;
	ALUoperation_o = `ALU_ADD_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rd;
end
`OP_ADDI:begin
	`ifdef DEBUG_MODE
	$display("ins: ADDI");
	`endif
	immNumber_o = Imm_16S;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_ADD_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rt;
end
`OP_SUB:begin
	`ifdef DEBUG_MODE
	$display("ins: SUB");
	`endif
	ALUdata2Src_o = `reg2;
	ALUoperation_o = `ALU_SUB_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rd;
end
`OP_LUI:begin
	`ifdef DEBUG_MODE
	$display("ins: LUI");
	`endif
	immNumber_o = Imm_16US;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_DATA2_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rt;
end
`OP_AND:begin
	`ifdef DEBUG_MODE
	$display("ins: AND");
	`endif
	ALUdata2Src_o = `reg2;
	ALUoperation_o = `ALU_AND_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rd;
end
`OP_ANDI:begin
	`ifdef DEBUG_MODE
	$display("ins: ANDI");
	`endif
	immNumber_o = Imm_16U;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_AND_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rt;
end
`OP_OR:begin
	`ifdef DEBUG_MODE
	$display("ins: OR");
	`endif
	ALUdata2Src_o = `reg2;
	ALUoperation_o = `ALU_OR_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rd;
end
`OP_ORI:begin
	`ifdef DEBUG_MODE
	$display("ins: ORI");
	`endif
	immNumber_o = Imm_16U;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_OR_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rt;
end
`OP_XOR:begin
	`ifdef DEBUG_MODE
	$display("ins: XOR");
	`endif
	ALUdata2Src_o = `reg2;
	ALUoperation_o = `ALU_XOR_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rd;
end
`OP_XORI:begin
	`ifdef DEBUG_MODE
	$display("ins: XORI");
	`endif
	immNumber_o = Imm_16U;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_XOR_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rt;
end
`OP_NOR:begin
	`ifdef DEBUG_MODE
	$display("ins: NOR");
	`endif
	ALUdata2Src_o = `reg2;
	ALUoperation_o = `ALU_NOR_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rd;
end
`OP_SLL:begin
	`ifdef DEBUG_MODE
	$display("ins: SLL");
	`endif
	immNumber_o = Imm_5U;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_SLL_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rd;
end
`OP_SRL:begin
	`ifdef DEBUG_MODE
	$display("ins: SRL");
	`endif
	immNumber_o = Imm_5U;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_SRL_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rd;
end
`OP_SRA:begin
	`ifdef DEBUG_MODE
	$display("ins: SRA");
	`endif
	immNumber_o = Imm_5U;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_SRA_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rd;
end
`OP_LW:begin
	`ifdef DEBUG_MODE
	$display("ins: LW");
	`endif
	immNumber_o = Imm_16S;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_ADD_OP;
	MemToReg_o = 1'b1;
	memOp_o = `MEM_LOAD_WORD;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rt;
end
`OP_LH:begin
	`ifdef DEBUG_MODE
	$display("ins: LH");
	`endif
	immNumber_o = Imm_16S;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_ADD_OP;
	MemToReg_o = 1'b1;
	memOp_o = `MEM_LOAD_HALF;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rt;
end
`OP_LB:begin
	`ifdef DEBUG_MODE
	$display("ins: LB");
	`endif
	immNumber_o = Imm_16S;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_ADD_OP;
	MemToReg_o = 1'b1;
	memOp_o = `MEM_LOAD_BYTE;
	RegWrite_o = 1'b1;
	WriteRegDst_o = rt;
end
`OP_SW:begin
	`ifdef DEBUG_MODE
	$display("ins: SW");
	`endif
	immNumber_o = Imm_16S;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_ADD_OP;
	memOp_o = `MEM_SAVE_WORD;
end
`OP_SH:begin
	`ifdef DEBUG_MODE
	$display("ins: SH");
	`endif
	immNumber_o = Imm_16S;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_ADD_OP;
	memOp_o = `MEM_SAVE_HALF;
end
`OP_SB:begin
	`ifdef DEBUG_MODE
	$display("ins: SB");
	`endif
	immNumber_o = Imm_16S;
	ALUdata2Src_o = `imm;
	ALUoperation_o = `ALU_ADD_OP;
	memOp_o = `MEM_SAVE_BYTE;
end
`OP_BEQ:begin
	`ifdef DEBUG_MODE
	$display("ins: BEQ");
	`endif
	immNumber_o = Imm_16S;
	ALUoperation_o = `ALU_NOP_OP;
	isJump_o = 1'b1;
	jumpAddr_o = pcPlusOne_i + (regData1_o==regData2_o?Imm_16S:32'd1);
end
`OP_BNE:begin
	`ifdef DEBUG_MODE
	$display("ins: BNE");
	`endif
	immNumber_o = Imm_16S;
	ALUoperation_o = `ALU_NOP_OP;
	isJump_o = 1'b1;
	jumpAddr_o = pcPlusOne_i + (regData1_o!=regData2_o?Imm_16S:32'd1);
end
`OP_BLT:begin
	`ifdef DEBUG_MODE
	$display("ins: BLT");
	`endif
	immNumber_o = Imm_16S;
	ALUoperation_o = `ALU_NOP_OP;
	isJump_o = 1'b1;
	jumpAddr_o = pcPlusOne_i + (regData1_o<regData2_o?Imm_16S:32'd1);
end
`OP_BLE:begin
	`ifdef DEBUG_MODE
	$display("ins: BLE");
	`endif
	immNumber_o = Imm_16S;
	ALUoperation_o = `ALU_NOP_OP;
	isJump_o = 1'b1;
	jumpAddr_o = pcPlusOne_i + (regData1_o<=regData2_o?Imm_16S:32'd1);
end
`OP_J:begin
	`ifdef DEBUG_MODE
	$display("ins: J");
	`endif
	immNumber_o = Imm_26U;
	ALUoperation_o = `ALU_NOP_OP;
	isJump_o = 1'b1;
	jumpAddr_o = Imm_26U;
end
`OP_JAL:begin
	`ifdef DEBUG_MODE
	$display("ins: JAL");
	`endif
	immNumber_o = Imm_26U;
	ALUdata2Src_o = `PC;
	ALUoperation_o = `ALU_JAL_OP;
	ALUToReg_o = 1'b1;
	RegWrite_o = 1'b1;
	WriteRegDst_o = 5'd31;
	isJump_o = 1'b1;
	jumpAddr_o = Imm_26U;
end
`OP_JR:begin
	`ifdef DEBUG_MODE
	$display("ins: JR");
	`endif
	ALUoperation_o = `ALU_NOP_OP;
	isJump_o = 1'b1;
	jumpAddr_o = regData1_o;
end
