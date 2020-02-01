`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:24:30 08/30/2018
// Design Name:   stall_control_block
// Module Name:   E:/G12/microprocessor/stall_control_block_tb.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: stall_control_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stall_control_block_tb;

	// Inputs
	reg [5:0] op;
	reg clk;
	reg reset;

	// Outputs
	wire stall;
	wire stall_pm;

	// Instantiate the Unit Under Test (UUT)
	stall_control_block uut (
		.op(op), 
		.clk(clk), 
		.reset(reset), 
		.stall(stall), 
		.stall_pm(stall_pm)
	);

	initial begin
		// Initialize Inputs
		op = 6'b0;
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#2;
      reset = 0;
		
		#6;
		reset = 1;
		
		#8
		op = 6'b010100;
		
		#20
		op = 6'b0;
		
		#10;
		op = 6'b011110;
		
		#30;
		op = 6'b0;
		
		#10;
		op = 6'b010001;
	end
	
	always #5
	clk = ~clk;
      
endmodule

