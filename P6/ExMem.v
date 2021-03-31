`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:43 12/01/2020 
// Design Name: 
// Module Name:    ExMem 
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
module ExMem(
	input clk,
	input reset_Ex,
	input [31:0]pc_Ex,
	input [31:0]instr_Ex,
	input [31:0]aluAns_Ex,
	input [31:0]grfRd2_Ex,
	//for Hz
	input ifReGrf1_Ex,
	input ifReGrf2_Ex,
	input ifWrGrf_Ex,
	input [4:0]grfRa1_Ex,
	input [4:0]grfRa2_Ex,
	input [4:0]grfWa_Ex,
	input [31:0]grfWd_Ex,
	input [4:0]tUseRs_Ex,
	input [4:0]tUseRt_Ex,
	input [4:0]tNew_Ex,
	
	output reg reset_Mem,
	output reg [31:0]pc_Mem,
	output reg [31:0]instr_Mem,
	output reg [31:0]aluAns_Mem,
	output reg [31:0]grfRd2_Mem,
	//for Hz
	output reg ifReGrf1_Mem,
	output reg ifReGrf2_Mem,
	output reg ifWrGrf_Mem,
	output reg [4:0]grfRa1_Mem,
	output reg [4:0]grfRa2_Mem,
	output reg [4:0]grfWa_Mem,
	output reg [31:0]grfWd_Mem,
	output reg [4:0]tUseRs_Mem,
	output reg [4:0]tUseRt_Mem,
	output reg [4:0]tNew_Mem
    );

	initial begin
		pc_Mem <= 32'h00003000;
		instr_Mem <= 0;
		reset_Mem <= 0;
		aluAns_Mem <= 0;
		grfRd2_Mem <= 0;
		//for Hz
		ifReGrf1_Mem <= 0;
		ifReGrf2_Mem <= 0;
		ifWrGrf_Mem <= 0;
		grfRa1_Mem <= 0;
		grfRa2_Mem <= 0;
		grfWa_Mem <= 0;
		grfWd_Mem <= 0;
		tUseRs_Mem <= 0;
		tUseRt_Mem <= 0;
		tNew_Mem <= 0;
	end
	
	always@(posedge clk)begin
		if(reset_Ex)begin
			pc_Mem <= 32'h00003000;
			instr_Mem <= 0;
			reset_Mem <= 1;
			aluAns_Mem <= 0;
			grfRd2_Mem <= 0;
			//for Hz
			ifReGrf1_Mem <= 0;
			ifReGrf2_Mem <= 0;
			ifWrGrf_Mem <= 0;
			grfRa1_Mem <= 0;
			grfRa2_Mem <= 0;
			grfWa_Mem <= 0;
			grfWd_Mem <= 0;
			tUseRs_Mem <= 0;
			tUseRt_Mem <= 0;
			tNew_Mem <= 0;
		end
		else begin
			pc_Mem <= pc_Ex;
			instr_Mem <= instr_Ex;
			reset_Mem <= reset_Ex;
			aluAns_Mem <= aluAns_Ex;
			grfRd2_Mem <= grfRd2_Ex;
			//for Hz
			ifReGrf1_Mem <= ifReGrf1_Ex;
			ifReGrf2_Mem <= ifReGrf2_Ex;
			ifWrGrf_Mem <= ifWrGrf_Ex;
			grfRa1_Mem <= grfRa1_Ex;
			grfRa2_Mem <= grfRa2_Ex;
			grfWa_Mem <= grfWa_Ex;
			grfWd_Mem <= grfWd_Ex;
			tUseRs_Mem <= tUseRs_Ex;
			tUseRt_Mem <= tUseRt_Ex;
			tNew_Mem <= tNew_Ex;
		end
	end
	
endmodule
