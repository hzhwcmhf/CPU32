`include "defines.v"

module id_ex(
	input wire clk,
	input wire rst,

	//input
	//Data
	input wire[31:0] pcPlusOne_i,
	input wire[31:0] reg1Data_i,
	input wire[31:0] reg2Data_i,
	input wire[31:0] imm_i,

	//Control Signal
	//EXE
	input wire[3:0] ALUoperation_i,
	input wire[1:0] ALUdata2Src_i,
	input wire ALUToReg_i,

	//MEM
	input wire MemToReg_i,
	input wire[2:0] MemOp_i,
	//MEM and WB
	input wire[4:0] WriteRegDst_i,
	//WB
	input wire RegWirte_i,

	//flow control
	input wire[1:0] IdExOp_i,
	
	//output
	//Data
	output reg[31:0] pcPlusOne_o,
	output reg[31:0] reg1Data_o,
	output reg[31:0] reg2Data_o,
	output reg[31:0] imm_o,

	//Control Signal
	//EXE
	output reg[3:0] ALUoperation_o,
	output reg[1:0] ALUdata2Src_o,
	output reg ALUToReg_o,

	//MEM
	output reg MemToReg_o,
	output reg[2:0] MemOp_o,
	//MEM and WB
	output reg[4:0] WriteRegDst_o,
	//WB
	output reg RegWrite_o
	
	
	`ifdef DEBUG_MODE
	,
	input wire[31:0] ins_i,
	output reg[31:0] ins_o
	`endif
	);

	always @(posedge clk) begin
		if (!rst || IdExOp_i == `RST_OP) begin
			//data
			pcPlusOne_o <= `ZeroWord;
			reg1Data_o <= `ZeroWord;
			reg2Data_o <= `ZeroWord;
			imm_o <= `ZeroWord;
			//exe
			ALUoperation_o <= `DEFAULT_ALUoperation;
			ALUdata2Src_o <= `DEFAULT_ALUdata2Src;
			ALUToReg_o <= `DEFAULT_ALUToReg;
			//MEM
			MemToReg_o <= `DEFAULT_MemToReg;
			MemOp_o <= `DEFAULT_memOp;
			//MEM AND WB
			WriteRegDst_o <= `DEFAULT_WriteRegDst;
			//WB
			RegWrite_o <= `DEFAULT_RegWrite;
			
			`ifdef DEBUG_MODE
			ins_o = `INS_NOP;
			`endif
		end else begin
			if (IdExOp_i == `NORMAL_OP) begin
				//data
				pcPlusOne_o <= pcPlusOne_i;
				reg1Data_o <= reg1Data_i;
				reg2Data_o <= reg2Data_i;
				imm_o <= imm_i;
				//EXE
				ALUoperation_o <= ALUoperation_i;
				ALUdata2Src_o <= ALUdata2Src_i;
				ALUToReg_o <= ALUToReg_i;
				//MEM
				MemToReg_o <= MemToReg_i;
				MemOp_o <= MemOp_i;
				//MEM AND WB
				WriteRegDst_o <= WriteRegDst_i;
				//WB
				RegWrite_o <= RegWirte_i;
				
				`ifdef DEBUG_MODE
				ins_o = ins_i;
				`endif
			end
		end
		
		`ifdef DEBUG_MODE
		#2;
		$display("ID:	reg1: %x		reg2: %x		imm: %x		pcPlusOne: %x	instruction: %x", reg1Data_o, reg2Data_o, imm_o, pcPlusOne_o, ins_o);
		`endif
	end

endmodule
