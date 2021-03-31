`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:20:20 11/23/2020 
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
	input reset_IfToId,
	input [31:0]pc_IfToId,
	input [31:0]instr_IfToId,
	input [4:0]grfWa_Wb,
	input [31:0]grfWd_Wb,
		input [4:0]cmp1Ctrl_Hz,
		input [4:0]cmp2Ctrl_Hz,
		input [31:0]cmp1Fw1_Hz,
		input [31:0]cmp1Fw2_Hz,
		input [31:0]cmp2Fw1_Hz,
		input [31:0]cmp2Fw2_Hz,
		input [4:0]jrCtrl_Hz,
		input [31:0]jrFw1_Hz, 
		input [31:0]jrFw2_Hz,//grf[rs]
	input ifWrGrf_Wb,
	input [31:0]pcForGrf_Wb,
	
	//for datapath
	output [31:0]pc_IdToEx,
	output [31:0]instr_IdToEx,
	output reset_IdToEx,
	output [31:0]grfRd1_IdToEx,
	output [31:0]grfRd2_IdToEx,
	output [4:0]rs_IdToEx,
	output [4:0]rt_IdToEx,
	output [4:0]rd_IdToEx,
	output [31:0]immExt_IdToEx,
	//for AT info
		output ifReGrf1_IdToEx,
		output ifReGrf2_IdToEx,
		output ifWrGrf_IdToEx,
		output [4:0]grfRa1_IdToEx,
		output [4:0]grfRa2_IdToEx,
		output [4:0]grfWa_IdToEx,
		output [31:0]grfWd_IdToEx,
		output [4:0]tUseRs_IdToEx,
		output [4:0]tUseRt_IdToEx,
		output [4:0]tNew_IdToEx,
	output [31:0]nextPc_If,
	output [4:0]grfWa_Hz,//for judging hzCtrl
	output ifPcBranch_If
    );
	assign reset_IdToEx = reset_IfToId;
	assign grfWa_Hz = grfWa_Wb;//for judging hzCtrl
	
	wire ifJal;
	wire ifJ;
	wire ifJr;
	wire ifBeq;
	wire ifWrGrf;
	Controller controller_Id(
		.op(instr_IfToId[31:26]),
		.low6(instr_IfToId[5:0]),
		.instr(instr_IfToId),

		.ifWrGrf(ifWrGrf),
		.ifJal(ifJal),
		.ifBeq(ifBeq),
		.ifJ(ifJ),
		.ifJr(ifJr),
		///
		.ifReGrf1(ifReGrf1_IdToEx),
		.ifReGrf2(ifReGrf2_IdToEx),
		.grfRa1(grfRa1_IdToEx),
		.grfRa2(grfRa2_IdToEx),
		.grfWa(grfWa_IdToEx),
		.tUseRs(tUseRs_IdToEx),
		.tUseRt(tUseRt_IdToEx),
		.tNew(tNew_IdToEx)
	);
	assign ifWrGrf_IdToEx = ifWrGrf;
	
	wire [31:0]rD1;
	wire [31:0]rD2;
	Grf grf(
		.pc(pcForGrf_Wb),
		.wEn(ifWrGrf_Wb),
		.clk(clk),
		.reset(reset_IfToId),
		.rA1(instr_IfToId[25:21]),//rs
		.rA2(instr_IfToId[20:16]),//rt
		.wA(grfWa_Wb),
		.wD(grfWd_Wb),

		.rD1(rD1),
		.rD2(rD2)
	);
	 
	 
	wire [31:0]cmp1;
	wire [31:0]cmp2;
	
	//for nextPc
	wire [31:0]pcDefault;
	wire [31:0]pcJ;
	wire [31:0]pcJal;
	wire [31:0]pcJr;//forward
	wire [31:0]immExt;
	wire [31:0]pcBeqAct;
	wire [31:0]pcBeqTemp;
	//wire pcBeqBeforeExt
	assign immExt = {16'h0000, instr_IfToId[15:0]};
	assign pcDefault_If = pc_IfToId + 4;
	assign pcJ = {pc_IfToId[31:28], instr_IfToId[25:0], 2'b00};
	assign pcJal = {pc_IfToId[31:28], instr_IfToId[25:0], 2'b00};
	assign pcBeqTemp = (((immExt[15] == 0)? immExt : (immExt + 32'hffff0000)) << 2);
	assign pcBeqAct = pc_IfToId + 4 + pcBeqTemp;
	assign pcJr = (jrCtrl_Hz == 1)? grfWd_Wb:
					  (jrCtrl_Hz == 2)? jrFw1_Hz:
					  (jrCtrl_Hz == 3)? jrFw2_Hz:
					  rD1;
	
	assign nextPc_If = (ifJ)? pcJ:
							 (ifJal)? pcJal:
							 (ifJr)? pcJr:
							 ((ifBeq) && (cmp1 == cmp2))? pcBeqAct:
							 32'h00003000;
	assign ifPcBranch_If = ((ifJ) || (ifJal) || (ifJr) || ((ifBeq) && (cmp1 == cmp2)));
	////////////
	
	//for cmp
	
	assign cmp1 = (cmp1Ctrl_Hz == 1)? grfWd_Wb:
					  (cmp1Ctrl_Hz == 2)? cmp1Fw1_Hz:
					  (cmp1Ctrl_Hz == 3)? cmp1Fw2_Hz:
					  rD1;
	assign cmp2 = (cmp2Ctrl_Hz == 1)? grfWd_Wb:
					  (cmp2Ctrl_Hz == 2)? cmp2Fw1_Hz:
					  (cmp2Ctrl_Hz == 3)? cmp2Fw2_Hz:
					  rD2;
	/////////
	
	//for IdToEx
	assign pc_IdToEx = pc_IfToId;
	assign instr_IdToEx = instr_IfToId;
	assign grfRd1_IdToEx = cmp1;
	assign grfRd2_IdToEx = cmp2;
	assign rs_IdToEx = instr_IfToId[25:21];
	assign rt_IdToEx = instr_IfToId[20:16];
	assign rd_IdToEx = instr_IfToId[15:11];
	assign immExt_IdToEx = immExt;
	//why pc + 8
	assign grfWd_IdToEx = (ifJal)? (pc_IfToId + 8):
								 0;
endmodule
