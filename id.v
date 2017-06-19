`include "defines.v"

module id(
	//Input    
	//PC
	input wire[31:0] pcPlusOne_i,
	input wire[31:0] ins_i,

	//Registers
	input wire[31:0] regData1_i,
	input wire[31:0] regData2_i,

	//EX
	//bypass
	input wire ex_MemToReg_i,
	input wire ex_ALUToReg_i,
	input wire[4:0] ex_WriteRegDst_i,
	input wire[31:0] ex_result_i,

	//MEM
	//bypass
	input wire mem_RegWrite_i,
	input wire[4:0] mem_WriteRegDst_i,
	input wire[31:0] mem_WriteRegData_i,

	//Output
	//Registers
	output reg[4:0] regSrc1_o,
	output reg[4:0] regSrc2_o,

	//ID_EX
	output wire[31:0] pcPlusOne_o,
	output reg[31:0] regData1_o,
	output reg[31:0] regData2_o,
	output reg[31:0] immNumber_o,

	//ID-PC
	output reg[31:0] jumpAddr_o,

	//controller
	//PC
	output reg isJump_o,

	//EX
	output reg[3:0] ALUoperation_o,
	output reg[1:0] ALUdata2Src_o,
	output reg ALUToReg_o,

	//MEM
	output reg[2:0] memOp_o,

	//EX MEM
	output reg MemToReg_o,

	//WB
	output reg RegWrite_o,

	//EX MEM WB
	output reg[4:0] WriteRegDst_o,
	
	//conflict 
	output wire IdPauseRequest_o
	);

	//Pass
	assign pcPlusOne_o = pcPlusOne_i;

	//Instruction Decoding Variables
	wire[4:0] rs = ins_i[25:21];
	wire[4:0] rt = ins_i[20:16];
	wire[4:0] rd = ins_i[15:11];

	wire[31:0] Imm_16S = {{16{ins_i[15]}},ins_i[15:0]};
	wire[31:0] Imm_16US = {ins_i[15:0], 16'd0};
	wire[31:0] Imm_16U = {16'd0, ins_i[15:0]};
	wire[31:0] Imm_5U = {27'd0, ins_i[10:6]};
	wire[31:0] Imm_26U = {6'd0, ins_i[25:0]};

    //regData1 - bypass
	always @(*) begin
		if (ex_ALUToReg_i == `Enable && regSrc1_o == ex_WriteRegDst_i) begin
			regData1_o = ex_result_i;
		end else if ( mem_RegWrite_i == `Enable && regSrc1_o == mem_WriteRegDst_i) begin
			regData1_o = mem_WriteRegData_i;
		end else begin
			regData1_o = regData1_i;
		end
	end

    //regData2 - bypass
	always @(*) begin
		if (ex_ALUToReg_i == `Enable && regSrc2_o == ex_WriteRegDst_i) begin
			regData2_o = ex_result_i;
		end else if ( mem_RegWrite_i == `Enable && regSrc2_o == mem_WriteRegDst_i) begin
			regData2_o = mem_WriteRegData_i;
		end else begin
			regData2_o = regData2_i;
		end
	end
	
	assign IdPauseRequest_o = (ex_MemToReg_i == `Enable && 
		(regSrc1_o == ex_WriteRegDst_i || regSrc2_o == ex_WriteRegDst_i))?
		`ID_PAUSE_REQUEST : `NO_PAUSE_REQUEST;
	
    //Decoding
	always @(*) begin
        //Registers
		regSrc1_o = rs;
		regSrc2_o = rt;

		//ID_EX
		immNumber_o = Imm_16U;

		//ID-PC
		jumpAddr_o = 32'd0;

		//controller
		//PC
		isJump_o = `DEFAULT_isJump;

		//EX
		ALUoperation_o = `DEFAULT_ALUoperation;
		ALUdata2Src_o = `DEFAULT_ALUdata2Src;
		ALUToReg_o = `DEFAULT_ALUToReg;

		//MEM
		memOp_o = `DEFAULT_memOp;

		//EX MEM
		MemToReg_o = `DEFAULT_MemToReg;

		//WB
		RegWrite_o = `DEFAULT_RegWrite;

		//EX MEM WB
		WriteRegDst_o = `DEFAULT_WriteRegDst;

		casex (ins_i)
            //Logic Instructions
			`include "id_code.v"
		endcase
	end

endmodule
