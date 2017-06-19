`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:04:49 06/03/2017
// Design Name:   cpu_controller
// Module Name:   C:/Users/hzhwcmhf/project/CPU32/test_CPU.v
// Project Name:  CPU32
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cpu_controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_CPU;

	// Inputs
	reg clk;
	reg rst;

	// Instantiate the Unit Under Test (UUT)
	cpu_controller uut (
		.clk(clk), 
		.rst(rst)
	);
	
	integer i;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

      #10 clk = 1;
		#10 clk = 0;
		#10 clk = 1;
		#10 rst = 1;
		
		for(i = 0; i< 1000; i = i+1) begin
			#10 clk = !clk;
		end
		
	end
      
endmodule

