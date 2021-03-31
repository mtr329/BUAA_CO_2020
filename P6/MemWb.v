`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:59:08 12/01/2020 
// Design Name: 
// Module Name:    MemWb 
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
module MemWb(
	input clk,
	input reset_Mem,
	input [31:0]pc_Mem,
	input [31:0]instr_Mem,
	input [31:0]dmRd_Mem,
	input [31:0]aluAns_Mem,
	input [4:0]grfWa_Mem,
	//for Hz
	input ifReGrf1_Mem,
	input ifReGrf2_Mem,
	input ifWrGrf_Mem,
	input [4:0]grfRa1_Mem,
	input [4:0]grfRa2_Mem,
	//input [4:0]grfWa_Mem,
	input [31:0]grfWd_Mem,
	input [4:0]tUseRs_Mem,
	input [4:0]tUseRt_Mem,
	input [4:0]tNew_Mem,
		
	output reg [31:0]pc_Wb,
	output reg [31:0]instr_Wb,
	output reg [31:0]dmRd_Wb,
	output reg [31:0]aluAns_Wb,
	output reg [4:0]grfWa_Wb,	
	//for Hz
	output reg ifReGrf1_Wb,
	output reg ifReGrf2_Wb,
	output reg ifWrGrf_Wb,
	output reg [4:0]grfRa1_Wb,
	output reg [4:0]grfRa2_Wb,
	//output reg [4:0]grfWa_Wb,
	output reg [31:0]grfWd_Wb,
	output reg [4:0]tUseRs_Wb,
	output reg [4:0]tUseRt_Wb,
	output reg [4:0]tNew_Wb
    );

	initial begin
		pc_Wb <= 32'h00003000;
		instr_Wb <= 0;
		dmRd_Wb <= 0;
		aluAns_Wb <= 0;
		grfWa_Wb <= 0;	
		//for Hz
		ifReGrf1_Wb <= 0;
		ifReGrf2_Wb <= 0;
		ifWrGrf_Wb <= 0;
		grfRa1_Wb <= 0;
		grfRa2_Wb <= 0;
		//grfWa_Wb <= 0;
		grfWd_Wb <= 0;
		tUseRs_Wb <= 0;
		tUseRt_Wb <= 0;
		tNew_Wb <= 0;
	end
	
	always@(posedge clk)begin
		if(reset_Mem)begin
			pc_Wb <= 32'h00003000;
			instr_Wb <= 0;
			dmRd_Wb <= 0;
			aluAns_Wb <= 0;
			grfWa_Wb <= 0;	
			//for Hz
			ifReGrf1_Wb <= 0;
			ifReGrf2_Wb <= 0;
			ifWrGrf_Wb <= 0;
			grfRa1_Wb <= 0;
			grfRa2_Wb <= 0;
			//grfWa_Wb <= 0;
			grfWd_Wb <= 0;
			tUseRs_Wb <= 0;
			tUseRt_Wb <= 0;
			tNew_Wb <= 0;
		end
		else begin
			pc_Wb <= pc_Mem;
			instr_Wb <= instr_Mem;
			dmRd_Wb <= dmRd_Mem;
			aluAns_Wb <= aluAns_Mem;
			grfWa_Wb <= grfWa_Mem;	
			//for Hz
			ifReGrf1_Wb <= ifReGrf1_Mem;
			ifReGrf2_Wb <= ifReGrf2_Mem;
			ifWrGrf_Wb <= ifWrGrf_Mem;
			grfRa1_Wb <= grfRa1_Mem;
			grfRa2_Wb <= grfRa2_Mem;
			//grfWa_Wb <= grfWa_Mem;
			grfWd_Wb <= grfWd_Mem;
			tUseRs_Wb <= tUseRs_Mem;
			tUseRt_Wb <= tUseRt_Mem;
			tNew_Wb <= tNew_Mem;
		end
	end

endmodule
