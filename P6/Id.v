`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:20 12/01/2020 
// Design Name: 
// Module Name:    Id 
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
module Id(
	input clk,
	input reset_IfId,
	input [31:0]pc_IfId,
	input [31:0]instr_IfId,
	//from Wb
	input [31:0]pc_Wb,
	input [4:0]grfWa_Wb,
	input [31:0]grfWd_Wb,
	input ifWrGrf_Wb,
	//from Hz
	input [31:0]grfCmp1_Fs,
	input [31:0]grfCmp2_Fs,
	
	output reset_IdEx,
	output [31:0]pc_IdEx,
	output [31:0]instr_IdEx,
	output [31:0]grfRd1_IdEx,
	output [31:0]grfRd2_IdEx,
	output [31:0]immExt_IdEx,
	//for If
	output [31:0]pcNext_If,
	output ifBranchOrJump_If,
	//for Hz
	output ifReGrf1_IdEx,
	output ifReGrf2_IdEx,
	output ifWrGrf_IdEx,
	output [4:0]grfRa1_IdEx,
	output [4:0]grfRa2_IdEx,
	output [4:0]grfWa_IdEx,
	output [31:0]grfWd_IdEx,
	output [4:0]tUseRs_IdEx,
	output [4:0]tUseRt_IdEx,
	output [4:0]tNew_IdEx,
	output [31:0]grfDirRd1_Fs,
	output [31:0]grfDirRd2_Fs
    );
	 
	wire [31:0]cmp1;
	wire [31:0]cmp2;
	wire ifImmZeroExt;
	wire ifImmSignExt;
	wire ifPcBAct;
	wire ifPcJAct;
	wire [31:0]pcBAct;
	wire [31:0]pcJAct;
	wire ifBeq;
	wire ifBne;
	wire ifBlez;
	wire ifBgtz;
	wire ifBltz;
	wire ifBgez;
	wire ifJ;
	wire ifJal;
	wire ifJalr;
	wire ifJr;
	wire ifBranch;
	wire ifJump;
	
	Controller controller_Id(
		.instr(instr_IfId),
		
		.ifImmZeroExt(ifImmZeroExt),
		.ifImmSignExt(ifImmSignExt),
		.ifBeq(ifBeq),
		.ifBne(ifBne),
		.ifBlez(ifBlez),
		.ifBgtz(ifBgtz),
		.ifBltz(ifBltz),
		.ifBgez(ifBgez),
		.ifJ(ifJ),
		.ifJal(ifJal),
		.ifJalr(ifJalr),
		.ifJr(ifJr),
		.ifBranch(ifBranch),
		.ifJump(ifJump),
		//for Hz
		.ifReGrf1(ifReGrf1_IdEx),
		.ifReGrf2(ifReGrf2_IdEx),
		.ifWrGrf(ifWrGrf_IdEx),
		.grfRa1(grfRa1_IdEx),
		.grfRa2(grfRa2_IdEx),
		.grfWa(grfWa_IdEx),
		.tUseRs(tUseRs_IdEx),
		.tUseRt(tUseRt_IdEx),
		.tNew(tNew_IdEx)
	);
	
	Grf grf_Id(
		.pc(pc_Wb),
		.wEn(ifWrGrf_Wb),
		.clk(clk),
		.reset(reset_IfId),
		.rA1(instr_IfId[25:21]),//rs
		.rA2(instr_IfId[20:16]),//rt
		.wA(grfWa_Wb),
		.wD(grfWd_Wb),

		.rD1(grfDirRd1_Fs),
		.rD2(grfDirRd2_Fs)
	);
	
	assign cmp1 = grfCmp1_Fs;
	assign cmp2 = grfCmp2_Fs;
	
	assign pc_IdEx = pc_IfId;
	assign instr_IdEx = instr_IfId;
	assign reset_IdEx = reset_IfId;
	assign grfRd1_IdEx = cmp1;
	assign grfRd2_IdEx = cmp2;
	assign immExt_IdEx = (ifImmZeroExt)? {{16{1'b0}}, instr_IfId[15:0]}:
								(ifImmSignExt)? {{16{instr_IfId[15]}}, instr_IfId[15:0]}:
								0;
	//for If
	assign pcBAct = pc_IfId + 4 + ({{16{instr_IfId[15]}}, instr_IfId[15:0]} << 2);
	assign pcJAct = {pc_IfId[31:28], instr_IfId[25:0], 2'b00};
	assign ifPcBAct = (ifBeq & (cmp1 == cmp2)) | 
							(ifBne & (cmp1 != cmp2)) |
							(ifBlez & ($signed(cmp1) <= $signed(0))) |
							(ifBgtz & ($signed(cmp1) > $signed(0))) |
							(ifBltz & ($signed(cmp1) < $signed(0))) | 
							(ifBgez & ($signed(cmp1) >= $signed(0)));
	assign ifPcJAct = (ifJ | ifJal);
	assign pcNext_If = (ifPcBAct)? pcBAct:
							 (ifPcJAct)? pcJAct:
							 (ifJalr | ifJr)? cmp1:
							 32'h00003000;
	assign ifBranchOrJump_If = (ifPcBAct | ifPcJAct | ifJalr | ifJr);
	////////
	
	//for Fs
	assign grfWd_IdEx = (ifJal | ifJalr)? (pc_IfId + 8):
							  0;
	////////
endmodule
