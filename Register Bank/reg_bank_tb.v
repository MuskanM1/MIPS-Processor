`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:19:13 08/23/2018
// Design Name:   reg_bank
// Module Name:   C:/Users/student/Desktop/CO_9/lab3/reg_bank_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: reg_bank
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module reg_bank_tb;

	// Inputs
	reg [15:0] ans_ex;
	reg [15:0] ans_dm;
	reg [15:0] ans_wb;
	reg [15:0] imm;
	reg [4:0] RA;
	reg [4:0] RB;
	reg [4:0] RW_dm;
	reg [1:0] mux_sel_A;
	reg [1:0] mux_sel_B;
	reg clk;
	reg imm_sel;

	// Outputs
	wire [15:0] A;
	wire [15:0] B;

	// Instantiate the Unit Under Test (UUT)
	reg_bank uut (
		.ans_ex(ans_ex), 
		.ans_dm(ans_dm), 
		.ans_wb(ans_wb), 
		.imm(imm), 
		.RA(RA), 
		.RB(RB), 
		.RW_dm(RW_dm), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.clk(clk), 
		.imm_sel(imm_sel), 
		.A(A), 
		.B(B)
	);

	initial begin
		// Initialize Inputs
		ans_ex = 16'hC000;
		ans_dm = 16'hD000;
		ans_wb = 16'hE000;
		imm = 16'hFFFF;
		RA = 5'b00101;
		RB = 5'b00110;
		RW_dm = 5'b00111;
		mux_sel_A = 2'b00;
		mux_sel_B = 2'b00;
		clk = 0;
		imm_sel = 1;

		// Wait 100 ns for global reset to finish
		
		#10;
		RB = 5'b00111;
		mux_sel_A = 2'b10;
		mux_sel_B = 2'b01;
		imm_sel = 1'b0;
		
		#10;
		mux_sel_A = 2'b11;
		mux_sel_B = 2'b00; 
		
        
		// Add stimulus here

	end
	
	always #5 clk = ~clk;
      
endmodule

