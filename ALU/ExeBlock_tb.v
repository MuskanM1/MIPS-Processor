`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:32:46 08/07/2018
// Design Name:   ExeBlock
// Module Name:   F:/ExeBlock/ExeBlock_tb.v
// Project Name:  ExeBlock
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ExeBlock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ExeBlock_tb;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [5:0] op_dec;
	reg [15:0] data_in;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] data_out;
	wire [15:0] ans_ex;
	wire [15:0] DM_data;
	wire [1:0] flag_ex;

	// Instantiate the Unit Under Test (UUT)
	ExeBlock uut (
		.data_out(data_out), 
		.ans_ex(ans_ex), 
		.DM_data(DM_data), 
		.flag_ex(flag_ex), 
		.A(A), 
		.B(B), 
		.op_dec(op_dec), 
		.data_in(data_in), 
		.clk(clk), 
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

		#2 
		reset=0;
		#8
		reset=1;	
		//no 1
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b000000;
		//no2
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b000001;
		//no 3
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b000010;
		//no 4
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b000100;
		//no 5
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b000101;
		//no 6
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b000110;
		//no 7
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b000111;
		//no 8
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b001000;
		//no 9
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b001001;
		//no 10
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b001010;
		//no 11
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b001100;
		//no 12
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b001101;
		//no 13
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b001110;
		//no 14
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b001111;
		//no 15
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b010000;
		//no 16
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b010001;
		//no 17
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b010100;
		//no 18
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b010101;
		//no 19
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b010110;
		//no 20
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b010111;
		//no 21
		#10
		A=16'h4000;
		B=16'hC000;
		data_in=16'h0008;
		op_dec=6'b011000;
		//no 22
		#10
		A=16'hC000;
		B=16'h0001;
		data_in=16'h0008;
		op_dec=6'b011001;
		//no 23
		#10
		A=16'hC000;
		B=16'h0001;
		data_in=16'h0008;
		op_dec=6'b011010;
		//no 24
		#10
		A=16'hC000;
		B=16'h0001;
		data_in=16'h0008;
		op_dec=6'b011011;
		//no 25
		#10
		A=16'hC000;
		B=16'h0001;
		data_in=16'h0008;
		op_dec=6'b011100;
		//no 26
		#10
		A=16'hC000;
		B=16'h0001;
		data_in=16'h0008;
		op_dec=6'b011101;
		//no 27
		#10
		A=16'hC000;
		B=16'h0001;
		data_in=16'h0008;
		op_dec=6'b011110;
		//no 5
		#10
		A=16'hC000;
		B=16'h0001;
		data_in=16'h0008;
		op_dec=6'b011111;
		
		
	end
	
   always #5 clk=~clk; 
endmodule

