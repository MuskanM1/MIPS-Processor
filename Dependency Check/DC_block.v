`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:41:26 09/20/2018 
// Design Name: 
// Module Name:    DC_Block 
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
module DC_block(ins,clk,reset,imm,op_dec,RW_dm,mux_sel_A,mux_sel_B,imm_sel,mem_en_ex,mem_rw_ex,mem_mux_sel_dm);

input clk,reset;
input [31:0] ins;
output reg [15:0] imm;
output reg [5:0] op_dec;
output [4:0] RW_dm;
output [1:0] mux_sel_A , mux_sel_B;
output imm_sel,mem_en_ex,mem_rw_ex,mem_mux_sel_dm;

wire JMP , Cond_J, LD_fb , imm_flag ,ld ,ST ,c1,c2,c3,c4,c5,c6,Pri_a1,Pri_a2,Pri_b1,Pri_b2,D2 , ext_inp;
wire [14:0] ext_out;
wire [14:0] R;
reg [4:0] R1,R2,R3,R3a,R3b,R3c;
reg Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9;

always@(posedge clk)
begin
	if(reset == 1'b0)
	begin 
		Q1 <= 1'b0;
	end
	else
	begin
		Q1 <= LD_fb;
	end
end

always@(posedge clk)
begin
	if(reset == 1'b0)
	begin 
		Q9 <= 1'b0;
	end
	else
	begin
		Q9 <= imm_flag;
	end
end

always@(posedge clk)
begin
	if(reset == 1'b0)
	begin 
		imm <= 16'b0000000000000000;
	end
	else
	begin
		imm <= ins[15:0];
	end
end

always@(posedge clk)
begin
	if(reset == 1'b0)
	begin 
		op_dec <= 6'b000000;
	end
	else
	begin
		op_dec <= ins[31:26];
	end
end

assign JMP = (~ins[31]) & ins[30] & ins[29] & (~ins[28]) & (~ins[27]) & (~ins[26]); 
assign Cond_J = (~ins[31]) & ins[30] & ins[29] & (ins[28]);
assign LD_fb = (~ins[31]) & ins[30] & (~ins[29]) & (ins[28]) & (~ins[27]) & (~ins[26]) & (~Q1); 
assign imm_flag = (~ins[31]) & (~ins[30]) & (ins[29]) ;
assign ld =  (~ins[31]) & ins[30] & (~ins[29]) & (ins[28]) & (~ins[27]) & (~ins[26]);
assign ST =  (~ins[31]) & ins[30] & (~ins[29]) & (ins[28]) & (~ins[27]) & ins[26];
assign D2 =  ld & (~Q2);
assign D5 = (Q2|Q4) & (~Q3);
assign mem_rw_ex = Q6;
assign mem_mux_sel_dm = Q8;
assign mem_en_ex = Q7;
assign imm_sel = Q9;
assign ext_inp = ~(JMP|Cond_J|Q1);
assign ext_out = {15{ext_inp}};
assign R = ext_out & ins[25:11];

assign c1 = (R3a==R2) ? 1'b1 : 1'b0;
assign c2 = (R3b==R2) ? 1'b1 : 1'b0;
assign c3 = (R3c==R2) ? 1'b1 : 1'b0;

assign c4 = (R3a==R1) ? 1'b1 : 1'b0;
assign c5 = (R3b==R1) ? 1'b1 : 1'b0;
assign c6 = (R3c==R1) ? 1'b1 : 1'b0;

assign Pri_a1 = (~c1)&c2;
assign Pri_a2 = (~c1)&(~c2)&c3;

assign Pri_b1 = (~c4)&c5;
assign Pri_b2 = (~c4)&(~c5)&c6;

assign mux_sel_A =  ((c1 == 1) ? 2'b01 : ((Pri_a1 == 1) ? 2'b10 : ((Pri_a2 == 1) ? 2'b11 : 2'b00)));
assign mux_sel_B =  ((c4 == 1) ? 2'b01 : ((Pri_b1 == 1) ? 2'b10 : ((Pri_b2 == 1) ? 2'b11 : 2'b00)));
                                        
always@(posedge clk)
begin 
	if(reset == 1'b0)
	begin 
		R1 <= 5'b00000;
		R2 <= 5'b00000;
		R3 <= 5'b00000;
		
		R3a <= 5'b00000;
		R3b <= 5'b00000;
		R3c <= 5'b00000;
	end
	else
	begin
		R1 <= R[4:0];
		R2 <= R[9:5];
		R3 <= R[14:10];
		
		R3a <= R3;
		R3b <= R3a;
		R3c <= R3b;
	end
end

assign RW_dm = R3b;

always@(posedge clk)
begin 
	if(reset == 1'b0)
	begin 
		Q2 <= 1'b0;
		Q3 <= 1'b0;
		Q4 <= 1'b0;
	end
	else
	begin
		Q2 <= D2;
		Q3 <= ins[26];
		Q4 <= ST;
	end
end

always@(posedge clk)
begin 
	if(reset == 1'b0)
	begin 
		Q5 <= 1'b0;
		Q6 <= 1'b0;
		Q7 <= 1'b0;
		Q8 <= 1'b0;
	end
	else
	begin
		Q5 <= D5;
		Q6 <= Q3;
		Q7 <= (Q2|Q4);
		Q8 <= Q5;
	end
end

endmodule
