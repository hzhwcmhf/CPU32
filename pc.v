`include "defines.v"

module pc(
	input wire clk,
	input wire rst,

	//Control signal from ID
	input wire isJump_i,
	input wire[31:0] jumpAddr_i,
	
	//flow control
	input wire[1:0] PcOp_i,
	
	//for IF
	output reg[31:0] insAddr_o,
	//for IF-ID
	output wire[31:0] pcPlusOne_o
	);
	
	assign pcPlusOne_o = insAddr_o + 32'd1;
	
	reg[31:0] nextInsAddr;
	
	always @(*) begin
		nextInsAddr = insAddr_o;
		
		case(PcOp_i)
			`NORMAL_OP: begin
				case (isJump_i)
					1'b0: nextInsAddr = insAddr_o + 32'd1;
					1'b1: nextInsAddr = jumpAddr_i;
				endcase
			end
			`RST_OP: begin
				nextInsAddr = 32'd0;
			end
			`PAUSE_OP: begin
				nextInsAddr = insAddr_o;
			end
		endcase
	end

	always @(posedge clk) begin
		if (!rst) begin
			insAddr_o <= 32'd0;
		end else begin
			insAddr_o <= nextInsAddr;
		end
		`ifdef DEBUG_MODE
		$display("\nPC:	%x", insAddr_o);
		`endif
	end

endmodule
