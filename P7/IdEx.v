`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:28 12/01/2020 
// Design Name: 
// Module Name:    IdEx 
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
module IdEx(
	input clk,
	input ifStall,
	input reset_Id,
	input flush_Mem,
	input ifBd_Id,
	input [31:0]pc_Id,
	input [31:0]instr_Id,
	input [4:0]excCode_Id,
	input [31:0]cmp1_Id,
	input [31:0]grfRd1_Id,
	input [31:0]grfRd2_Id,
	input [31:0]immExt_Id,
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
		
	output reg reset_Ex,
	output reg [31:0]pc_Ex,
	output reg [31:0]instr_Ex,
	output reg [4:0]excCode_Ex,
	output reg [31:0]cmp1_Ex,
	output reg [31:0]grfRd1_Ex,
	output reg [31:0]grfRd2_Ex,
	output reg [31:0]immExt_Ex,
	output reg ifBd_Mem,
	//for hazzard
	output reg ifReGrf1_Ex,
	output reg ifReGrf2_Ex,
	output reg ifWrGrf_Ex,
	output reg [4:0]grfRa1_Ex,
	output reg [4:0]grfRa2_Ex,
	output reg [4:0]grfWa_Ex,
	output reg [31:0]grfWd_Ex,
	output reg [4:0]tUseRs_Ex,
	output reg [4:0]tUseRt_Ex,
	output reg [4:0]tNew_Ex
    );
	
	initial begin
		pc_Ex			<= 0;
		instr_Ex		<= 0;
		excCode_Ex	<=	0;
		cmp1_Ex		<=	0;
		reset_Ex 	<= 0;
		immExt_Ex 	<= 0;
		grfRd1_Ex 	<= 0;
		grfRd2_Ex 	<= 0;
		ifBd_Mem		<=	0;
		//for hazzard
		ifReGrf1_Ex <= 0;
		ifReGrf2_Ex <= 0;
		ifWrGrf_Ex 	<= 0;
		grfRa1_Ex 	<= 0;
		grfRa2_Ex 	<= 0;
		grfWa_Ex 	<= 0;
		grfWd_Ex 	<= 0;
		tUseRs_Ex 	<= 0;
		tUseRt_Ex 	<= 0;
		tNew_Ex 		<= 0;
	end
	
	always@(posedge clk)begin
		if(reset_Id | ifStall | flush_Mem)begin
			pc_Ex 		<= 0;
			instr_Ex 	<= 0;
			reset_Ex 	<= reset_Id;
			excCode_Ex	<=	0;
			cmp1_Ex		<=	0;
			immExt_Ex 	<= 0;
			grfRd1_Ex 	<= 0;
			grfRd2_Ex 	<= 0;
			ifBd_Mem		<=	0;
			//for hazzard
			ifReGrf1_Ex <= 0;
			ifReGrf2_Ex <= 0;
			ifWrGrf_Ex 	<= 0;
			grfRa1_Ex 	<= 0;
			grfRa2_Ex 	<= 0;
			grfWa_Ex 	<= 0;
			grfWd_Ex 	<= 0;
			tUseRs_Ex 	<= 0;
			tUseRt_Ex 	<= 0;
			tNew_Ex 		<= 0;
		end
		else begin
			pc_Ex 		<= pc_Id;
			instr_Ex 	<= instr_Id;
			reset_Ex 	<= 0;
			excCode_Ex	<=	excCode_Id;
			cmp1_Ex		<=	cmp1_Id;
			immExt_Ex 	<= immExt_Id;
			grfRd1_Ex 	<= grfRd1_Id;
			grfRd2_Ex 	<= grfRd2_Id;
			ifBd_Mem		<=	ifBd_Id;
			//for hazzard
			ifReGrf1_Ex	<= ifReGrf1_Id;
			ifReGrf2_Ex	<= ifReGrf2_Id;
			ifWrGrf_Ex 	<= ifWrGrf_Id;
			grfRa1_Ex 	<= grfRa1_Id;
			grfRa2_Ex 	<= grfRa2_Id;
			grfWa_Ex 	<= grfWa_Id;
			grfWd_Ex 	<= grfWd_Id;
			tUseRs_Ex 	<= tUseRs_Id;
			tUseRt_Ex 	<= tUseRt_Id;
			tNew_Ex 		<= tNew_Id;
		end
	end


endmodule
