`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:17:00 11/26/2020 
// Design Name: 
// Module Name:    Mem 
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
module Mem(
	input clk,
	input reset_ExToMem,
	input [31:0]pc_ExToMem,
	input [31:0]instr_ExToMem,
	input [31:0]aluAns_ExToMem,
	input [31:0]grfRd2_ExToMem,
		input [4:0]dmInCtrl_Hz,//forward
		input [31:0]dmInFw_Hz,
	input ifReGrf1_ExToMem,
	input ifReGrf2_ExToMem,
	input ifWrGrf_ExToMem,
	input [4:0]grfRa1_ExToMem,
	input [4:0]grfRa2_ExToMem,
	input [4:0]grfWa_ExToMem,
	input [4:0]tUseRs_ExToMem,
	input [4:0]tUseRt_ExToMem,
	input [4:0]tNew_ExToMem,
	input [31:0]grfWd_ExToMem,
	
	output [31:0]pc_MemToWb,
	output [31:0]instr_MemToWb,
	output reset_MemToWb,
	output [31:0]dmRd_MemToWb,
	output [31:0]aluAns_MemToWb,
	//output [4:0]grfWa_MemToWb, (line 49)
		output ifReGrf1_MemToWb,
		output ifReGrf2_MemToWb,
		output ifWrGrf_MemToWb,
		output [4:0]grfRa1_MemToWb,
		output [4:0]grfRa2_MemToWb,
		output [4:0]grfWa_MemToWb,
		output [4:0]tUseRs_MemToWb,
		output [4:0]tUseRt_MemToWb,
		output [4:0]tNew_MemToWb,
		output [31:0]grfWd_MemToWb
    );
	assign reset_MemToWb = reset_ExToMem;
	
	wire ifReDm;
	wire ifWrDm;
	Controller controller_Mem(
		.op(instr_ExToMem[31:26]),
		.low6(instr_ExToMem[5:0]),
		
		.ifReDm(ifReDm),
		.ifWrDm(ifWrDm)
	);

	wire [31:0]dmIn;
	Dm dm(
		.pc(pc_ExToMem),
		.clk(clk),
		.reset(reset_ExToMem),
		.rEn(ifReDm),
		.wEn(ifWrDm),
		.addr(aluAns_ExToMem),
		.dIn(dmIn),
		.dOut(dmRd_MemToWb)
	);
	
	//for dmIn
	assign dmIn = (dmInCtrl_Hz == 1)? dmInFw_Hz:
					  grfRd2_ExToMem;
	//////////
	
	//for MemToWb
	assign pc_MemToWb = pc_ExToMem;
	assign instr_MemToWb = instr_ExToMem;
	assign aluAns_MemToWb = aluAns_ExToMem;
		assign ifReGrf1_MemToWb = ifReGrf1_ExToMem;
		assign ifReGrf2_MemToWb = ifReGrf2_ExToMem;
		assign ifWrGrf_MemToWb = ifWrGrf_ExToMem;
		assign grfRa1_MemToWb = grfRa1_ExToMem;
		assign grfRa2_MemToWb = grfRa2_ExToMem;
		assign grfWa_MemToWb = grfWa_ExToMem;
		assign tUseRs_MemToWb = tUseRs_ExToMem;
		assign tUseRt_MemToWb = tUseRt_ExToMem;
		assign tNew_MemToWb = (tNew_ExToMem == 0)? 0:
									 (tNew_ExToMem - 1);
		assign grfWd_MemToWb = (tNew_ExToMem == 0)? grfWd_ExToMem:
									  (tNew_ExToMem == 1)? dmRd_MemToWb:
									  0;
	//

endmodule
