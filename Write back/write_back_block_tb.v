`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:20:59 08/30/2018
// Design Name:   write_back_block
// Module Name:   C:/Users/student/Desktop/CO_9/lab4/write_back_block_tb.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: write_back_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module write_back_block_tb;

	// Inputs
	reg [15:0] ans_dm;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] ans_wb;

	// Instantiate the Unit Under Test (UUT)
	write_back_block uut (
		.ans_dm(ans_dm), 
		.clk(clk), 
		.reset(reset), 
		.ans_wb(ans_wb)
	);

	initial begin
		// Initialize Inputs
		ans_dm = 16'b0000000000000000;
		clk = 0;
		reset = 1'b1;

		// Wait 100 ns for global reset to finish
		#2;
		reset = 1'b0;
		
		#6;
		reset = 1'b1;
		
		#2;
		ans_dm = 16'b0000000000000001;	
		
		#10;
		ans_dm = 16'b0000000000000010;
		
		#10;
		ans_dm = 16'b0000000000000011;
		
		#10;
		ans_dm = 16'b0000000000001111;
		
		
		// Add stimulus here

	end
	
	always #5 clk = ~clk;
      
endmodule

