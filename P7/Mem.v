`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:51 12/01/2020 
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
	input reset_ExMem,
	input [31:0]pc_ExMem,
	input [31:0]instr_ExMem,
	input [4:0]excCode_ExMem,
	input ifBd,
	input [31:0]globalAddr,
	input [31:0]cmp1_ExMem,
	input [5:0]hwInt_Outside,
	input [31:0]dIn_Bridge,
	input [31:0]aluAns_ExMem,
	input [31:0]grfRd2_ExMem,
	//from Fs
	input [31:0]dmWd_Fs,
	//for Hz
	input ifReGrf1_ExMem,
	input ifReGrf2_ExMem,
	input ifWrGrf_ExMem,
	input [4:0]grfRa1_ExMem,
	input [4:0]grfRa2_ExMem,
	input [4:0]grfWa_ExMem,
	input [31:0]grfWd_ExMem,
	input [4:0]tUseRs_ExMem,
	input [4:0]tUseRt_ExMem,
	input [4:0]tNew_ExMem,
		
	output reset_MemWb,
	output [31:0]pc_MemWb,
	output [31:0]instr_MemWb,
	output [4:0]excCode_MemWb,
	output [31:0]epc,
	output [31:0]cp0_Out,
	output ifExcOrInt,
	output ifMtc0,
	output ifEret,
	output ifWr_Bridge,
	output [31:0]dmRd_MemWb,
	output [31:0]aluAns_MemWb,
	//for Hz
	output ifReGrf1_MemWb,
	output ifReGrf2_MemWb,
	output ifWrGrf_MemWb,
	output [4:0]grfRa1_MemWb,
	output [4:0]grfRa2_MemWb,
	output [4:0]grfWa_MemWb,
	output [31:0]grfWd_MemWb,
	output [4:0]tUseRs_MemWb,
	output [4:0]tUseRt_MemWb,
	output [4:0]tNew_MemWb
    );
	 
	wire [4:0]loadCtrl;
	wire [4:0]saveCtrl;
	wire ifLoad;
	wire ifSave;
	//
	//wire ifExcOrInt;
	wire ifInt;
	wire addrHitDm;
	wire addrHitDev0;
	wire addrHitDev1;
	wire ifMfc0;
	//wire ifMtc0;
	//wire ifEret;
	wire ifBranch;
	wire ifJump;
	wire [31:0]pc_Cp0;
	wire ifJalr;
	wire ifJr;
	
	Cp0 cp0(
		.clk(clk),
		.reset(reset_ExMem),
		.wEn(ifMtc0),
		.exlSet(excCode_MemWb!=0),
		.exlClr(ifEret),
		.ifBd(ifBd),
		.hwInt(hwInt_Outside),
		.excCode(excCode_MemWb),
		.rA(instr_ExMem[15:11]),
		.wA(instr_ExMem[15:11]),
		.dIn(dmWd_Fs),
		.pc(globalAddr),
		
		.epc(epc),
		.dOut(cp0_Out),
		.ifExcOrInt(ifExcOrInt)
	);
	
	
	Controller controller_Mem(
		.instr(instr_ExMem),
		
		.loadCtrl(loadCtrl),
		.saveCtrl(saveCtrl),
		.ifLoad(ifLoad),
		.ifSave(ifSave),
		.ifMtc0(ifMtc0),
		.ifMfc0(ifMfc0),
		.ifEret(ifEret),
		.ifBranch(ifBranch),
		.ifJump(ifJump),
		.ifJalr(ifJalr),
		.ifJr(ifJr)
	);

	Dm dm_Mem(
		.pc(pc_ExMem),
		.clk(clk),
		.reset(reset_ExMem),
		.rEn(ifLoad),
		.wEn((ifSave) & (addrHitDm) & (!ifExcOrInt)),
		.addr(aluAns_ExMem),
		.dIn(dmWd_Fs),
		.loadCtrl(loadCtrl), // 1.lb, 2.lbu, 3.lh, 4.lhu, 5.lw
		.saveCtrl(saveCtrl), // 1.sb, 2.sh,  3.sw
		
		.dOut(dmRd_MemWb)
	);
	
	//assign ifExcOrInt		=	ifInt;
	/*
	assign pc_Cp0			=	(ifJalr | ifJr)?
									(cmp1_ExMem):
									(pc_ExMem);
	*/								
	assign addrHitDm		=	($signed(aluAns_ExMem)>=0 && $signed(aluAns_ExMem)<=32'h2fff);
	assign addrHitDev0	=	($signed(aluAns_ExMem)>=32'h7f00 && $signed(aluAns_ExMem)<=32'h7f0b);
	assign addrHitDev1	=	($signed(aluAns_ExMem)>=32'h7f10 && $signed(aluAns_ExMem)<=32'h7f1b);
	
	assign ifWr_Bridge	=	((ifSave) & (addrHitDev0 || addrHitDev1) & (!ifExcOrInt));
	
	assign excCode_MemWb	=	(excCode_ExMem > 0)?
									(excCode_ExMem):
									(
										((loadCtrl == 5) & (aluAns_ExMem[1:0]!=0))|
										((loadCtrl == 4 || loadCtrl == 3) & (aluAns_ExMem[0]!=0))|
										((loadCtrl == 1 || loadCtrl == 2 || loadCtrl == 3 || loadCtrl == 4) & (addrHitDev0 || addrHitDev1))|
										//计算地址加法溢出在前一级
										((ifLoad) & (!(addrHitDm || addrHitDev0 || addrHitDev1)))
									)?
									4:
									(
										((saveCtrl == 3) & (aluAns_ExMem[1:0]!=0))|
										((saveCtrl == 2) & (aluAns_ExMem[0]!=0))|
										((saveCtrl == 1 || saveCtrl == 2) & (addrHitDev0 || addrHitDev1))|
										((ifSave) & (addrHitDev0 || addrHitDev1) & (aluAns_ExMem[3:2]==2'b10))|
										((ifSave) & (!(addrHitDm || addrHitDev0 || addrHitDev1)))
									)?
									5:
									0;
									
	
	assign pc_MemWb 		= pc_ExMem;
	assign instr_MemWb 	= instr_ExMem;
	assign reset_MemWb	= reset_ExMem;
	assign aluAns_MemWb	= aluAns_ExMem;
	//for Hz
	assign ifReGrf1_MemWb	= ifReGrf1_ExMem;
	assign ifReGrf2_MemWb	= ifReGrf2_ExMem;
	assign ifWrGrf_MemWb 	= ifWrGrf_ExMem;
	assign grfRa1_MemWb 		= grfRa1_ExMem;
	assign grfRa2_MemWb 		= grfRa2_ExMem;
	assign grfWa_MemWb 		= grfWa_ExMem;
	
	assign grfWd_MemWb 		=	(ifMfc0)?
										(cp0_Out):
										((ifLoad) & (addrHitDev0 || addrHitDev1))? 
										(dIn_Bridge):
										((ifLoad) & (addrHitDm))? 
										(dmRd_MemWb):
										(grfWd_ExMem);
										
	assign tUseRs_ExMem 		= tUseRs_ExMem;
	assign tUseRt_MemWb 		= tUseRt_ExMem;
	assign tNew_MemWb 		= (tNew_ExMem == 0)? 0:
									  (tNew_ExMem - 1);

endmodule
