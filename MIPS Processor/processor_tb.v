`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:56:40 10/07/2018
// Design Name:   processorf
// Module Name:   C:/Users/Dell/Processor/processor_tb.v
// Project Name:  Processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: processorf
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module processor_tb;

	// Inputs
	reg [15:0] data_in;
	reg clk;
	reg reset;
	reg interrupt;

	// Outputs
	wire [15:0] data_out;
	

	// Instantiate the Unit Under Test (UUT)
	processorf uut (
		.data_out(data_out), 
		.data_in(data_in), 
		.clk(clk), 
		.reset(reset), 
		.interrupt(interrupt)
	);

	initial begin
		// Initialize Inputs
		data_in = 0;
		interrupt = 0;
		clk = 0;
		reset = 1;
		#200;
		reset = 0;
		#500; 
		reset = 1;
		
	end
	
	always #500 clk = ~clk;
      
endmodule
