`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:46:02 11/16/2020 
// Design Name: 
// Module Name:    InstrDecd 
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
module InstrDecd(
	input [31:0]instr,
	output [5:0]op,
	output [4:0]rs,
	output [4:0]rt,
	output [4:0]rd,
	output [4:0]low5,
	output [5:0]low6,
	output [15:0]imm,
	output [25:0]jalTo
    );
	
	assign op = instr[31:26];
	assign rs = instr[25:21];
	assign rt = instr[20:16];
	assign rd = instr[15:11];
	assign low5 = instr[10:6];
	assign low6 = instr[5:0];
	assign imm = instr[15:0];
	assign jalTo = instr[25:0];

endmodule
