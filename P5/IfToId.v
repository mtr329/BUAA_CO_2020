`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:07:04 11/23/2020 
// Design Name: 
// Module Name:    IfToId 
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
module IfToId(
	input clk,
	input reset_If,
	input stall,
		input [31:0]pc_If,
		input [31:0]instr_If,
	
	output reg [31:0]pc_Id,
	output reg [31:0]instr_Id,
	output reg [4:0]grfRaCmp1_Hz,
	output reg [4:0]grfRaCmp2_Hz,
	output reg [4:0]grfRaPc_Hz,
	output reg reset_Id
    );
	
	initial begin
		pc_Id <= 32'h00003000;
		instr_Id <= 0;
		grfRaCmp1_Hz <= 0;
		grfRaCmp2_Hz <= 0;
		grfRaPc_Hz <= 0;
		reset_Id <= 0;
	end
	
	always@(posedge clk)begin
		if(reset_If)begin
			pc_Id <= 32'h00003000;
			instr_Id <= 0;
			grfRaCmp1_Hz <= 0;
			grfRaCmp2_Hz <= 0;
			grfRaPc_Hz <= 0;
			reset_Id <= 1;
		end
		else begin
			reset_Id <= 0;
			if(stall == 0)begin
				pc_Id <= pc_If;
				instr_Id <= instr_If;
				grfRaCmp1_Hz <= instr_If[25:21];
				grfRaCmp2_Hz <= instr_If[20:16];
				grfRaPc_Hz <= 31;
			end
			else begin 
				pc_Id <= pc_Id;
				instr_Id <= instr_Id;
				grfRaCmp1_Hz <= grfRaCmp1_Hz;
				grfRaCmp2_Hz <= grfRaCmp2_Hz;
				grfRaPc_Hz <= grfRaPc_Hz;
			end
		end
	end


endmodule
