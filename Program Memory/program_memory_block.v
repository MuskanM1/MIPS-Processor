`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:47 08/16/2018 
// Design Name: 
// Module Name:    program_memory_block 
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
module program_memory_block(jmp_loc, pc_mux_sel, stall, stall_pm, reset, clk, ins, current_address);

input [15:0] jmp_loc;
input pc_mux_sel, stall, stall_pm, reset, clk;

output [31:0] ins;
output [15:0] current_address;
wire [15:0] CAJ,CAR,IA;
wire [31:0] PM_out,ins_pm;
reg [15:0] hold_address,next_address;
reg [31:0] ins_prv;

pm_ip pm (
  .clka(clk), // input clk
  .addra(current_address), // input [15 : 0] current_address
  .douta(PM_out) // output [31 : 0] ins
);

assign CAJ = (stall==1'b0 ? next_address : hold_address);
assign CAR = (pc_mux_sel==1'b0 ? CAJ : jmp_loc);
assign current_address = (reset==1'b0 ? 16'b0000000000000000 : CAR);

assign IA = current_address + 16'b0000000000000001;

always@(posedge clk)
begin
	if(reset == 0)
	begin
		next_address<=16'b0000000000000000;
		hold_address<=16'b0000000000000000;
	end
	else
	begin
		next_address<=IA;
		hold_address<=current_address;
	end
	
end

always@(posedge clk)
begin
	if(reset == 0)
	begin
		ins_prv <= 32'b00000000000000000000000000000000;
	end
	else
	begin
		ins_prv <= ins;	
	end
end

assign ins_pm = (stall_pm == 1'b0 ? PM_out : ins_prv);
assign ins = (reset==1'b0 ? 32'b00000000000000000000000000000000 : ins_pm);



endmodule