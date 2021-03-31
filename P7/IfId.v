`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:14 12/01/2020 
// Design Name: 
// Module Name:    IfId 
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
module IfId(
	input clk,
	input reset_If,
	input flush_Mem,
	input ifStall,
	input ifBd_If,
	input [31:0]pc_If,
	input [31:0]instr_If,
	input [4:0]excCode_If,
	
	output reg reset_Id,
	output reg [31:0]pc_Id,
	output reg [31:0]instr_Id,
	output reg [4:0]excCode_Id,
	output reg [4:0]grfRa1_Fs,
	output reg [4:0]grfRa2_Fs,
	output reg ifBd_Mem
    );

	initial begin
		reset_Id 	<=	0;
		pc_Id 		<=	0;
		excCode_Id	<=	0;
		instr_Id 	<=	0;
		grfRa1_Fs 	<=	0;
		grfRa2_Fs	<=	0;
		ifBd_Mem		<=	0;
	end
	
	always@(posedge clk)begin
		if(reset_If | flush_Mem)begin
			reset_Id 	<=	reset_If;
			pc_Id 		<=	0;
			instr_Id 	<=	0;
			excCode_Id	<=	0;
			grfRa1_Fs 	<=	0;
			grfRa2_Fs 	<=	0;
			ifBd_Mem		<=	0;
		end
		else begin
			reset_Id <= 0;
			if(ifStall == 0)begin
				pc_Id 		<=	pc_If;
				instr_Id 	<=	instr_If;
				excCode_Id	<=	excCode_If;
				grfRa1_Fs	<=	instr_If[25:21];
				grfRa2_Fs 	<=	instr_If[20:16];
				ifBd_Mem		<=	ifBd_If;
			end
		end
	end	

endmodule
