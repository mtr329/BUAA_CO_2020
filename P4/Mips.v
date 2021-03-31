`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:45:23 11/16/2020 
// Design Name: 
// Module Name:    Mips 
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
module Mips(
	input clk,
	input reset
    );
	//addu, subu, ori, lui, lw, sw, beq, jal, jr;
	wire [31:0]pcAdd4;
	wire [31:0]pc;
	wire [31:0]instr;
	
	wire [5:0]op;
	wire [4:0]rs;
	wire [4:0]rt;
	wire [4:0]rd;
	wire [4:0]low5;
	wire [5:0]low6;
	wire [15:0]imm;
	wire [25:0]jalTo;
	
	wire [4:0]aluCtrl;
	wire ifWrGrf;
	wire ifWrRt;
	wire ifImmExt;
	wire ifReDm;
	wire ifWrDm;
	wire ifBeq;
	wire ifJal;
	wire ifJr;
	
	wire [31:0]grfRD1;
	wire [31:0]grfRD2;
	
	wire [31:0]aluOut;
	wire ifBigger;
	wire ifEqual;
	wire ifSmaller;
	
	wire [31:0]dmOut;
	
	wire [31:0]immExt;
		
	wire [31:0]aluBSelOut;
	wire [4:0]grfWaSelOut;
	wire [31:0]grfWdSelOut;
	wire [31:0]ifuInSelOut;
	
	AluBSel aluBSel(	
		.ifImmExt(ifImmExt),
		.immExt(immExt),
		.grfRD2(grfRD2),
		.out(aluBSelOut)
	);
	
	GrfWaSel grfWaSel(
		.ifJal(ifJal),
		.ifWrRt(ifWrRt),
		.rt(rt),
		.rd(rd),
		.out(grfWaSelOut)
	);
	
	GrfWdSel grfWdSel(
		.ifJal(ifJal),
		.ifReDm(ifReDm),
		.pcAdd4(pcAdd4),
		.dmOut(dmOut),
		.aluOut(aluOut),
		.out(grfWdSelOut)
	);
	
	IfuInSel ifuInSel(
		.ifBeq(ifBeq),
		.ifEqual(ifEqual),
		.ifJal(ifJal),
		.ifJr(ifJr),
		.pcAdd4(pcAdd4),
		.immExt(immExt),
		.jalTo(jalTo),
		.pc(pc),
		.grfRD1(grfRD1),
		.out(ifuInSelOut)
	);
	
	Ifu ifu(
		.pcIn(ifuInSelOut),
		.clk(clk),
		.reset(reset),
		.pc(pc),
		.pcAdd4(pcAdd4),
		.instr(instr)
	);
	
	InstrDecd instrdecd(
		.instr(instr),
		.op(op),
		.rs(rs),
		.rt(rt),
		.rd(rd),
		.low5(low5),
		.low6(low6),
		.imm(imm),
		.jalTo(jalTo)
	);

	
	Controller controller(
		.op(op),
		.low6(low6),
		.aluCtrl(aluCtrl),
		.ifWrGrf(ifWrGrf),
		.ifWrRt(ifWrRt),
		.ifImmExt(ifImmExt),
		.ifReDm(ifReDm),
		.ifWrDm(ifWrDm),
		.ifBeq(ifBeq),
		.ifJal(ifJal),
		.ifJr(ifJr)
	);
	
	Grf grf(
		.pc(pc),
		.wEn(ifWrGrf),
		.clk(clk),
		.reset(reset),
		.rA1(rs),
		.rA2(rt),
		.wA(grfWaSelOut),
		.wD(grfWdSelOut),
		.rD1(grfRD1),
		.rD2(grfRD2)
	);						
	
	Alu alu(
		.a(grfRD1),
		.b(aluBSelOut),
		.ctrl(aluCtrl),
		.out(aluOut),
		.bigger(ifBigger),
		.equal(ifEqual),
		.smaller(ifSmaller)
	);
	
	Dm dm(
		.pc(pc),
		.clk(clk),
		.reset(reset),
		.rEn(ifReDm),
		.wEn(ifWrDm),
		.addr(aluOut),
		.dIn(grfRD2),
		.dOut(dmOut)
	);
	
	Ext ext(
		.in(imm),
		.out(immExt)
	);
	
endmodule
