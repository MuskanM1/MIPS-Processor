`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:45:14 09/27/2018 
// Design Name: 
// Module Name:    processor 
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
module processorf(data_out,data_in,clk,reset,interrupt);
	 
input [15:0] data_in;
input clk,reset,interrupt;

output [15:0] data_out;
wire [15:0] A , B , Current_Address,ans_dm,ans_wb;
wire [31:0] ins;
wire [1:0] mux_sel_A,mux_sel_B;
wire imm_sel;

wire stall_pm,stall;
wire [5:0] op;
wire mem_en_ex,mem_rw_ex,mem_mux_sel_dm;
wire [15:0] jmp_loc,ans_ex;
wire [1:0] flag_ex;
wire [4:0] RA = ins[20:16];
wire [4:0] RB = ins[15:11];
wire [15:0] jmp_address_pm = ins[15:0];
wire [15:0] current_address;
wire [15:0] imm,DM_data;
wire [4:0] RW_dm;

DC_block d1(ins,clk,reset,imm,op,RW_dm,mux_sel_A,mux_sel_B,imm_sel,mem_en_ex,mem_rw_ex,mem_mux_sel_dm);

stall_control_block s1(op, clk, reset, stall, stall_pm);

jmp_control_block j1(jmp_address_pm,current_address,op,flag_ex,interrupt,clk,reset,jmp_loc,pc_mux_sel);

program_memory_block p1(jmp_loc, pc_mux_sel, stall, stall_pm, reset, clk, ins, current_address);

reg_bank r1(ans_ex,ans_dm,ans_wb,imm,RA,RB,RW_dm,mux_sel_A,mux_sel_B,clk,imm_sel,A,B);

ExeBlock e1(data_out,ans_ex,DM_data,flag_ex,A,B,op,data_in,clk,reset);

data_memory_block d2(ans_ex, DM_data, mem_rw_ex, mem_en_ex, mem_mux_sel_dm, reset, clk, ans_dm);

write_back_block w1(ans_dm,clk,reset,ans_wb);

assign Current_Address = current_address;

endmodule