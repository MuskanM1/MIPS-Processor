
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:03:21 08/04/2018 
// Design Name: 
// Module Name:    ExeBlock
// Project Name: Assignment 1
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
module ExeBlock(data_out,ans_ex,DM_data,flag_ex,A,B,op_dec,data_in,clk,reset);

input[15:0] A,B,data_in;
input [5:0] op_dec;
input clk,reset;
output reg[15:0] ans_ex,data_out,DM_data;
output [1:0] flag_ex;

wire [15:0] Bx,sum,ans_tmp,data_out_buff,rsa_out;
wire [1:0] flag_prv;
wire cout,c,V,Z,Z1;


//arithmetic 
assign Bx = (B^{16{op_dec[0]}})+{15'b000000000000000,op_dec[0]};
assign {cout,sum[14:0]} = A[14:0] + Bx[14:0];

assign {c,sum[15]} = A[15] + Bx[15] + cout;
assign V = cout^c;
assign Z = |sum;

assign rsa_out=((B[3:0]==4'b0001)?{A[15],A[15:1]}:(B[3:0]==4'b0010)?{{2{A[15]}},A[15:2]}:(B[3:0]==4'b0011)?{{3{A[15]}},A[15:3]}:(B[3:0]==4'b0100)?{{4{A[15]}},A[15:4]}:
(B[3:0]==4'b0101)?{{5{A[15]}},A[15:5]}:(B[3:0]==4'b0110)?{{6{A[15]}},A[15:6]}:(B[3:0]==4'b0111)?{{7{A[15]}},A[15:7]}:(B[3:0]==4'b1000)?{{8{A[15]}},A[15:8]}:(B[3:0]==4'b1001)?{{9{A[15]}},A[15:9]}:
(B[3:0]==4'b1010)?{{10{A[15]}},A[15:10]}:(B[3:0]==4'b1011)?{{11{A[15]}},A[15:11]}:(B[3:0]==4'b1100)?{{12{A[15]}},A[15:12]}:(B[3:0]==4'b1101)?{{13{A[15]}},A[15:13]}:(B[3:0]==4'b1110)?{{14{A[15]}},A[15:14]}:
(B[3:0]==4'b1111)?{16{A[15]}}:A);


assign ans_tmp = ((op_dec == 6'b000000 || op_dec == 6'b001000 || op_dec == 6'b001001 || op_dec == 6'b000001 ) ? sum : 
(op_dec == 6'b000010 || op_dec == 6'b001010 ? B : ( op_dec == 6'b000100 || op_dec == 6'b001100 ? A&B : 
(op_dec == 6'b000101 || op_dec == 6'b001101 ? A|B : (op_dec == 6'b000110 || op_dec == 6'b001110 ? A^B : 
(op_dec == 6'b000111 || op_dec == 6'b001111 ? ~B : (op_dec == 6'b010000 || op_dec == 6'b010001 || op_dec == 6'b010111 
|| op_dec == 6'b011000 || op_dec == 6'b011100 || op_dec == 6'b011101 || op_dec == 6'b011110 || op_dec == 6'b011111 ? 
ans_ex : (op_dec == 6'b010100 || op_dec == 6'b010101 ? A : (op_dec == 6'b010110 ? data_in : (op_dec == 6'b011001 ? A<<B :
 (op_dec == 6'b011010 ? A>>B : (rsa_out))))))))))));

assign Z1 = |ans_tmp;

//overflow flag
assign flag_ex[0] = ((op_dec == 6'b000000 || op_dec == 6'b001000 || op_dec == 6'b001001 || op_dec == 6'b000001 ) ? V : 
(op_dec == 6'b000010 || op_dec == 6'b000100 || op_dec == 6'b000101 || op_dec == 6'b000110 || op_dec == 6'b000111 || 
op_dec == 6'b001010 || op_dec == 6'b001100 || op_dec == 6'b001101 || op_dec == 6'b001110 || op_dec == 6'b001111 || 
op_dec == 6'b010000 || op_dec == 6'b010001 || op_dec == 6'b010100 || op_dec == 6'b010101 || op_dec == 6'b010110 || 
op_dec == 6'b010111 || op_dec == 6'b011000 || op_dec == 6'b011001 || op_dec == 6'b011010 || op_dec == 6'b011011 ? 1'b0 : 
flag_prv[0] ));

//zero flag
assign flag_ex[1] = ((op_dec == 6'b000000 || op_dec == 6'b001000 || op_dec == 6'b001001 || op_dec == 6'b000001 ) ? ~Z : 
(op_dec == 6'b000010 || op_dec == 6'b000100 || op_dec == 6'b000101 || op_dec == 6'b000110 || op_dec == 6'b000111 || 
op_dec == 6'b001010 || op_dec == 6'b001100 || op_dec == 6'b001101 || op_dec == 6'b001110 || op_dec == 6'b001111 || 
op_dec == 6'b010110 || op_dec == 6'b011001 || op_dec == 6'b011010 || op_dec == 6'b011011 ? ~Z1 : (op_dec == 6'b010000 || 
op_dec == 6'b010001 || op_dec == 6'b010100 || op_dec == 6'b010101 || op_dec == 6'b010111 || op_dec == 6'b011000 ? 1'b0 : 
flag_prv[1] )));

//data_out
assign data_out_buff = (op_dec == 6'b010111) ? A : data_out;
assign flag_prv = (reset == 1'b0)? 2'b00 : flag_ex;
//register block
always@(posedge clk)
begin 
	if(reset == 0)
	begin
		ans_ex <= 16'b0000000000000000;
		data_out <= 16'b0000000000000000;
		DM_data<=16'b0000000000000000;
	end
	
	else
	begin
		DM_data<=B;
		ans_ex <= ans_tmp;
		data_out <= data_out_buff;
	end
	
end

endmodule


