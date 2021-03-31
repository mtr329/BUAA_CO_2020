`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:29:32 11/26/2020 
// Design Name: 
// Module Name:    Hazzard 
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
module Hazzard(
	//Id readAddr and tUse
	input ifReGrf1_Id,
	input ifReGrf2_Id,
	input [4:0]grfRa1_Id,
	input [4:0]grfRa2_Id,
	input [4:0]tUseRs_Id,
	input [4:0]tUseRt_Id,
	//others' writeAddr and tNew
	//Ex
	input ifWrGrf_IdToEx,
	input [4:0]grfWa_IdToEx,
	input [4:0]tNew_IdToEx,
	input [31:0]grfWd_IdToEx,
	//Mem
	input ifWrGrf_ExToMem,
	input [4:0]grfWa_ExToMem,
	input [4:0]tNew_ExToMem,
	input [31:0]grfWd_ExToMem,
	//Wb
	input ifWrGrf_MemToWb,
	input [4:0]grfWa_MemToWb,
	input [4:0]tNew_MemToWb,
	input [31:0]grfWd_MemToWb,
	///////////
	//cmp
	input [4:0]grfRaCmp1_IfToId,
	input [4:0]grfRaCmp2_IfToId,
	//alu
	input [4:0]grfRaAluA_IdToEx,
	input [4:0]grfRaAluB_IdToEx,
	//dm
	input [4:0]grfRaDmIn_ExToMem,
	
	output ifStall,
	//cmp
	output [4:0]cmp1Ctrl_Id,
	output [4:0]cmp2Ctrl_Id,
	output [31:0]cmp1Fw1_Id,
	output [31:0]cmp1Fw2_Id,
	output [31:0]cmp2Fw1_Id,
	output [31:0]cmp2Fw2_Id,
	//alu
	output [4:0]aluACtrl_Ex,
	output [4:0]aluBCtrl_Ex,
	output [31:0]aluAFw1_Ex,
	output [31:0]aluAFw2_Ex,
	output [31:0]aluBFw1_Ex,
	output [31:0]aluBFw2_Ex,
	//dm
	output [4:0]dmInCtrl_Mem,
	output [31:0]dmInFw_Mem,
	//jr
	output [4:0]jrCtrl_Id,
	output [31:0]jrFw1_Id,
	output [31:0]jrFw2_Id
    );
	
	//for stall
	wire judge1;
	wire judge2;
	assign judge1 = (ifReGrf1_Id == 0)? 0:
						 (ifWrGrf_IdToEx && 
						  (grfRa1_Id == grfWa_IdToEx) && 
						  (grfWa_IdToEx != 0) && 
						  (tUseRs_Id < tNew_IdToEx)
						 ) | 
						 (ifWrGrf_ExToMem &&
						  (grfRa1_Id == grfWa_ExToMem) &&
						  (grfWa_ExToMem != 0) &&
						  (tUseRs_Id < tNew_ExToMem)
						 );
	assign judge2 = (ifReGrf2_Id == 0)? 0:
						 ((ifWrGrf_IdToEx) &&
						  (grfRa2_Id == grfWa_IdToEx) && 
						  (grfWa_IdToEx != 0) && 
						  (tUseRt_Id < tNew_IdToEx)
						 ) | 
						 ((ifWrGrf_ExToMem) &&
						  (grfRa2_Id == grfWa_ExToMem) &&
						  (grfWa_ExToMem != 0) &&
						  (tUseRt_Id < tNew_ExToMem)
						 );
	assign ifStall = judge1 || judge2;
	///////////
	
	//for IdCmp
	//1: wb, 2: fw1, 3: fw2
	assign cmp1Fw1_Id = grfWd_ExToMem;
	assign cmp1Fw2_Id = grfWd_IdToEx;
	//forward the new value
	assign cmp1Ctrl_Id = ((grfRaCmp1_IfToId == grfWa_IdToEx) && (grfWa_IdToEx != 0))? 3:
								((grfRaCmp1_IfToId == grfWa_ExToMem) && (grfWa_ExToMem != 0))? 2:
								((grfRaCmp1_IfToId == grfWa_MemToWb) && (grfWa_MemToWb != 0))? 1:
								0;
	assign cmp2Fw1_Id = grfWd_ExToMem;
	assign cmp2Fw2_Id = grfWd_IdToEx;
	assign cmp2Ctrl_Id = ((grfRaCmp2_IfToId == grfWa_IdToEx) && (grfWa_IdToEx != 0))? 3:
								((grfRaCmp2_IfToId == grfWa_ExToMem) && (grfWa_ExToMem != 0))? 2:
								((grfRaCmp2_IfToId == grfWa_MemToWb) && (grfWa_MemToWb != 0))? 1:
								0;
	////////////
	
	//for ExAlu
	//1: fw1, 2: fw2
	//forward the new value
	assign aluAFw1_Ex = grfWd_MemToWb;
	assign aluAFw2_Ex = grfWd_ExToMem;
	
	assign aluACtrl_Ex = ((grfRaAluA_IdToEx == grfWa_ExToMem) && (grfWa_ExToMem != 0))? 2:
								((grfRaAluA_IdToEx == grfWa_MemToWb) && (grfWa_MemToWb != 0))? 1:
								0;
	assign aluBFw1_Ex = grfWd_MemToWb;
	assign aluBFw2_Ex = grfWd_ExToMem;
	assign aluBCtrl_Ex = ((grfRaAluB_IdToEx == grfWa_ExToMem) && (grfWa_ExToMem != 0))? 2:
								((grfRaAluB_IdToEx == grfWa_MemToWb) && (grfWa_MemToWb != 0))? 1:
								0;
	////////////
	
	//for dmIn
	assign dmInFw_Mem = grfWd_MemToWb;
	assign dmInCtrl_Mem = ((grfRaDmIn_ExToMem == grfWa_MemToWb) && (grfWa_MemToWb != 0))? 1:
								 0;
	//////////
	
	//for pc
	assign jrFw1_Id = grfWd_ExToMem;
	assign jrFw2_Id = grfWd_IdToEx;
	assign jrCtrl_Id = ((grfRaCmp1_IfToId == grfWa_IdToEx) && (grfWa_IdToEx != 0))? 3:
							 ((grfRaCmp1_IfToId == grfWa_ExToMem) && (grfWa_ExToMem != 0))? 2:
							 ((grfRaCmp1_IfToId == grfWa_MemToWb) && (grfWa_MemToWb != 0))? 1:
						    0;
	////////
	
endmodule
