`include "defines.v"

module ex_mem(
	input wire clk,
	input wire rst,

	//input
	//Data
	input wire[31:0] result_i,
	input wire[31:0] MemData_i,
	//MEM
	input wire[2:0] MemOp_i,
	input wire[4:0] WriteRegDst_i,
	input wire RegWirte_i,

	//flow control
	input wire[1:0] ExMemOp_i,
	
	//output
	//Data
	output reg[31:0] result_o,
	output reg[31:0] MemData_o,
	//Control Signal
	//MEM
	output reg[2:0] MemOp_o,
	output reg[4:0] WriteRegDst_o,
	output reg RegWirte_o
	
	`ifdef DEBUG_MODE
	,
	input wire[31:0] ins_i,
	output reg[31:0] ins_o
	`endif
	);

	always @(posedge clk) begin
		if (!rst || ExMemOp_i == `RST_OP) begin
			//data
			result_o <= `ZeroWord;
			MemData_o <= `ZeroWord;
			//MEM
			MemOp_o <= `DEFAULT_memOp;
			WriteRegDst_o <= `DEFAULT_RegWrite;
			RegWirte_o <= `DEFAULT_RegWrite;
			
			`ifdef DEBUG_MODE
			ins_o = `INS_NOP;
			`endif
		end else begin
			if(ExMemOp_i == `NORMAL_OP) begin
				//data
				result_o <= result_i;
				MemData_o <= MemData_i;
				//MEM
				MemOp_o <= MemOp_i;
				WriteRegDst_o <= WriteRegDst_i;
				RegWirte_o <= RegWirte_i;

				`ifdef DEBUG_MODE
				ins_o = ins_i;
				`endif
			end
		end
		
		`ifdef DEBUG_MODE
		#3;
		$display("EX:	result: %x		MemData: %x		instruction: %x", result_o, MemData_o, ins_o);
		`endif
	end

endmodule
