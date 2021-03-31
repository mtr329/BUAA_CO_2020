`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:10:20 11/25/2020 
// Design Name: 
// Module Name:    Ex 
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
module Ex(
	input [31:0]pc_IdToEx,
	input [31:0]instr_IdToEx,
	input reset_IdToEx,
	input [31:0]immExt_IdToEx,
	input [31:0]grfRd1_IdToEx,
	input [31:0]grfRd2_IdToEx,
		input [4:0]aluACtrl_Hz,
		input [4:0]aluBCtrl_Hz,
		input [31:0]aluAFw1_Hz,
		input [31:0]aluAFw2_Hz,
		input [31:0]aluBFw1_Hz,
		input [31:0]aluBFw2_Hz,
	//for hazzard
	input ifReGrf1_IdToEx,
	input ifReGrf2_IdToEx,
	input ifWrGrf_IdToEx,
	input [4:0]grfRa1_IdToEx,
	input [4:0]grfRa2_IdToEx,
	input [4:0]grfWa_IdToEx,
	input [31:0]grfWd_IdToEx,
	input [4:0]tUseRs_IdToEx,
	input [4:0]tUseRt_IdToEx,
	input [4:0]tNew_IdToEx,

	output [31:0]pc_ExToMem,
	output [31:0]instr_ExToMem,
	output reset_ExToMem,
	output [31:0]aluAns_ExToMem,
	output [31:0]grfRd2_ExToMem,
		output ifReGrf1_ExToMem,
		output ifReGrf2_ExToMem,
		output ifWrGrf_ExToMem,
		output [4:0]grfRa1_ExToMem,
		output [4:0]grfRa2_ExToMem,
		output [4:0]grfWa_ExToMem,
		output [4:0]tUseRs_ExToMem,
		output [4:0]tUseRt_ExToMem,
		output [4:0]tNew_ExToMem,
		output [31:0]grfWd_ExToMem
    );
	assign reset_ExToMem = reset_IdToEx;
	
	wire [4:0]aluCtrl;
	wire ifImmExt;
	Controller controller_Ex(
		.op(instr_IdToEx[31:26]),
		.low6(instr_IdToEx[5:0]),
		
		.aluCtrl(aluCtrl),
		.ifImmExt(ifImmExt)
	);
	
	wire [31:0]aluA;
	wire [31:0]aluB;
	wire [31:0]aluAns;
	Alu alu_Ex(
		.a(aluA),
		.b(aluB),
		.ctrl(aluCtrl),

		.out(aluAns)
	);
	
	//for aluA
	assign aluA = (aluACtrl_Hz == 1)? aluAFw1_Hz:
					  (aluACtrl_Hz == 2)? aluAFw2_Hz:
					  grfRd1_IdToEx;
	//////////
	
	//for aluB
	wire [31:0]grfRd2AfterFw;
	assign grfRd2AfterFw = (aluBCtrl_Hz == 1)? aluBFw1_Hz:
								  (aluBCtrl_Hz == 2)? aluBFw2_Hz:
								  grfRd2_IdToEx;
	assign aluB = (ifImmExt == 1)? immExt_IdToEx:
					  grfRd2AfterFw;
	//////////
	
	//for ExToMem
	assign pc_ExToMem = pc_IdToEx;
	assign instr_ExToMem = instr_IdToEx;
	assign aluAns_ExToMem = aluAns;
	assign grfRd2_ExToMem = grfRd2AfterFw;
	assign ifReGrf1_ExToMem = ifReGrf1_IdToEx;
	assign ifReGrf2_ExToMem = ifReGrf2_IdToEx;
	assign ifWrGrf_ExToMem = ifWrGrf_IdToEx;
	assign grfRa1_ExToMem = grfRa1_IdToEx;
	assign grfRa2_ExToMem = grfRa2_IdToEx;
	assign grfWa_ExToMem = grfWa_IdToEx;
	assign tUseRs_ExToMem = tUseRs_IdToEx;
	assign tUseRt_ExToMem = tUseRt_IdToEx;
	assign tNew_ExToMem = (tNew_IdToEx == 0)? 0:
								 (tNew_IdToEx - 1);
	assign grfWd_ExToMem = (tNew_IdToEx == 0)? grfWd_IdToEx:
								  (tNew_IdToEx == 1)? aluAns:
								  0;
	/////////////
	
endmodule
