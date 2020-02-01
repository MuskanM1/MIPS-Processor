`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:46:33 08/16/2018
// Design Name:   program_memory_block
// Module Name:   E:/grp12-sem3/microprocessor/program_memory_block_tb.v
// Project Name:  microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: program_memory_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module program_memory_block_tb;

	// Inputs
	reg [15:0] jmp_loc;
	reg pc_mux_sel;
	reg stall;
	reg stall_pm;
	reg reset;
	reg clk;

	// Outputs
	wire [31:0] ins;
	wire [15:0] current_address;

	// Instantiate the Unit Under Test (UUT)
	program_memory_block uut (
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel), 
		.stall(stall), 
		.stall_pm(stall_pm), 
		.reset(reset), 
		.clk(clk), 
		.ins(ins), 
		.current_address(current_address)
	);

	initial begin
		// Initialize Inputs
		jmp_loc = 16'h0008;
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		reset = 1;
		clk = 0;
		// Wait 100 ns for global reset to finish
		#2
		reset = 0;
		
		#6
		reset = 1;
		
		#2
		pc_mux_sel = 0;
		
		#30
		stall = 1;
		
		#10
		stall = 0;
		stall_pm = 1;
		
		#10
		stall_pm = 0;
		pc_mux_sel = 1;
		
		// Add stimulus here

	end
	
	 always #5 clk=~clk; 
endmodule

