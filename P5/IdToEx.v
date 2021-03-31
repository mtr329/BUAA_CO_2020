`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:30:06 11/23/2020 
// Design Name: 
// Module Name:    IdToEx 
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
module IdToEx(
	input clk,
	input reset_Id,
	input stall,
		input [31:0]pc_Id,
		input [31:0]instr_Id,
	input [4:0]rs_Id,
	input [4:0]rt_Id,
	input [4:0]rd_Id,
	input [31:0]immExt_Id,
	input [31:0]grfRd1_Id,
	input [31:0]grfRd2_Id,
		//for hazzard
		input ifReGrf1_Id,
		input ifReGrf2_Id,
		input ifWrGrf_Id,
		input [4:0]grfRa1_Id,
		input [4:0]grfRa2_Id,
		input [4:0]grfWa_Id,
		input [31:0]grfWd_Id,
		input [4:0]tUseRs_Id,
		input [4:0]tUseRt_Id,
		input [4:0]tNew_Id,
		
	output reg [31:0]pc_Ex,
	output reg [31:0]instr_Ex,
	output reg reset_Ex,
		output reg [31:0]immExt_Ex,
		output reg [31:0]grfRd1_Ex,
		output reg [31:0]grfRd2_Ex,
	//for hazzard
	output reg ifReGrf1_Hz_Ex,
	output reg ifReGrf2_Hz_Ex,
	output reg ifWrGrf_Hz_Ex,
	output reg [4:0]grfRa1_Hz_Ex,
	output reg [4:0]grfRa2_Hz_Ex,
	output reg [4:0]grfWa_Hz_Ex,
	output reg [31:0]grfWd_Hz_Ex,
	output reg [4:0]tUseRs_Hz_Ex,
	output reg [4:0]tUseRt_Hz_Ex,
	output reg [4:0]tNew_Hz_Ex,
		output reg [4:0]grfRaAluA_Hz,
		output reg [4:0]grfRaAluB_Hz
    );
	 
	initial begin	
		pc_Ex <= 32'h00003000;
		instr_Ex <= 0;
		reset_Ex <= 0;
		immExt_Ex <= 0;
		grfRd1_Ex <= 0;
		grfRd2_Ex <= 0;
		ifReGrf1_Hz_Ex <= 0;
		ifReGrf2_Hz_Ex <= 0;
		ifWrGrf_Hz_Ex <= 0;
		grfRa1_Hz_Ex <= 0;
		grfRa2_Hz_Ex <= 0;
		grfWa_Hz_Ex <= 0;
		grfWd_Hz_Ex <= 0;
		tUseRs_Hz_Ex <= 0;
		tUseRt_Hz_Ex <= 0;
		tNew_Hz_Ex <= 0;
		grfRaAluA_Hz <= 0;
		grfRaAluA_Hz <= 0;
	end
	
	always@(posedge clk)begin
		if(reset_Id || stall)begin
			pc_Ex <= 32'h00003000;
			instr_Ex <= 0;
			if(reset_Id)begin
				reset_Ex <= 1;
			end
			//reset_Ex <= 0;
			immExt_Ex <= 0;
			grfRd1_Ex <= 0;
			grfRd2_Ex <= 0;
			ifReGrf1_Hz_Ex <= 0;
			ifReGrf2_Hz_Ex <= 0;
			ifWrGrf_Hz_Ex <= 0;
			grfRa1_Hz_Ex <= 0;
			grfRa2_Hz_Ex <= 0;
			grfWa_Hz_Ex <= 0;
			grfWd_Hz_Ex <= 0;
			tUseRs_Hz_Ex <= 0;
			tUseRt_Hz_Ex <= 0;
			tNew_Hz_Ex <= 0;
			grfRaAluA_Hz <= 0;
			grfRaAluA_Hz <= 0;
		end
		else begin
			pc_Ex <= pc_Id;
			instr_Ex <= instr_Id;
			reset_Ex <= 0;
			immExt_Ex <= immExt_Id;
			grfRd1_Ex <= grfRd1_Id;
			grfRd2_Ex <= grfRd2_Id;
			ifReGrf1_Hz_Ex <= ifReGrf1_Id;
			ifReGrf2_Hz_Ex <= ifReGrf2_Id;
			ifWrGrf_Hz_Ex <= ifWrGrf_Id;
			grfRa1_Hz_Ex <= grfRa1_Id;
			grfRa2_Hz_Ex <= grfRa2_Id;
			grfWa_Hz_Ex <= grfWa_Id;
			grfWd_Hz_Ex <= grfWd_Id;
			tUseRs_Hz_Ex <= tUseRs_Id;
			tUseRt_Hz_Ex <= tUseRt_Id;
			tNew_Hz_Ex <= tNew_Id;
			grfRaAluA_Hz <= instr_Id[25:21];
			grfRaAluB_Hz <= instr_Id[20:16];
		end
	end
	
endmodule
