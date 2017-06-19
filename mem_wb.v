`include "defines.v"

module mem_wb(
	input wire clk,
	input wire rst,

	//input
	//Data
	input wire[31:0] WriteRegData_i,
	//WB
	input wire[4:0] WriteRegDst_i,
	input wire RegWrite_i,

	//flow control
	input wire[1:0] MemWbOp_i,
	
	//output
	//Data
	output reg[31:0] WriteRegData_o,
	//Control Signal
	//WB
	output reg[4:0] WriteRegDst_o,
	output reg RegWrite_o
	
	`ifdef DEBUG_MODE
	,
	input wire[31:0] ins_i,
	output reg[31:0] ins_o
	`endif
	);

	always @(posedge clk) begin
		if (!rst || MemWbOp_i == `RST_OP) begin
			//data
			WriteRegData_o <= `ZeroWord;
			//WB
			WriteRegDst_o <= `DEFAULT_WriteRegDst;
			RegWrite_o <= `DEFAULT_RegWrite;
			
			`ifdef DEBUG_MODE
			ins_o = `INS_NOP;
			`endif
		end else begin
			if(MemWbOp_i == `NORMAL_OP) begin
				//data
				WriteRegData_o <= WriteRegData_i;
				//WB
				WriteRegDst_o <= WriteRegDst_i;
				RegWrite_o <= RegWrite_i;

				`ifdef DEBUG_MODE
				ins_o = ins_i;
				`endif
			end
		end
		
		`ifdef DEBUG_MODE
		#4;
		$display("MEM:	RegWrite:%b WriteRegDst:%x writeRegData: %x	instruction: %x", RegWrite_o, WriteRegDst_o, WriteRegData_o, ins_o);
		`endif
	end

endmodule
