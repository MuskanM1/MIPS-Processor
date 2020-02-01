`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:03:45 08/30/2018 
// Design Name: 
// Module Name:    stall_control_block 
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
module stall_control_block(op, clk, reset, stall, stall_pm);

input [5:0] op;
input clk, reset;
output stall, stall_pm;
wire hlt, ld, jmp;
reg q1,q2,q3,q4;

assign hlt = op[0] & (~op[1]) & (~op[2]) & (~op[3]) & (op[4]) & (~op[5]);
assign ld = (~op[0]) & (~op[1]) & (op[2]) & (~op[3]) & (op[4]) & (~op[5]) & ~q1;
assign jmp = (op[2]) & (op[3]) & (op[4]) & (~op[5]) & ~q4;
assign stall = (hlt | ld | jmp);

always @(posedge clk)
begin
	if(reset == 1)
	begin
	q1 <= ld;
	q2 <= stall;
	q3 <= jmp;
	q4 <= q3;
	end

	else
	begin
	q1 <= 0;
	q2 <= 0;
	q3 <= 0;
	q4 <= 0;
	end

end

assign stall_pm = q2;

endmodule
