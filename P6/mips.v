`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:57:00 12/01/2020 
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
	
	//If
	wire ifStall;
	wire ifBranchOrJump_Id;
	wire [31:0]pcNext_Id;
	//IfId
	wire reset_If;
	wire [31:0]pc_If;
	wire [31:0]instr_If;
	//Id
	wire reset_IfId;
	wire [31:0]pc_IfId;
	wire [31:0]instr_IfId;
	wire [31:0]pc_Wb;
	wire [4:0]grfWa_Wb;
	wire [31:0]grfWd_Wb;
	wire ifWrGrf_Wb;
	wire [31:0]grfCmp1_Fs;
	wire [31:0]grfCmp2_Fs;
	//IdEx
	wire reset_Id;
	wire [31:0]pc_Id;
	wire [31:0]instr_Id;
	wire [31:0]grfRd1_Id;
	wire [31:0]grfRd2_Id;
	wire [31:0]immExt_Id;
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
	wire reset_IdEx;
	wire [31:0]pc_IdEx;
	wire [31:0]instr_IdEx;
	wire [31:0]grfRd1_IdEx;
	wire [31:0]grfRd2_IdEx;
	wire [31:0]immExt_IdEx;
	wire [31:0]calA_Fs;
	wire [31:0]calB_Fs;
	wire ifReGrf1_IdEx;
	wire ifReGrf2_IdEx;
	wire ifWrGrf_IdEx;
	wire [4:0]grfRa1_IdEx;
	wire [4:0]grfRa2_IdEx;
	wire [4:0]grfWa_IdEx;
	wire [31:0]grfWd_IdEx;
	wire [4:0]tUseRs_IdEx;
	wire [4:0]tUseRt_IdEx;
	wire [4:0]tNew_IdEx;
	//ExMem
	wire reset_Ex;
	wire [31:0]pc_Ex;
	wire [31:0]instr_Ex;
	wire [31:0]aluAns_Ex;
	wire [31:0]grfRd2_Ex;
	wire ifReGrf1_Ex;
	wire ifReGrf2_Ex;
	wire ifWrGrf_Ex;
	wire [4:0]grfRa1_Ex;
	wire [4:0]grfRa2_Ex;
	wire [4:0]grfWa_Ex;
	wire [31:0]grfWd_Ex;
	wire [4:0]tUseRs_Ex;
	wire [4:0]tUseRt_Ex;
	wire [4:0]tNew_Ex;
	//Mem
	wire reset_ExMem;
	wire [31:0]pc_ExMem;
	wire [31:0]instr_ExMem;
	wire [31:0]aluAns_ExMem;
	wire [31:0]grfRd2_ExMem;
	wire [31:0]dmWd_Fs;
	wire ifReGrf1_ExMem;
	wire ifReGrf2_ExMem;
	wire ifWrGrf_ExMem;
	wire [4:0]grfRa1_ExMem;
	wire [4:0]grfRa2_ExMem;
	wire [4:0]grfWa_ExMem;
	wire [31:0]grfWd_ExMem;
	wire [4:0]tUseRs_ExMem;
	wire [4:0]tUseRt_ExMem;
	wire [4:0]tNew_ExMem;
	//MemWb
	wire reset_Mem;
	wire [31:0]pc_Mem;
	wire [31:0]instr_Mem;
	wire [31:0]dmRd_Mem;
	wire [31:0]aluAns_Mem;
	wire [4:0]grfWa_Mem;
	wire ifReGrf1_Mem;
	wire ifReGrf2_Mem;
	wire ifWrGrf_Mem;
	wire [4:0]grfRa1_Mem;
	wire [4:0]grfRa2_Mem;
	wire [31:0]grfWd_Mem;
	wire [4:0]tUseRs_Mem;
	wire [4:0]tUseRt_Mem;
	wire [4:0]tNew_Mem;
	//Wb
	wire [31:0]pc_MemWb;
	wire [31:0]instr_MemWb;
	wire [4:0]grfWa_MemWb;
	wire [31:0]grfWd_MemWb;
	//Fs
	wire [4:0]grfRa1_IfId;
	wire [4:0]grfRa2_IfId;
	wire [31:0]grfDirRd1_Id;
	wire [31:0]grfDirRd2_Id;		
	//SS
	wire ifBusy_Ex;
	wire ifStart_Ex;
	
	If if_Main(
		.clk(clk),
		.reset(reset),
		.ifStall(ifStall),
		.ifBranchOrJump_Id(ifBranchOrJump_Id),
		.pc_Id(pcNext_Id),
		
		.reset_IfId(reset_If),
		.pc_IfId(pc_If),
		.instr_IfId(instr_If)
	);
	
	IfId ifId_Main(
		.clk(clk),
		.reset_If(reset_If),
		.ifStall(ifStall),
		.pc_If(pc_If),
		.instr_If(instr_If),
		
		.reset_Id(reset_IfId),
		.pc_Id(pc_IfId),
		.instr_Id(instr_IfId),
		.grfRa1_Fs(grfRa1_IfId),
		.grfRa2_Fs(grfRa2_IfId)
	);
	
	Id id_Main(
		.clk(clk),
		.reset_IfId(reset_IfId),
		.pc_IfId(pc_IfId),
		.instr_IfId(instr_IfId),
		//from Wb
		.pc_Wb(pc_Wb),
		.grfWa_Wb(grfWa_Wb),
		.grfWd_Wb(grfWd_Wb),
		.ifWrGrf_Wb(ifWrGrf_Wb),
		//from Hz
		.grfCmp1_Fs(grfCmp1_Fs),
		.grfCmp2_Fs(grfCmp2_Fs),
		
		.reset_IdEx(reset_Id),
		.pc_IdEx(pc_Id),
		.instr_IdEx(instr_Id),
		.grfRd1_IdEx(grfRd1_Id),
		.grfRd2_IdEx(grfRd2_Id),
		.immExt_IdEx(immExt_Id),
		//for If
		.pcNext_If(pcNext_Id),
		.ifBranchOrJump_If(ifBranchOrJump_Id),
		//for Hz
		.ifReGrf1_IdEx(ifReGrf1_Id),
		.ifReGrf2_IdEx(ifReGrf2_Id),
		.ifWrGrf_IdEx(ifWrGrf_Id),
		.grfRa1_IdEx(grfRa1_Id),
		.grfRa2_IdEx(grfRa2_Id),
		.grfWa_IdEx(grfWa_Id),
		.grfWd_IdEx(grfWd_Id),
		.tUseRs_IdEx(tUseRs_Id),
		.tUseRt_IdEx(tUseRt_Id),
		.tNew_IdEx(tNew_Id),
		.grfDirRd1_Fs(grfDirRd1_Id),
		.grfDirRd2_Fs(grfDirRd2_Id)
	);
	
	IdEx idEx_Main(
		.clk(clk),
		.ifStall(ifStall),
		.reset_Id(reset_Id),
		.pc_Id(pc_Id),
		.instr_Id(instr_Id),
		.grfRd1_Id(grfRd1_Id),
		.grfRd2_Id(grfRd2_Id),
		.immExt_Id(immExt_Id),
		//for hazzard
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
			
		.reset_Ex(reset_IdEx),
		.pc_Ex(pc_IdEx),
		.instr_Ex(instr_IdEx),
		.grfRd1_Ex(grfRd1_IdEx),
		.grfRd2_Ex(grfRd2_IdEx),
		.immExt_Ex(immExt_IdEx),
		//for hazzard
		.ifReGrf1_Ex(ifReGrf1_IdEx),
		.ifReGrf2_Ex(ifReGrf2_IdEx),
		.ifWrGrf_Ex(ifWrGrf_IdEx),
		.grfRa1_Ex(grfRa1_IdEx),
		.grfRa2_Ex(grfRa2_IdEx),
		.grfWa_Ex(grfWa_IdEx),
		.grfWd_Ex(grfWd_IdEx),
		.tUseRs_Ex(tUseRs_IdEx),
		.tUseRt_Ex(tUseRt_IdEx),
		.tNew_Ex(tNew_IdEx)
	);
	
	Ex ex_Main(
		.clk(clk),
		.reset_IdEx(reset_IdEx),
		.pc_IdEx(pc_IdEx),
		.instr_IdEx(instr_IdEx),
		.grfRd1_IdEx(grfRd1_IdEx),
		.grfRd2_IdEx(grfRd2_IdEx),
		.immExt_IdEx(immExt_IdEx),
		//from Fs
		.calA_Fs(calA_Fs),
		.calB_Fs(calB_Fs),
		//for Hz
		.ifReGrf1_IdEx(ifReGrf1_IdEx),
		.ifReGrf2_IdEx(ifReGrf2_IdEx),
		.ifWrGrf_IdEx(ifWrGrf_IdEx),
		.grfRa1_IdEx(grfRa1_IdEx),
		.grfRa2_IdEx(grfRa2_IdEx),
		.grfWa_IdEx(grfWa_IdEx),
		.grfWd_IdEx(grfWd_IdEx),
		.tUseRs_IdEx(tUseRs_IdEx),
		.tUseRt_IdEx(tUseRt_IdEx),
		.tNew_IdEx(tNew_IdEx),

		.reset_ExMem(reset_Ex),
		.pc_ExMem(pc_Ex),
		.instr_ExMem(instr_Ex),
		.aluAns_ExMem(aluAns_Ex),
		//.rdHi_ExMem(rdHi_ExMem),
		//.rdLo_ExMem(rdLo_ExMem),
		.grfRd2_ExMem(grfRd2_Ex),
		//for Hz
		.ifReGrf1_ExMem(ifReGrf1_Ex),
		.ifReGrf2_ExMem(ifReGrf2_Ex),
		.ifWrGrf_ExMem(ifWrGrf_Ex),
		.grfRa1_ExMem(grfRa1_Ex),
		.grfRa2_ExMem(grfRa2_Ex),
		.grfWa_ExMem(grfWa_Ex),
		.grfWd_ExMem(grfWd_Ex),
		.tUseRs_ExMem(tUseRs_Ex),
		.tUseRt_ExMem(tUseRt_Ex),
		.tNew_ExMem(tNew_Ex),
		.ifBusy_Ss(ifBusy_Ex),
		.ifStart_Ss(ifStart_Ex)
	);
	
	ExMem exMem_Main(
		.clk(clk),
		.reset_Ex(reset_Ex),
		.pc_Ex(pc_Ex),
		.instr_Ex(instr_Ex),
		.aluAns_Ex(aluAns_Ex),
		.grfRd2_Ex(grfRd2_Ex),
		//for Hz
		.ifReGrf1_Ex(ifReGrf1_Ex),
		.ifReGrf2_Ex(ifReGrf2_Ex),
		.ifWrGrf_Ex(ifWrGrf_Ex),
		.grfRa1_Ex(grfRa1_Ex),
		.grfRa2_Ex(grfRa2_Ex),
		.grfWa_Ex(grfWa_Ex),
		.grfWd_Ex(grfWd_Ex),
		.tUseRs_Ex(tUseRs_Ex),
		.tUseRt_Ex(tUseRt_Ex),
		.tNew_Ex(tNew_Ex),
		
		.reset_Mem(reset_ExMem),
		.pc_Mem(pc_ExMem),
		.instr_Mem(instr_ExMem),
		.aluAns_Mem(aluAns_ExMem),
		.grfRd2_Mem(grfRd2_ExMem),
		//for Hz
		.ifReGrf1_Mem(ifReGrf1_ExMem),
		.ifReGrf2_Mem(ifReGrf2_ExMem),
		.ifWrGrf_Mem(ifWrGrf_ExMem),
		.grfRa1_Mem(grfRa1_ExMem),
		.grfRa2_Mem(grfRa2_ExMem),
		.grfWa_Mem(grfWa_ExMem),
		.grfWd_Mem(grfWd_ExMem),
		.tUseRs_Mem(tUseRs_ExMem),
		.tUseRt_Mem(tUseRt_ExMem),
		.tNew_Mem(tNew_ExMem)
	);
	
	Mem mem_Main(
		.clk(clk),
		.reset_ExMem(reset_ExMem),
		.pc_ExMem(pc_ExMem),
		.instr_ExMem(instr_ExMem),
		.aluAns_ExMem(aluAns_ExMem),
		.grfRd2_ExMem(grfRd2_ExMem),
		//from Fs
		.dmWd_Fs(dmWd_Fs),
		//for Hz
		.ifReGrf1_ExMem(ifReGrf1_ExMem),
		.ifReGrf2_ExMem(ifReGrf2_ExMem),
		.ifWrGrf_ExMem(ifWrGrf_ExMem),
		.grfRa1_ExMem(grfRa1_ExMem),
		.grfRa2_ExMem(grfRa2_ExMem),
		.grfWa_ExMem(grfWa_ExMem),
		.grfWd_ExMem(grfWd_ExMem),
		.tUseRs_ExMem(tUseRs_ExMem),
		.tUseRt_ExMem(tUseRt_ExMem),
		.tNew_ExMem(tNew_ExMem),
			
		.reset_MemWb(reset_Mem),
		.pc_MemWb(pc_Mem),
		.instr_MemWb(instr_Mem),
		.dmRd_MemWb(dmRd_Mem),
		.aluAns_MemWb(aluAns_Mem),
		//for Hz
		.ifReGrf1_MemWb(ifReGrf1_Mem),
		.ifReGrf2_MemWb(ifReGrf2_Mem),
		.ifWrGrf_MemWb(ifWrGrf_Mem),
		.grfRa1_MemWb(grfRa1_Mem),
		.grfRa2_MemWb(grfRa2_Mem),
		.grfWa_MemWb(grfWa_Mem),
		.grfWd_MemWb(grfWd_Mem),
		.tUseRs_MemWb(tUseRs_Mem),
		.tUseRt_MemWb(tUseRt_Mem),
		.tNew_MemWb(tNew_Mem)
	);
	
	MemWb memWb_Main(
		.clk(clk),
		.reset_Mem(reset_Mem),
		.pc_Mem(pc_Mem),
		.instr_Mem(instr_Mem),
		.dmRd_Mem(dmRd_Mem),
		.aluAns_Mem(aluAns_Mem),
		.grfWa_Mem(grfWa_Mem),
		//for Hz
		.ifReGrf1_Mem(ifReGrf1_Mem),
		.ifReGrf2_Mem(ifReGrf2_Mem),
		.ifWrGrf_Mem(ifWrGrf_Mem),
		.grfRa1_Mem(grfRa1_Mem),
		.grfRa2_Mem(grfRa2_Mem),
		//input [4:0]grfWa_Mem,
		.grfWd_Mem(grfWd_Mem),
		.tUseRs_Mem(tUseRs_Mem),
		.tUseRt_Mem(tUseRt_Mem),
		.tNew_Mem(tNew_Mem),
			
		.pc_Wb(pc_MemWb),
		.instr_Wb(instr_MemWb),
		//output reg [31:0]dmRd_Wb,
		//output reg [31:0]aluAns_Wb,
		.grfWa_Wb(grfWa_MemWb),	
		//for Hz
		//output reg ifReGrf1_Wb,
		//output reg ifReGrf2_Wb,
		//output reg ifWrGrf_Wb,
		//output reg [4:0]grfRa1_Wb,
		//output reg [4:0]grfRa2_Wb,
		//output reg [4:0]grfWa_Wb,
		.grfWd_Wb(grfWd_MemWb)
		//output reg [4:0]tUseRs_Wb,
		//output reg [4:0]tUseRt_Wb,
		//output reg [4:0]tNew_Wb
	);
	
	Wb wb_Main(
		.pc_MemWb(pc_MemWb),
		.instr_MemWb(instr_MemWb),
		.grfWa_MemWb(grfWa_MemWb),
		.grfWd_MemWb(grfWd_MemWb),
		
		.pc_Id(pc_Wb),
		.grfWd_Id(grfWd_Wb),
		.grfWa_Id(grfWa_Wb),
		.ifWrGrf_Id(ifWrGrf_Wb)
	);
	
	ForwardSel fs_Main(
		//for IdCmp
		.grfRa1_IfId(grfRa1_IfId),
		.grfRa2_IfId(grfRa2_IfId),
		.grfWa_IdEx(grfWa_IdEx),
		.grfWa_ExMem(grfWa_ExMem),
		.grfWa_MemWb(grfWa_MemWb),
		.grfWd_IdEx(grfWd_IdEx),
		.grfWd_ExMem(grfWd_ExMem),
		.grfWd_MemWb(grfWd_MemWb),
		.grfDirRd1_Id(grfDirRd1_Id),
		.grfDirRd2_Id(grfDirRd2_Id),		
		//for calA, calB
		.grfRa1_IdEx(grfRa1_IdEx),
		.grfRa2_IdEx(grfRa2_IdEx),
		.grfRd1_IdEx(grfRd1_IdEx),
		.grfRd2_IdEx(grfRd2_IdEx),
		//for dmWd
		.grfRa2_ExMem(grfRa2_ExMem),
		.grfRd2_ExMem(grfRd2_ExMem),
		
		.grfCmp1_Id(grfCmp1_Fs),
		.grfCmp2_Id(grfCmp2_Fs),
		.calA_Ex(calA_Fs),
		.calB_Ex(calB_Fs),
		.dmWd_Mem(dmWd_Fs)
	);
	
	StallSel ss_Main(
		//for judge1, judge2
		.ifReGrf1_Id(ifReGrf1_Id),
		.ifReGrf2_Id(ifReGrf2_Id),
		.ifWrGrf_IdEx(ifWrGrf_IdEx),
		.ifWrGrf_ExMem(ifWrGrf_ExMem),
		.grfRa1_Id(grfRa1_Id),
		.grfRa2_Id(grfRa2_Id),
		.grfWa_IdEx(grfWa_IdEx),
		.grfWa_ExMem(grfWa_ExMem),
		.tUseRs_Id(tUseRs_Id),
		.tUseRt_Id(tUseRt_Id),
		.tNew_IdEx(tNew_IdEx),
		.tNew_ExMem(tNew_ExMem),
		//for judge3
		.instr_Id(instr_Id),
		.ifBusy_Ex(ifBusy_Ex),
		.ifStart_Ex(ifStart_Ex),
	
		.ifStall(ifStall)
	);

endmodule
