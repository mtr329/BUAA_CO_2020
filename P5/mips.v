`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:06:24 11/23/2020 
// Design Name: 
// Module Name:    mips 
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
module mips(
	input clk,
	input reset
    );
	//xxx_From
	//If
	wire ifStall;
	wire [31:0]nextPc_Id;
	wire ifPcBranch_Id;
	//If-Id
	wire [31:0]pc_If;
	wire [31:0]instr_If;
	wire reset_If;
	//Id
	wire [31:0]pc_IfToId;
	wire [31:0]instr_IfToId;
	wire reset_IfToId;
	wire [4:0]grfWa_Wb;
	wire [31:0]grfWd_Wb;
	wire ifWrGrf_Wb;
	wire [31:0]pc_Wb;
	wire [4:0]cmp1Ctrl_Hz;
	wire [4:0]cmp2Ctrl_Hz;
	wire [31:0]cmp1Fw1_Hz;
	wire [31:0]cmp1Fw2_Hz;
	wire [31:0]cmp2Fw1_Hz;
	wire [31:0]cmp2Fw2_Hz;
	wire [4:0]jrCtrl_Hz;
	wire [31:0]jrFw1_Hz;
	wire [31:0]jrFw2_Hz;
	//Id-Ex
	wire [31:0]pc_Id;
	wire [31:0]instr_Id;
	wire reset_Id;
	wire [4:0]rs_Id;
	wire [4:0]rt_Id;
	wire [4:0]rd_Id;
	wire [31:0]immExt_Id;
	wire [31:0]grfRd1_Id;
	wire [31:0]grfRd2_Id;
	wire ifReGrf1_Id;
	wire ifReGrf2_Id;
	wire ifWrGrf_Id;
	wire [4:0]grfRa1_Id;
	wire [4:0]grfRa2_Id;
	wire [4:0]grfWa_Id;
	wire [31:0]grfWd_Id;
	wire [4:0]tUseRs_Id;
	wire [4:0]tUseRt_Id;
	wire [4:0]tNew_Id;
	//Ex
	wire [31:0]pc_IdToEx;
	wire [31:0]instr_IdToEx;
	wire reset_IdToEx;
	wire [31:0]immExt_IdToEx;
	wire [31:0]grfRd1_IdToEx;
	wire [31:0]grfRd2_IdToEx;
	wire [4:0]aluACtrl_Hz;
	wire [4:0]aluBCtrl_Hz;
	wire [31:0]aluAFw1_Hz;
	wire [31:0]aluAFw2_Hz;
	wire [31:0]aluBFw1_Hz;
	wire [31:0]aluBFw2_Hz;
	wire ifReGrf1_IdToEx;
	wire ifReGrf2_IdToEx;
	wire ifWrGrf_IdToEx;
	wire [4:0]grfRa1_IdToEx;
	wire [4:0]grfRa2_IdToEx;
	wire [4:0]grfWa_IdToEx;
	wire [31:0]grfWd_IdToEx;
	wire [4:0]tUseRs_IdToEx;
	wire [4:0]tUseRt_IdToEx;
	wire [4:0]tNew_IdToEx;
	//Ex-Mem
	wire [31:0]pc_Ex;
	wire [31:0]instr_Ex;
	wire reset_Ex;
	wire [31:0]aluAns_Ex;
	wire [31:0]grfRd2_Ex;
	wire ifReGrf1_Ex;
	wire ifReGrf2_Ex;
	wire ifWrGrf_Ex;
	wire [4:0]grfRa1_Ex;
	wire [4:0]grfRa2_Ex;
	wire [4:0]grfWa_Ex;
	wire [4:0]tUseRs_Ex;
	wire [4:0]tUseRt_Ex;
	wire [4:0]tNew_Ex;
	wire [31:0]grfWd_Ex;
	//Mem
	wire [31:0]pc_ExToMem;
	wire [31:0]instr_ExToMem;
	wire reset_ExToMem;
	wire [31:0]aluAns_ExToMem;
	wire [31:0]grfRd2_ExToMem;
	wire [4:0]dmInCtrl_Hz;
	wire [31:0]dmInFw_Hz;
	wire ifReGrf1_ExToMem;
	wire ifReGrf2_ExToMem;
	wire ifWrGrf_ExToMem;
	wire [4:0]grfRa1_ExToMem;
	wire [4:0]grfRa2_ExToMem;
	wire [4:0]grfWa_ExToMem;
	wire [4:0]tUseRs_ExToMem;
	wire [4:0]tUseRt_ExToMem;
	wire [4:0]tNew_ExToMem;
	wire [31:0]grfWd_ExToMem; 
	//Mem-Wb
	wire [31:0]pc_Mem;
	wire [31:0]instr_Mem;
	wire reset_Mem;
	wire [31:0]dmRd_Mem;
	wire [31:0]aluAns_Mem;
	wire [4:0]grfWa_Mem;
	wire ifReGrf1_Mem;
	wire ifReGrf2_Mem;
	wire ifWrGrf_Mem;
	wire [4:0]grfRa1_Mem;
	wire [4:0]grfRa2_Mem;
	//no use input [4:0]grfWa_Mem,
	wire [4:0]tUseRs_Mem;
	wire [4:0]tUseRt_Mem;
	wire [4:0]tNew_Mem;
	wire [31:0]grfWd_Mem;
	//Wb
	wire [31:0]instr_MemToWb;
	wire reset_MemToWb;
	wire [4:0]grfWa_MemToWb;
	wire [31:0]grfWd_MemToWb;
	wire [31:0]pc_MemToWb;
	// addition from hz
	wire ifWrGrf_MemToWb;
	wire [4:0]tNew_MemToWb;
	wire [4:0]grfRaCmp1_IfToId;
	wire [4:0]grfRaCmp2_IfToId;
	wire [4:0]grfRaAluA_IdToEx;
	wire [4:0]grfRaAluB_IdToEx;
	wire [4:0]grfRaDmIn_ExToMem;
	
	If if_Main(
		.clk(clk),
		.reset(reset),
		.stall(ifStall),
		.pc_Id(nextPc_Id),
		.ifPcBranch_Id(ifPcBranch_Id),
			
		.pc_IfToId(pc_If),
		.instr_IfToId(instr_If),
		.reset_IfToId(reset_If)
	);
	
	IfToId ifToId_Main(
		.clk(clk),
		.reset_If(reset_If),
		.stall(ifStall),
		.pc_If(pc_If),
		.instr_If(instr_If),
		
		.pc_Id(pc_IfToId),
		.instr_Id(instr_IfToId),
		.reset_Id(reset_IfToId),
		.grfRaCmp1_Hz(grfRaCmp1_IfToId),
		.grfRaCmp2_Hz(grfRaCmp2_IfToId)
		//output reg [4:0]grfRaPc_Hz*/
	);
	
	Id id_Main(
		.clk(clk),
		.reset_IfToId(reset_IfToId),
		.pc_IfToId(pc_IfToId),
		.instr_IfToId(instr_IfToId),
			.grfWa_Wb(grfWa_Wb),
			.grfWd_Wb(grfWd_Wb),
			.ifWrGrf_Wb(ifWrGrf_Wb),
			.pcForGrf_Wb(pc_Wb),
		.cmp1Ctrl_Hz(cmp1Ctrl_Hz),
		.cmp2Ctrl_Hz(cmp2Ctrl_Hz),
		.cmp1Fw1_Hz(cmp1Fw1_Hz),
		.cmp1Fw2_Hz(cmp1Fw2_Hz),
		.cmp2Fw1_Hz(cmp2Fw1_Hz),
		.cmp2Fw2_Hz(cmp2Fw2_Hz),
		.jrCtrl_Hz(jrCtrl_Hz),
		.jrFw1_Hz(jrFw1_Hz), 
		.jrFw2_Hz(jrFw2_Hz),
		
		.pc_IdToEx(pc_Id),
		.instr_IdToEx(instr_Id),
		.reset_IdToEx(reset_Id),
		.grfRd1_IdToEx(grfRd1_Id),
		.grfRd2_IdToEx(grfRd2_Id),
		.rs_IdToEx(rs_Id),
		.rt_IdToEx(rt_Id),
		.rd_IdToEx(rd_Id),
		.immExt_IdToEx(immExt_Id),
			.ifReGrf1_IdToEx(ifReGrf1_Id),
			.ifReGrf2_IdToEx(ifReGrf2_Id),
			.ifWrGrf_IdToEx(ifWrGrf_Id),
			.grfRa1_IdToEx(grfRa1_Id),
			.grfRa2_IdToEx(grfRa2_Id),
			.grfWa_IdToEx(grfWa_Id),
			.grfWd_IdToEx(grfWd_Id),
			.tUseRs_IdToEx(tUseRs_Id),
			.tUseRt_IdToEx(tUseRt_Id),
			.tNew_IdToEx(tNew_Id),
		.nextPc_If(nextPc_Id),
		.ifPcBranch_If(ifPcBranch_Id)
		//not need  output [4:0]grfWa_Hz//for judging hzCtrl
	);
	
	IdToEx idToEx_Main(
		.clk(clk),
		.reset_Id(reset_Id),
		.stall(ifStall),
		.pc_Id(pc_Id),
		.instr_Id(instr_Id),
		.rs_Id(rs_Id),
		.rt_Id(rt_Id),
		.rd_Id(rd_Id),
		.immExt_Id(immExt_Id),
		.grfRd1_Id(grfRd1_Id),
		.grfRd2_Id(grfRd2_Id),
			.ifReGrf1_Id(ifReGrf1_Id),
			.ifReGrf2_Id(ifReGrf2_Id),
			.ifWrGrf_Id(ifWrGrf_Id),
			.grfRa1_Id(grfRa1_Id),
			.grfRa2_Id(grfRa2_Id),
			.grfWa_Id(grfWa_Id),
			.grfWd_Id(grfWd_Id),
			.tUseRs_Id(tUseRs_Id),
			.tUseRt_Id(tUseRt_Id),
			.tNew_Id(tNew_Id),
			
		.pc_Ex(pc_IdToEx),
		.instr_Ex(instr_IdToEx),
		.reset_Ex(reset_IdToEx),
		.immExt_Ex(immExt_IdToEx),
		.grfRd1_Ex(grfRd1_IdToEx),
		.grfRd2_Ex(grfRd2_IdToEx),
			.ifReGrf1_Hz_Ex(ifReGrf1_IdToEx),
			.ifReGrf2_Hz_Ex(ifReGrf2_IdToEx),
			.ifWrGrf_Hz_Ex(ifWrGrf_IdToEx),
			.grfRa1_Hz_Ex(grfRa1_IdToEx),
			.grfRa2_Hz_Ex(grfRa2_IdToEx),
			.grfWa_Hz_Ex(grfWa_IdToEx),
			.grfWd_Hz_Ex(grfWd_IdToEx),
			.tUseRs_Hz_Ex(tUseRs_IdToEx),
			.tUseRt_Hz_Ex(tUseRt_IdToEx),
			.tNew_Hz_Ex(tNew_IdToEx),
		.grfRaAluA_Hz(grfRaAluA_IdToEx),
		.grfRaAluB_Hz(grfRaAluB_IdToEx)
	);
	
	Ex ex_Main(
		.pc_IdToEx(pc_IdToEx),
		.instr_IdToEx(instr_IdToEx),
		.reset_IdToEx(reset_IdToEx),
		.immExt_IdToEx(immExt_IdToEx),
		.grfRd1_IdToEx(grfRd1_IdToEx),
		.grfRd2_IdToEx(grfRd2_IdToEx),
		.aluACtrl_Hz(aluACtrl_Hz),
		.aluBCtrl_Hz(aluBCtrl_Hz),
		.aluAFw1_Hz(aluAFw1_Hz),
		.aluAFw2_Hz(aluAFw2_Hz),
		.aluBFw1_Hz(aluBFw1_Hz),
		.aluBFw2_Hz(aluBFw2_Hz),
			.ifReGrf1_IdToEx(ifReGrf1_IdToEx),
			.ifReGrf2_IdToEx(ifReGrf2_IdToEx),
			.ifWrGrf_IdToEx(ifWrGrf_IdToEx),
			.grfRa1_IdToEx(grfRa1_IdToEx),
			.grfRa2_IdToEx(grfRa2_IdToEx),
			.grfWa_IdToEx(grfWa_IdToEx),
			.grfWd_IdToEx(grfWd_IdToEx),
			.tUseRs_IdToEx(tUseRs_IdToEx),
			.tUseRt_IdToEx(tUseRt_IdToEx),
			.tNew_IdToEx(tNew_IdToEx),
	
		.pc_ExToMem(pc_Ex),
		.instr_ExToMem(instr_Ex),
		.reset_ExToMem(reset_Ex),
		.aluAns_ExToMem(aluAns_Ex),
		.grfRd2_ExToMem(grfRd2_Ex),
			.ifReGrf1_ExToMem(ifReGrf1_Ex),
			.ifReGrf2_ExToMem(ifReGrf2_Ex),
			.ifWrGrf_ExToMem(ifWrGrf_Ex),
			.grfRa1_ExToMem(grfRa1_Ex),
			.grfRa2_ExToMem(grfRa2_Ex),
			.grfWa_ExToMem(grfWa_Ex),
			.tUseRs_ExToMem(tUseRs_Ex),
			.tUseRt_ExToMem(tUseRt_Ex),
			.tNew_ExToMem(tNew_Ex),
			.grfWd_ExToMem(grfWd_Ex)
	);
	
	ExToMem exToMem(
		.clk(clk),
		.reset_Ex(reset_Ex),
		.pc_Ex(pc_Ex),
		.instr_Ex(instr_Ex),
		.aluAns_Ex(aluAns_Ex),
		.grfRd2_Ex(grfRd2_Ex),
			.ifReGrf1_Ex(ifReGrf1_Ex),
			.ifReGrf2_Ex(ifReGrf2_Ex),
			.ifWrGrf_Ex(ifWrGrf_Ex),
			.grfRa1_Ex(grfRa1_Ex),
			.grfRa2_Ex(grfRa2_Ex),
			.grfWa_Ex(grfWa_Ex),
			.tUseRs_Ex(tUseRs_Ex),
			.tUseRt_Ex(tUseRt_Ex),
			.tNew_Ex(tNew_Ex),
			.grfWd_Ex(grfWd_Ex),

		.pc_Mem(pc_ExToMem),
		.instr_Mem(instr_ExToMem),
		.reset_Mem(reset_ExToMem),
		.aluAns_Mem(aluAns_ExToMem),
		.grfRd2_Mem(grfRd2_ExToMem),
			.ifReGrf1_Hz_Mem(ifReGrf1_ExToMem),
			.ifReGrf2_Hz_Mem(ifReGrf2_ExToMem),
			.ifWrGrf_Hz_Mem(ifWrGrf_ExToMem),
			.grfRa1_Hz_Mem(grfRa1_ExToMem),
			.grfRa2_Hz_Mem(grfRa2_ExToMem),
			.grfWa_Hz_Mem(grfWa_ExToMem),
			.tUseRs_Hz_Mem(tUseRs_ExToMem),
			.tUseRt_Hz_Mem(tUseRt_ExToMem),
			.tNew_Hz_Mem(tNew_ExToMem),
			.grfWd_Hz_Mem(grfWd_ExToMem),	
		.grfRaDmIn_Hz(grfRaDmIn_ExToMem)
	);
	
	Mem mem_Main(
		.clk(clk),
		.reset_ExToMem(reset_ExToMem),
		.pc_ExToMem(pc_ExToMem),
		.instr_ExToMem(instr_ExToMem),
		.aluAns_ExToMem(aluAns_ExToMem),
		.grfRd2_ExToMem(grfRd2_ExToMem),
		.dmInCtrl_Hz(dmInCtrl_Hz),//forward
		.dmInFw_Hz(dmInFw_Hz),
			.ifReGrf1_ExToMem(ifReGrf1_ExToMem),
			.ifReGrf2_ExToMem(ifReGrf2_ExToMem),
			.ifWrGrf_ExToMem(ifWrGrf_ExToMem),
			.grfRa1_ExToMem(grfRa1_ExToMem),
			.grfRa2_ExToMem(grfRa2_ExToMem),
			.grfWa_ExToMem(grfWa_ExToMem),
			.tUseRs_ExToMem(tUseRs_ExToMem),
			.tUseRt_ExToMem(tUseRt_ExToMem),
			.tNew_ExToMem(tNew_ExToMem),
			.grfWd_ExToMem(grfWd_ExToMem),
	
		.pc_MemToWb(pc_Mem),
		.instr_MemToWb(instr_Mem),
		.reset_MemToWb(reset_Mem),
		.dmRd_MemToWb(dmRd_Mem),
		.aluAns_MemToWb(aluAns_Mem),
		//grfWa_MemToWb, (line 49)
			.ifReGrf1_MemToWb(ifReGrf1_Mem),
			.ifReGrf2_MemToWb(ifReGrf2_Mem),
			.ifWrGrf_MemToWb(ifWrGrf_Mem),
			.grfRa1_MemToWb(grfRa1_Mem),
			.grfRa2_MemToWb(grfRa2_Mem),
			.grfWa_MemToWb(grfWa_Mem),
			.tUseRs_MemToWb(tUseRs_Mem),
			.tUseRt_MemToWb(tUseRt_Mem),
			.tNew_MemToWb(tNew_Mem),
			.grfWd_MemToWb(grfWd_Mem)
	);
	
	MemToWb memToWb_Main(
		.clk(clk),
		.reset_Mem(reset_Mem),
		.pc_Mem(pc_Mem),
		.instr_Mem(instr_Mem),
		.dmRd_Mem(dmRd_Mem),
		.aluAns_Mem(aluAns_Mem),
		.grfWa_Mem(grfWa_Mem),
			.ifReGrf1_Mem(ifReGrf1_Mem),
			.ifReGrf2_Mem(ifReGrf2_Mem),
			.ifWrGrf_Mem(ifWrGrf_Mem),
			.grfRa1_Mem(grfRa1_Mem),
			.grfRa2_Mem(grfRa2_Mem),
			//no use input [4:0]grfWa_Mem,
			.tUseRs_Mem(tUseRs_Mem),
			.tUseRt_Mem(tUseRt_Mem),
			.tNew_Mem(tNew_Mem),
			.grfWd_Mem(grfWd_Mem),
		
	.pc_Wb(pc_MemToWb),
	.instr_Wb(instr_MemToWb),
	//no need .reset_Wb(reset_MemToWb),
	//output reg [31:0]dmRd_Wb(),
	//output reg [31:0]aluAns_Wb(),
	.grfWa_Wb(grfWa_MemToWb),
		/*	
		output reg ifReGrf1_Hz_Wb(),
		output reg ifReGrf2_Hz_Wb(),
		output reg ifWrGrf_Hz_Wb(),
		output reg [4:0]grfRa1_Hz_Wb(),
		output reg [4:0]grfRa2_Hz_Wb(),
		output reg [4:0]grfWa_Hz_Wb(),
		output reg [4:0]tUseRs_Hz_Wb(),
		output reg [4:0]tUseRt_Hz_Wb(),
		output reg [4:0]tNew_Hz_Wb(),
		*/
	.grfWd_Hz_Wb(grfWd_MemToWb)
	
	);
	
	Wb wb_Main(
		.instr_MemToWb(instr_MemToWb),
		.grfWa_MemToWb(grfWa_MemToWb),
		.grfWd_MemToWb(grfWd_MemToWb),
		.pc_MemToWb(pc_MemToWb),
			
		.grfWd_Id(grfWd_Wb),
		.grfWa_Id(grfWa_Wb),
		.ifWrGrf_Id(ifWrGrf_Wb),
		.pc_Id(pc_Wb)
	);
	
	Hazzard hazzard_Main(
		//Id readAddr and tUse
		.ifReGrf1_Id(ifReGrf1_Id),
		.ifReGrf2_Id(ifReGrf2_Id),
		.grfRa1_Id(grfRa1_Id),
		.grfRa2_Id(grfRa2_Id),
		.tUseRs_Id(tUseRs_Id),
		.tUseRt_Id(tUseRt_Id),
		//others' writeAddr and tNew
		//Ex
		.ifWrGrf_IdToEx(ifWrGrf_IdToEx),
		.grfWa_IdToEx(grfWa_IdToEx),
		.tNew_IdToEx(tNew_IdToEx),
		.grfWd_IdToEx(grfWd_IdToEx),
		//Mem
		.ifWrGrf_ExToMem(ifWrGrf_ExToMem),
		.grfWa_ExToMem(grfWa_ExToMem),
		.tNew_ExToMem(tNew_ExToMem),
		.grfWd_ExToMem(grfWd_ExToMem),
		//Wb
		.ifWrGrf_MemToWb(ifWrGrf_MemToWb),
		.grfWa_MemToWb(grfWa_MemToWb),
		.tNew_MemToWb(tNew_MemToWb),
		.grfWd_MemToWb(grfWd_MemToWb),
		///////////
		.grfRaCmp1_IfToId(grfRaCmp1_IfToId),
		.grfRaCmp2_IfToId(grfRaCmp2_IfToId),
		.grfRaAluA_IdToEx(grfRaAluA_IdToEx),
		.grfRaAluB_IdToEx(grfRaAluB_IdToEx),
		.grfRaDmIn_ExToMem(grfRaDmIn_ExToMem),
		
		//output 
		.ifStall(ifStall),
		//cmp
		.cmp1Ctrl_Id(cmp1Ctrl_Hz),
		.cmp2Ctrl_Id(cmp2Ctrl_Hz),
		.cmp1Fw1_Id(cmp1Fw1_Hz),
		.cmp1Fw2_Id(cmp1Fw2_Hz),
		.cmp2Fw1_Id(cmp2Fw1_Hz),
		.cmp2Fw2_Id(cmp2Fw2_Hz),
		//alu
		.aluACtrl_Ex(aluACtrl_Hz),
		.aluBCtrl_Ex(aluBCtrl_Hz),
		.aluAFw1_Ex(aluAFw1_Hz),
		.aluAFw2_Ex(aluAFw2_Hz),
		.aluBFw1_Ex(aluBFw1_Hz),
		.aluBFw2_Ex(aluBFw2_Hz),
		//dm
		.dmInCtrl_Mem(dmInCtrl_Hz),
		.dmInFw_Mem(dmInFw_Hz),
		//jr
		.jrCtrl_Id(jrCtrl_Hz),
		.jrFw1_Id(jrFw1_Hz),
		.jrFw2_Id(jrFw2_Hz)
	);

endmodule
