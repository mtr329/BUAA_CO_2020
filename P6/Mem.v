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
	
	Controller controller_Mem(
		.instr(instr_ExMem),
		
		.loadCtrl(loadCtrl),
		.saveCtrl(saveCtrl),
		.ifLoad(ifLoad),
		.ifSave(ifSave)
	);

	Dm dm_Mem(
		.pc(pc_ExMem),
		.clk(clk),
		.reset(reset_ExMem),
		.rEn(ifLoad),
		.wEn(ifSave),
		.addr(aluAns_ExMem),
		.dIn(dmWd_Fs),
		.loadCtrl(loadCtrl), // 1.lb, 2.lbu, 3.lh, 4.lhu, 5.lw
		.saveCtrl(saveCtrl), // 1.sb, 2.sh,  3.sw
		
		.dOut(dmRd_MemWb)
	);
	
	assign pc_MemWb = pc_ExMem;
	assign instr_MemWb = instr_ExMem;
	assign reset_MemWb = reset_ExMem;
	assign aluAns_MemWb = aluAns_ExMem;
	//for Hz
	assign ifReGrf1_MemWb = ifReGrf1_ExMem;
	assign ifReGrf2_MemWb = ifReGrf2_ExMem;
	assign ifWrGrf_MemWb = ifWrGrf_ExMem;
	assign grfRa1_MemWb = grfRa1_ExMem;
	assign grfRa2_MemWb = grfRa2_ExMem;
	assign grfWa_MemWb = grfWa_ExMem;
	assign grfWd_MemWb = (ifLoad)? dmRd_MemWb:
								grfWd_ExMem;
	assign tUseRs_ExMem = tUseRs_ExMem;
	assign tUseRt_MemWb = tUseRt_ExMem;
	assign tNew_MemWb = (tNew_ExMem == 0)? 0:
							  (tNew_ExMem - 1);

endmodule
