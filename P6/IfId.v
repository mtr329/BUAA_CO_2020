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
	input ifStall,
	input [31:0]pc_If,
	input [31:0]instr_If,
	
	output reg reset_Id,
	output reg [31:0]pc_Id,
	output reg [31:0]instr_Id,
	output reg [4:0]grfRa1_Fs,
	output reg [4:0]grfRa2_Fs
    );

	initial begin
		reset_Id <= 0;
		pc_Id <= 32'h00003000;
		instr_Id <= 0;
		grfRa1_Fs <= 0;
		grfRa2_Fs <= 0;
	end
	
	always@(posedge clk)begin
		if(reset_If)begin
			reset_Id <= 1;
			pc_Id <= 32'h00003000;
			instr_Id <= 0;
			grfRa1_Fs <= 0;
			grfRa2_Fs <= 0;
		end
		else begin
			reset_Id <= 0;
			if(ifStall == 0)begin
				pc_Id <= pc_If;
				instr_Id <= instr_If;
				grfRa1_Fs <= instr_If[25:21];
				grfRa2_Fs <= instr_If[20:16];
			end
		end
	end	

endmodule
