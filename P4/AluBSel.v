`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:11:32 11/19/2020 
// Design Name: 
// Module Name:    AluBSel 
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
module AluBSel(
	input ifImmExt,
	input [31:0]immExt,
	input [31:0]grfRD2,
	output [31:0]out
    );
	 
assign out = (ifImmExt)? immExt:
				 grfRD2;

endmodule