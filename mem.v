`include "defines.v"

module mem(
	input wire clk,
	input wire rst,
	
	//input
	//data
	input wire[31:0] result_i,
	input wire[31:0] MemData_i,
	//signal
	input wire RegWrite_i,
	input wire[4:0] WriteRegDst_i,
	input wire[2:0] MemOp_i,
	
	//output
	//for MEM-WB
	output reg[31:0] WriteRegData_o,
	
	//bypass
	output wire RegWrite_o,
	output wire[4:0] WriteRegDst_o
	
	);
	
	//Memory File
	reg[7:0] memories[0:1023];
	
	reg[31:0] readdata;
	
	assign RegWrite_o = RegWrite_i;
	assign WriteRegDst_o = WriteRegDst_i;

	always @(*) begin
		WriteRegData_o = `ZeroWord;
		readdata = `ZeroWord;
	
		case(MemOp_i)
			`MEM_NOP_OP: begin
				WriteRegData_o = result_i;
			end
			`MEM_LOAD_WORD: begin
				readdata = {memories[{result_i[9:2], 2'b11}], memories[{result_i[9:2], 2'b10}], 
							memories[{result_i[9:2], 2'b01}], memories[{result_i[9:2], 2'b00}]};
				WriteRegData_o = readdata;
			end
			`MEM_LOAD_HALF: begin
				readdata = {16'd0, 
							memories[{result_i[9:1], 1'b1}], memories[{result_i[9:1], 1'b0}]};
				WriteRegData_o = {{16{readdata[15]}},readdata[15:0]};
			end
			`MEM_LOAD_BYTE: begin
				readdata = {24'd0, memories[result_i[9:0]]};
				WriteRegData_o = {{24{readdata[7]}},readdata[7:0]};
			end
			
		endcase
	end
	
	always @(posedge clk) begin
		if (!rst) begin
		
		end else begin
			case(MemOp_i)
				`MEM_SAVE_WORD: begin
					{memories[{result_i[9:2], 2'b11}], memories[{result_i[9:2], 2'b10}], 
						memories[{result_i[9:2], 2'b01}], memories[{result_i[9:2], 2'b00}]} = MemData_i;
				end
				`MEM_SAVE_HALF: begin
					{memories[{result_i[9:1], 1'b1}], memories[{result_i[9:1], 1'b0}]} = MemData_i[15:0];
				end
				`MEM_SAVE_BYTE: begin
					memories[result_i[9:0]] = MemData_i[7:0];
				end
			endcase
		end
	end
endmodule