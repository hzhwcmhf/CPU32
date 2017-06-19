`include "defines.v"

module exe(
	//input
	input wire[31:0] data1, //data1 is reg1

	input wire[31:0] reg2_i,
	input wire[31:0] imm_i,
	input wire[31:0] pcPlusOne_i,

	input wire[1:0] ALUdata2Src_i,
	input wire[3:0] ALUoperation_i,

	//bypass
	input wire ALUToReg_i,
	input wire[4:0] WriteRegDst_i,
	//conflict
	input wire MemToReg_i,

	output reg[31:0] result_o,
	output wire[31:0] MemData_o,
	//bypass
	output wire ALUToReg_o,
	output wire[4:0] WriteRegDst_o,
	//conflict
	output wire MemToReg_o
	);

	reg[31:0] data2;

	//pass control signal to ID
	assign ALUToReg_o = ALUToReg_i;
	assign WriteRegDst_o = WriteRegDst_i;
	assign MemToReg_o = MemToReg_i;

	//choose data2
	always @(*) begin
		case (ALUdata2Src_i)
		`reg2: data2 = reg2_i;
		`imm:  data2 = imm_i;
		`PC:   data2 = pcPlusOne_i;
		default: data2 = reg2_i;
		endcase
	end

	//calculate result_o
	always @(*) begin
		case(ALUoperation_i)
		`ALU_ADD_OP:    result_o = data1 + data2;
		`ALU_SUB_OP:    result_o = data1 - data2;
		`ALU_DATA2_OP:  result_o = data2;
		`ALU_AND_OP:    result_o = data1 & data2;
		`ALU_OR_OP: 	result_o = data1 | data2;
		`ALU_XOR_OP: 	result_o = data1 ^ data2;
		`ALU_NOR_OP: 	result_o = ~(data1 | data2);
		`ALU_SLL_OP:	result_o = data1 << imm_i;
		`ALU_SRL_OP:	result_o = data1 >>> imm_i;
		`ALU_SRA_OP:	result_o = {{31{data1[31]}},data1}>>imm_i;
		`ALU_JAL_OP:	result_o = data2 + 32'd1;
		default: 		result_o = 16'd0;
		endcase
	end

	assign MemData_o = reg2_i;
	
endmodule