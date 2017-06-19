`include "defines.v"

module flow_controller(
	//input 
	input wire IdPauseRequest_i,
	
	//output
	output reg[1:0] PcOp_o,
	output reg[1:0] IfIdOp_o,
	output reg[1:0] IdExOp_o,
	output reg[1:0] ExMemOp_o,
	output reg[1:0] MemWbOp_o
	);
	
	always @(*) begin
		if(IdPauseRequest_i == `ID_PAUSE_REQUEST) begin
			PcOp_o = `PAUSE_OP;
			IfIdOp_o = `PAUSE_OP;
			IdExOp_o = `RST_OP;	
			ExMemOp_o = `NORMAL_OP;
			MemWbOp_o = `NORMAL_OP;
		end else begin
			PcOp_o = `NORMAL_OP;
			IfIdOp_o = `NORMAL_OP;
			IdExOp_o = `NORMAL_OP;
			ExMemOp_o = `NORMAL_OP;
			MemWbOp_o = `NORMAL_OP;
		end
	end
	
endmodule
