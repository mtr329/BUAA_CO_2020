`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:46:17 11/16/2020 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
	input [5:0]op,
	input [5:0]low6,
	input [31:0]instr,
	
	output [4:0]aluCtrl,
	output ifWrGrf,
	output ifWrRt,
	output ifImmExt,
	output ifReDm,
	output ifWrDm,
	output ifBeq,
	output ifJal,
	output ifJr,
	output ifJ,
		output ifReGrf1,
		output ifReGrf2,
		output [4:0]grfRa1,
		output [4:0]grfRa2,
		output [4:0]grfWa,
		output [4:0]tUseRs,
		output [4:0]tUseRt,
		output [4:0]tNew,
	output ifAddu,
	output ifSubu,
	output ifOri,
	output ifLui,
	output ifLw,
	output ifSw
    );

	wire addu, subu, ori, lw, sw, beq, lui, jal, jr, j;
	
	assign addu = ((op == 6'b000000) && (low6 == 6'b100001));
	assign subu = ((op == 6'b000000) && (low6 == 6'b100011));
	assign ori = (op == 6'b001101);
	assign lui = (op == 6'b001111);
	assign lw = (op == 6'b100011);
	assign sw = (op == 6'b101011);
	assign beq = (op == 6'b000100);
	assign jal = (op == 6'b000011);
	assign jr = ((op == 6'b000000) && (low6 == 6'b001000));
	assign j = (op == 6'b000010);
	///////////
	assign aluCtrl = (addu)? 1:
						  (subu)? 2:
						  (ori)? 6:
						  (lui)? 7:
						  (sw || lw)? 8:
						  0;
	assign ifWrGrf = addu || subu || ori || lui || lw || jal;
	assign ifWrRt = ori || lui || lw;
	assign ifImmExt = ori || lui || lw || sw;
	assign ifReDm = lw;
	assign ifWrDm = sw;
	assign ifBeq = beq;
	assign ifJal = jal;
	assign ifJr = jr;
	assign ifJ = j;
	///////////
	assign ifReGrf1 = (addu || subu || ori || lw || sw || beq || jr);
	assign ifReGrf2 = (addu || subu || sw || beq);
	assign ifWrGrf = (addu || subu || ori || lui || lw || jal);
	assign grfRa1 = instr[25:21];//rs
	assign grfRa2 = instr[20:16];//rt
	assign grfWa = (addu || subu)? instr[15:11]:
						(ori || lui || lw)? instr[20:16]:
						(jal)? 31:
						0;
	assign tUseRs = (addu || subu || ori || sw || lw)? 1:
						 0;
	assign tUseRt = (addu || subu)? 1:
						 (sw)? 2:
						 0;
	assign tNew = (addu || subu || ori || lui)? 1:
					  (lw)? 2:
					  0;
	
	assign ifAddu = addu;
	assign ifSubu = subu;
	assign ifOri = ori;
	assign ifLui = lui;
	assign ifLw = lw;
	assign ifSw = sw;
endmodule
