`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:29:37 11/19/2020 
// Design Name: 
// Module Name:    GrfWaSel 
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
assign grfWA = (ifJal)? 31:
						(ifWrRt)? rt:
						rd;
*/
//////////////////////////////////////////////////////////////////////////////////
module GrfWaSel(
	input ifJal,
	input ifWrRt,
	input [4:0]rt,
	input [4:0]rd,
	output [4:0]out
    );
	 
assign out = (ifJal)? 5'b11111:
				 (ifWrRt)? rt:
				 rd;

endmodule
