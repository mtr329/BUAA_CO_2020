`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:26:11 11/19/2020 
// Design Name: 
// Module Name:    IfuIn 
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
/*assign ifuIn = (ifBeq && ifEqual)? (pcAdd4 + (immExt << 2)):
						(ifJal)? ({pc[31:28], jalTo, 2'b00}):
						(ifJr)? (grfRD1):
						pcAdd4;*/
//////////////////////////////////////////////////////////////////////////////////
module IfuInSel(
	input ifBeq,
	input ifEqual,
	input ifJal,
	input ifJr,
	input [31:0]pcAdd4,
	input [31:0]immExt,
	input [25:0]jalTo,
	input [31:0]pc,
	input [31:0]grfRD1,
	output [31:0]out
    );
	assign out = (ifBeq && ifEqual)? (pcAdd4 + ( ((immExt[15] == 0)? (immExt) : (immExt + 32'hffff0000)) << 2 )):
					 (ifJal)? ({pc[31:28], jalTo, 2'b00}):
					 (ifJr)? (grfRD1):
					 pcAdd4;

endmodule
