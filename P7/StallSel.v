`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:36:13 12/06/2020 
// Design Name: 
// Module Name:    StallSel 
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
module StallSel(
	//for judge1, judge2
	input ifReGrf1_Id,
	input ifReGrf2_Id,
	input ifWrGrf_IdEx,
	input ifWrGrf_ExMem,
	input [4:0]grfRa1_Id,
	input [4:0]grfRa2_Id,
	input [4:0]grfWa_IdEx,
	input [4:0]grfWa_ExMem,
	input [4:0]tUseRs_Id,
	input [4:0]tUseRt_Id,
	input [4:0]tNew_IdEx,
	input [4:0]tNew_ExMem,
	//for judge3
	input [31:0]instr_Id,
	input ifBusy_Ex,
	input ifStart_Ex,
	
	output ifStall
    );
	 
	//for judge3
	//mfhi、mflo、mthi、mtlo、mult、multu、div、divu
	wire ifMfhi;
	wire ifMflo;
	wire ifMthi;
	wire ifMtlo;
	wire ifMult;
	wire ifMultu;
	wire ifDiv;
	wire ifDivu;
	//
	wire judge1;
	wire judge2;
	wire judge3;
	
	Controller controller_StallSel(
		.instr(instr_Id),
		
		.ifMfhi(ifMfhi),
		.ifMflo(ifMflo),
		.ifMthi(ifMthi),
		.ifMtlo(ifMtlo),
		.ifMult(ifMult),
		.ifMultu(ifMultu),
		.ifDiv(ifDiv),
		.ifDivu(ifDivu)
	);
	
	assign judge1 = (ifReGrf1_Id == 0)? 0:
						 (ifWrGrf_IdEx && 
						  (grfRa1_Id == grfWa_IdEx) && 
						  (grfWa_IdEx != 0) && 
						  (tUseRs_Id < tNew_IdEx)
						 ) | 
						 (ifWrGrf_ExMem &&
						  (grfRa1_Id == grfWa_ExMem) &&
						  (grfWa_ExMem != 0) &&
						  (tUseRs_Id < tNew_ExMem)
						 );
						 
	assign judge2 = (ifReGrf2_Id == 0)? 0:
						 ((ifWrGrf_IdEx) &&
						  (grfRa2_Id == grfWa_IdEx) && 
						  (grfWa_IdEx != 0) && 
						  (tUseRt_Id < tNew_IdEx)
						 ) | 
						 ((ifWrGrf_ExMem) &&
						  (grfRa2_Id == grfWa_ExMem) &&
						  (grfWa_ExMem != 0) &&
						  (tUseRt_Id < tNew_ExMem)
						 );
						 			 
	assign judge3 = (ifMfhi | ifMflo | ifMthi | ifMtlo | ifMult | ifMultu | ifDiv | ifDivu)
					  & (ifBusy_Ex | ifStart_Ex);
	
	assign ifStall = (judge1 | judge2 | judge3);
	
endmodule
