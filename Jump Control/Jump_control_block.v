`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:41:32 09/06/2018 
// Design Name: 
// Module Name:    jmp_control_block 
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
module jmp_control_block(
    input [15:0] jmp_address_pm,
    input [15:0] current_address,
    input [5:0] op,
    input [1:0] flag_ex,
    input interrupt,
    input clk,
    input reset,
    output [15:0] jmp_loc,
    output pc_mux_sel
    );

wire jv, jnv, jz, jnz, jmp, ret;
wire [1:0] mux4 , mux5;
wire [15:0] mux1 , mux2 , mux3 , IA;
reg ff1, ff2;
reg [1:0] mux4_out;
reg [15:0] mux1_out;

assign jv = ~op[5] & op[4] & op[3] & op[2] & ~op[1] & ~op[0];
assign jnv = ~op[5] & op[4] & op[3] & op[2] & ~op[1] & op[0];
assign jz = ~op[5] & op[4] & op[3] & op[2] & op[1] & ~op[0];
assign jnz = ~op[5] & op[4] & op[3] & op[2] & op[1] & op[0];
assign jmp = ~op[5] & op[4] & op[3] & ~op[2] & ~op[1] & ~op[0];
assign ret = ~op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0];

always@(posedge clk)
begin
	if(reset == 1'b0)
		ff1 = 1'b0;
	else
		ff1 = interrupt;
end

always@(posedge clk)
begin
	if(reset == 1'b0)
		ff2 = 1'b0;
	else
		ff2 = ff1;
end

always@(posedge clk)
begin
	if(reset == 1'b0)
		mux4_out = 2'b00;
	else
		mux4_out = mux4;
end

always@(posedge clk)
begin
	if(reset == 1'b0)
		mux1_out = 16'b0000000000000000;
	else
		mux1_out = mux1;
end

assign IA = current_address + 16'b0000000000000001;

assign mux4 = (ff2 == 1) ? flag_ex : mux4_out;
assign mux5 = (ret == 1)? mux4_out : flag_ex;
assign pc_mux_sel = (jv & mux5[0]) | (jnv & ~mux5[0]) | (jz & mux5[1]) | (jnz & ~mux5[1]) | jmp | ret | ff1;
assign mux3 = (ff1 == 1)? 16'hf000 : jmp_address_pm;
assign mux1 = (interrupt == 1) ? IA : mux1_out;
assign mux2 = (ret == 1) ? mux1_out : mux3;

assign jmp_loc = mux2;

endmodule
