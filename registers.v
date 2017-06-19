`include "defines.v"

module registers(
	input wire clk,
	input wire rst,

	input wire[4:0] regSrc1_i,
	output wire[31:0] regData1_o,

	input wire[4:0] regSrc2_i,
	output wire[31:0] regData2_o,

	input wire[4:0] writeRegDst_i,
	input wire[31:0] writeRegData_i,
	input wire RegWrite_i
	
	);

	//Register File
	reg[31:0] regs[0:31];

	wire[15:0] nextWriteRegData;

	//Read 1 with forwarding
	assign regData1_o = (regSrc1_i == 5'd0)? 32'd0:
						((RegWrite_i == `Enable && regSrc1_i == writeRegDst_i)? writeRegData_i:regs[regSrc1_i]);
	//Read 2 with forwarding
	assign regData2_o =	(regSrc1_i == 5'd0)? 32'd0:
						((RegWrite_i == `Enable && regSrc2_i == writeRegDst_i)? writeRegData_i:regs[regSrc2_i]);
	
	`ifdef DEBUG_MODE
		reg[3:0] regDst;
		reg[15:0] regData;
	`endif
			
	integer i;
	//Write
	always @(posedge clk) begin
		if (!rst) begin
			for(i = 0; i< 32; i = i+1) begin
				regs[i] <= `ZeroWord;
			end
		end else begin
			regs[writeRegDst_i] <= writeRegData_i;
		end
		`ifdef DEBUG_MODE
		//#4;
		//$display("REGISTER:	regs[0]: %b",regs[4'd0],);
		`endif
	end
endmodule
