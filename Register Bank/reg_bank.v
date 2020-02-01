`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:21 08/23/2018 
// Design Name: 
// Module Name:    reg_bank 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module reg_bank(ans_ex,ans_dm,ans_wb,imm,RA,RB,RW_dm,mux_sel_A,mux_sel_B,clk,imm_sel,A,B);

input [15:0] ans_ex,ans_dm,ans_wb,imm;
input [4:0] RA,RB,RW_dm;
input [1:0] mux_sel_A,mux_sel_B;
input imm_sel,clk;
output [15:0] A,B;
reg [15:0] register_bank [31:0];

reg [15:0] AR,BR;
wire [15:0] BI;
always @(posedge clk)
begin
	AR = register_bank[RA];
	BR = register_bank[RB];
	register_bank[RW_dm]=ans_dm;
end


assign A = (mux_sel_A == 2'b11)? ans_wb : 
			  (mux_sel_A == 2'b10)? ans_dm :
			  (mux_sel_A == 2'b01)? ans_ex :
			  AR;

assign BI = (mux_sel_B == 2'b11)? ans_wb : 
			  (mux_sel_B == 2'b10)? ans_dm :
			  (mux_sel_B == 2'b01)? ans_ex :
			  BR;
			  
assign B = (imm_sel == 1'b1)? imm : BI;

endmodule

