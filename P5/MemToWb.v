`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:33:38 11/23/2020 
// Design Name: 
// Module Name:    MemToWb 
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
module MemToWb(
	input clk,
	input reset_Mem,
	input [31:0]pc_Mem,
	input [31:0]instr_Mem,
	input [31:0]dmRd_Mem,
	input [31:0]aluAns_Mem,
	input [4:0]grfWa_Mem,
		input ifReGrf1_Mem,
		input ifReGrf2_Mem,
		input ifWrGrf_Mem,
		input [4:0]grfRa1_Mem,
		input [4:0]grfRa2_Mem,
		//input [4:0]grfWa_Mem,
		input [4:0]tUseRs_Mem,
		input [4:0]tUseRt_Mem,
		input [4:0]tNew_Mem,
		input [31:0]grfWd_Mem,
		
	output reg [31:0]pc_Wb,
	output reg [31:0]instr_Wb,
	output reg [31:0]dmRd_Wb,
	output reg [31:0]aluAns_Wb,
	output reg [4:0]grfWa_Wb,	
		output reg ifReGrf1_Hz_Wb,
		output reg ifReGrf2_Hz_Wb,
		output reg ifWrGrf_Hz_Wb,
		output reg [4:0]grfRa1_Hz_Wb,
		output reg [4:0]grfRa2_Hz_Wb,
		output reg [4:0]grfWa_Hz_Wb,
		output reg [4:0]tUseRs_Hz_Wb,
		output reg [4:0]tUseRt_Hz_Wb,
		output reg [4:0]tNew_Hz_Wb,
		output reg [31:0]grfWd_Hz_Wb
    );

	initial begin
		pc_Wb <= 32'h00003000;
		instr_Wb <= 0;
		dmRd_Wb <= 0;
		aluAns_Wb <= 0;
		grfWa_Wb <= 0;	
		ifReGrf1_Hz_Wb <= 0;
		ifReGrf2_Hz_Wb <= 0;
		ifWrGrf_Hz_Wb <= 0;
		grfRa1_Hz_Wb <= 0;
		grfRa2_Hz_Wb <= 0;
		grfWa_Hz_Wb <= 0;
		tUseRs_Hz_Wb <= 0;
		tUseRt_Hz_Wb <= 0;
		tNew_Hz_Wb <= 0;
		grfWd_Hz_Wb <= 0;
	end
	
	always@(posedge clk)begin
		if(reset_Mem)begin
			pc_Wb <= 32'h00003000;
			instr_Wb <= 0;
			dmRd_Wb <= 0;
			aluAns_Wb <= 0;
			grfWa_Wb <= 0;	
			ifReGrf1_Hz_Wb <= 0;
			ifReGrf2_Hz_Wb <= 0;
			ifWrGrf_Hz_Wb <= 0;
			grfRa1_Hz_Wb <= 0;
			grfRa2_Hz_Wb <= 0;
			grfWa_Hz_Wb <= 0;
			tUseRs_Hz_Wb <= 0;
			tUseRt_Hz_Wb <= 0;
			tNew_Hz_Wb <= 0;
			grfWd_Hz_Wb <= 0;
		end
		else begin
			pc_Wb <= pc_Mem;
			instr_Wb <= instr_Mem;
			dmRd_Wb <= dmRd_Mem;
			aluAns_Wb <= aluAns_Mem;
			grfWa_Wb <= grfWa_Mem;	
			ifReGrf1_Hz_Wb <= ifReGrf1_Mem;
			ifReGrf2_Hz_Wb <= ifReGrf2_Mem;
			ifWrGrf_Hz_Wb <= ifWrGrf_Mem;
			grfRa1_Hz_Wb <= grfRa1_Mem;
			grfRa2_Hz_Wb <= grfRa2_Mem;
			grfWa_Hz_Wb <= grfWa_Mem;
			tUseRs_Hz_Wb <= tUseRs_Mem;
			tUseRt_Hz_Wb <= tUseRt_Mem;
			tNew_Hz_Wb <= tNew_Mem;
			grfWd_Hz_Wb <= grfWd_Mem;
		end
	end	

endmodule
