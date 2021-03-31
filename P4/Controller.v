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
	output [4:0]aluCtrl,
	output ifWrGrf,
	output ifWrRt,
	output ifImmExt,
	output ifReDm,
	output ifWrDm,
	output ifBeq,
	output ifJal,
	output ifJr
    );

	wire addu, subu, ori, lw, sw, beq, lui, jal, jr;

	assign aluCtrl = (addu)? 1:
						  (subu)? 2:
						  (ori)? 6:
						  (lui)? 7:
						  (lw | sw)? 8:
						  0;
	assign addu = ((op == 6'b000000) && (low6 == 6'b100001));
	assign subu = ((op == 6'b000000) && (low6 == 6'b100011));
	assign ori = (op == 6'b001101);
	assign lui = (op == 6'b001111);
	assign lw = (op == 6'b100011);
	assign sw = (op == 6'b101011);
	assign beq = (op == 6'b000100);
	assign jal = (op == 6'b000011);
	assign jr = ((op == 6'b000000) && (low6 == 6'b001000));
	
	assign ifWrGrf = addu | subu | ori | lui | lw | jal;
	assign ifWrRt = ori | lui | lw;
	assign ifImmExt = ori | lui | lw | sw;
	assign ifReDm = lw;
	assign ifWrDm = sw;
	assign ifBeq = beq;
	assign ifJal = jal;
	assign ifJr = jr;
	
endmodule
