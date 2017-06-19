`include "defines.v"

module if_module(
	input wire[31:0] insAddr_i,
	output wire[31:0] ins_o
	);
	
	reg[31:0] ins[0:255];
	assign ins_o = ins[insAddr_i];
	
	initial
	$readmemb("c:/sample.bnr", ins);
	
endmodule