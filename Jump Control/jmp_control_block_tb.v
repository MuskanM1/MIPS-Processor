`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:24:45 09/06/2018
// Design Name:   jmp_control_block
// Module Name:   C:/Users/student/Desktop/CO_9/Jump_control_block/jmp_control_block_tb.v
// Project Name:  Jump_control_block
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: jmp_control_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module jmp_control_block_tb;

	// Inputs
	reg [15:0] jmp_address_pm;
	reg [15:0] current_address;
	reg [5:0] op;
	reg [1:0] flag_ex;
	reg interrupt;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] jmp_loc;
	wire pc_mux_sel;

	// Instantiate the Unit Under Test (UUT)
	jmp_control_block uut (
		.jmp_address_pm(jmp_address_pm), 
		.current_address(current_address), 
		.op(op), 
		.flag_ex(flag_ex), 
		.interrupt(interrupt), 
		.clk(clk), 
		.reset(reset), 
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel)
	);

	initial begin
		// Initialize Inputs
		jmp_address_pm = 16'b0000000000000000;
		current_address = 16'b0000000000000001;
		op = 6'b000000;
		flag_ex = 2'b11;
		interrupt = 0;
		clk = 0;
		reset = 1'b1;

		// Wait 100 ns for global reset to finish
		#2;
		reset = 1'b0;
		
		#6;
		reset = 1'b1;
		
		#8;
		interrupt = 1'b1;
		
		#10;
		interrupt = 1'b0;
		jmp_address_pm = 16'b0000000000001000;
		
		#10;
		op = 6'b011000;
		
		#20;
		flag_ex = 2'b00;
		op = 6'b010000;
		
		#10;
		op = 6'b011110;
		
        
		// Add stimulus here

	end
	
	always #5 clk = ~clk;
      
endmodule

