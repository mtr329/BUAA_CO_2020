`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:30:01 11/19/2020 
// Design Name: 
// Module Name:    GrfWdSel 
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
/*
assign grfWD = (ifJal)? pcAdd4:
						(ifReDm)? dmOut:
						aluOut;
*/
//////////////////////////////////////////////////////////////////////////////////
module GrfWdSel(
	input ifJal,
	input ifReDm,
	input [31:0]pcAdd4,
	input [31:0]dmOut,
	input [31:0]aluOut,
	output [31:0]out
    );
	 
	assign out = (ifJal)? pcAdd4:
					 (ifReDm)? dmOut:
					 aluOut;

endmodule
