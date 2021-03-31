`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:34 12/01/2020 
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
	input clk,
	input reset_IdEx,
	input [31:0]pc_IdEx,
	input [31:0]instr_IdEx,
	input [4:0]excCode_IdEx,
	input [31:0]cmp1_IdEx,
	input [31:0]grfRd1_IdEx,
	input [31:0]grfRd2_IdEx,
	input [31:0]immExt_IdEx,
	input wrHiloEn,
	input ifBd_IdEx,
	//from Fs
	input [31:0]calA_Fs,
	input [31:0]calB_Fs,
	//for Hz
	input ifReGrf1_IdEx,
	input ifReGrf2_IdEx,
	input ifWrGrf_IdEx,
	input [4:0]grfRa1_IdEx,
	input [4:0]grfRa2_IdEx,
	input [4:0]grfWa_IdEx,
	input [31:0]grfWd_IdEx,
	input [4:0]tUseRs_IdEx,
	input [4:0]tUseRt_IdEx,
	input [4:0]tNew_IdEx,

	output reset_ExMem,
	output [31:0]pc_ExMem,
	output [31:0]instr_ExMem,
	output [4:0]excCode_ExMem,
	output [31:0]cmp1_ExMem,
	output [31:0]aluAns_ExMem,
	output [31:0]rdHi_ExMem,
	output [31:0]rdLo_ExMem,
	output [31:0]grfRd1_ExMem,
	output [31:0]grfRd2_ExMem,
	output ifBd_ExMem,
	//for Hz
	output ifReGrf1_ExMem,
	output ifReGrf2_ExMem,
	output ifWrGrf_ExMem,
	output [4:0]grfRa1_ExMem,
	output [4:0]grfRa2_ExMem,
	output [4:0]grfWa_ExMem,
	output [31:0]grfWd_ExMem,
	output [4:0]tUseRs_ExMem,
	output [4:0]tUseRt_ExMem,
	output [4:0]tNew_ExMem,
	//
	output ifBusy_Ss,
	output ifStart_Ss
    );
	 
	wire [4:0]aluCtrl;
	wire [4:0]hiloCtrl;
	wire ifImmZeroExt;
	wire ifImmSignExt;
	wire [31:0]inB;
	wire ifMfhi;
	wire ifMflo;
	wire ifMthi;
	wire ifMtlo;
	wire ifMult;
	wire ifMultu;
	wire ifDiv;
	wire ifDivu;
	wire ifOverflow;
	wire ifAdd;
	wire ifAddi;
	wire ifSub;
	wire ifLoad;
	wire ifSave;
	wire ifBranch;
	wire ifJump;
	
	Controller controller_Ex(
		.instr(instr_IdEx),
		
		.aluCtrl(aluCtrl),
		.hiloCtrl(hiloCtrl),
		.ifImmZeroExt(ifImmZeroExt),		//for AluB & hiLoB
		.ifImmSignExt(ifImmSignExt),
		.ifMfhi(ifMfhi),
		.ifMflo(ifMflo),
		.ifMthi(ifMthi),
		.ifMtlo(ifMtlo),
		.ifMult(ifMult),
		.ifMultu(ifMultu),
		.ifDiv(ifDiv),
		.ifDivu(ifDivu),
		.ifAdd(ifAdd),
		.ifAddi(ifAddi),
		.ifSub(ifSub),
		.ifLoad(ifLoad),
		.ifSave(ifSave),
		.ifBranch(ifBranch),
		.ifJump(ifJump)
	);
	
	//assign ifBd_ExMem	=	ifBd_IdEx;
	
	assign inB = (ifImmZeroExt | ifImmSignExt)?
					 (immExt_IdEx):
					 (calB_Fs);
	
	assign ifStart_Ss = (ifMult | ifMultu | ifDiv | ifDivu);
	
	assign cmp1_ExMem		=	cmp1_IdEx;
	assign excCode_ExMem	=	(excCode_IdEx > 0)?
									(excCode_IdEx):
									(ifOverflow && (ifAdd | ifAddi | ifSub))?
									12:
									(ifOverflow && (ifLoad))?
									4:
									(ifOverflow && (ifSave))?
									5:
									0;
	
	Alu alu_Ex(
		.instr(instr_IdEx),
		.a(calA_Fs),
		.b(inB),
		.ctrl(aluCtrl),
	
		.ans(aluAns_ExMem),
		.overflow(ifOverflow)
	);
	
	Hilo hilo_Ex(
		.clk(clk),
		.reset(reset_IdEx), 
		.start(ifStart_Ss),
		.ctrl(hiloCtrl),
		.A(calA_Fs),
		.B(calB_Fs),
		.wrHiloEn(wrHiloEn),
	
		.rdHi(rdHi_ExMem),
		.rdLo(rdLo_ExMem),
		.busy(ifBusy_Ss)
	);
	
	assign reset_ExMem 		=	reset_IdEx;
	assign pc_ExMem 			=	pc_IdEx;
	assign instr_ExMem 		=	instr_IdEx;
	assign grfRd2_ExMem 		=	calB_Fs;
	assign grfRd1_ExMem 		=	calA_Fs;
	//for Hz
	assign ifReGrf1_ExMem 	=	ifReGrf1_IdEx;
	assign ifReGrf2_ExMem 	=	ifReGrf2_IdEx;
	assign ifWrGrf_ExMem 	=	ifWrGrf_IdEx;
	assign grfRa1_ExMem 		=	grfRa1_IdEx;
	assign grfRa2_ExMem 		=	grfRa2_IdEx;
	assign grfWa_ExMem 		=	grfWa_IdEx;
	assign grfWd_ExMem 		=	(ifMfhi)? rdHi_ExMem:
										(ifMflo)? rdLo_ExMem:
										(tNew_IdEx == 0)? grfWd_IdEx:
										(tNew_IdEx == 1)? aluAns_ExMem:
										0;
	assign tUseRs_ExMem 		=	tUseRs_IdEx;
	assign tUseRt_ExMem 		=	tUseRt_IdEx;
	assign tNew_ExMem 		=	(tNew_IdEx == 0)? 0:
										(tNew_IdEx - 1);
							 
endmodule
