`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:39:37 11/23/2020 
// Design Name: 
// Module Name:    ExToMem 
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
module ExToMem(
	input clk,
	input reset_Ex,
	input [31:0]pc_Ex,
	input [31:0]instr_Ex,
	input [31:0]aluAns_Ex,
	input [31:0]grfRd2_Ex,
		input ifReGrf1_Ex,
		input ifReGrf2_Ex,
		input ifWrGrf_Ex,
		input [4:0]grfRa1_Ex,
		input [4:0]grfRa2_Ex,
		input [4:0]grfWa_Ex,
		input [4:0]tUseRs_Ex,
		input [4:0]tUseRt_Ex,
		input [4:0]tNew_Ex,
		input [31:0]grfWd_Ex,
		
	output reg [31:0]pc_Mem,
	output reg [31:0]instr_Mem,
	output reg reset_Mem,
	output reg [31:0]aluAns_Mem,
	output reg [31:0]grfRd2_Mem,
		output reg ifReGrf1_Hz_Mem,
		output reg ifReGrf2_Hz_Mem,
		output reg ifWrGrf_Hz_Mem,
		output reg [4:0]grfRa1_Hz_Mem,
		output reg [4:0]grfRa2_Hz_Mem,
		output reg [4:0]grfWa_Hz_Mem,
		output reg [4:0]tUseRs_Hz_Mem,
		output reg [4:0]tUseRt_Hz_Mem,
		output reg [4:0]tNew_Hz_Mem,
		output reg [31:0]grfWd_Hz_Mem,
	output reg [4:0]grfRaDmIn_Hz
    );
	 
	initial begin
		pc_Mem <= 32'h00003000;
		instr_Mem <= 0;
		aluAns_Mem <= 0;
		grfRd2_Mem <= 0;
		ifReGrf1_Hz_Mem <= 0;
		ifReGrf2_Hz_Mem <= 0;
		ifWrGrf_Hz_Mem <= 0;
		grfRa1_Hz_Mem <= 0;
		grfRa2_Hz_Mem <= 0;
		grfWa_Hz_Mem <= 0;
		tUseRs_Hz_Mem <= 0;
		tUseRt_Hz_Mem <= 0;
		tNew_Hz_Mem <= 0;
		grfWd_Hz_Mem <= 0;
		grfRaDmIn_Hz <= 0;
		reset_Mem <= 0; 
	end
		
	always@(posedge clk)begin
		if(reset_Ex)begin
			pc_Mem <= 32'h00003000;
			instr_Mem <= 0;
			reset_Mem <= 1;
			aluAns_Mem <= 0;
			grfRd2_Mem <= 0;
			ifReGrf1_Hz_Mem <= 0;
			ifReGrf2_Hz_Mem <= 0;
			ifWrGrf_Hz_Mem <= 0;
			grfRa1_Hz_Mem <= 0;
			grfRa2_Hz_Mem <= 0;
			grfWa_Hz_Mem <= 0;
			tUseRs_Hz_Mem <= 0;
			tUseRt_Hz_Mem <= 0;
			tNew_Hz_Mem <= 0;
			grfWd_Hz_Mem <= 0;
			grfRaDmIn_Hz <= 0;
		end
		else begin
			pc_Mem <= pc_Ex;
			instr_Mem <= instr_Ex;
			reset_Mem <= 0;
			aluAns_Mem <= aluAns_Ex;
			grfRd2_Mem <= grfRd2_Ex;
			ifReGrf1_Hz_Mem <= ifReGrf1_Ex;
			ifReGrf2_Hz_Mem <= ifReGrf2_Ex;
			ifWrGrf_Hz_Mem <= ifWrGrf_Ex;
			grfRa1_Hz_Mem <= grfRa1_Ex;
			grfRa2_Hz_Mem <= grfRa2_Ex;
			grfWa_Hz_Mem <= grfWa_Ex;
			tUseRs_Hz_Mem <= tUseRs_Ex;
			tUseRt_Hz_Mem <= tUseRt_Ex;
			tNew_Hz_Mem <= tNew_Ex;
			grfWd_Hz_Mem <= grfWd_Ex;
			grfRaDmIn_Hz <= instr_Ex[20:16];
		end
	end

endmodule
