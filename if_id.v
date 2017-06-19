`include "defines.v"

module if_id(
	input wire clk,
	input wire rst,

	//input
	input wire[31:0] pcPlusOne_i,
	input wire[31:0] instruction_i,

	//flow control
	input wire[1:0] IfIdOp_i,
	
	//output
	output reg[31:0] pcPlusOne_o,
	output reg[31:0] instruction_o
	);

	always @(posedge clk) begin
		if (!rst || IfIdOp_i == `RST_OP) begin
			pcPlusOne_o <= `ZeroWord;
			instruction_o <= `INS_NOP;
		end else begin
			if(IfIdOp_i == `NORMAL_OP) begin
				pcPlusOne_o <= pcPlusOne_i;
				instruction_o <= instruction_i;
			end
		end
		`ifdef DEBUG_MODE
		#1;
		$display("IF:	instruction: %x	pcPlusOne: %x", instruction_o, pcPlusOne_o);
		`endif
	end

endmodule
