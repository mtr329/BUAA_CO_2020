`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:38:20 10/24/2020 
// Design Name: 
// Module Name:    ext 
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
module ext(
	input [15:0]imm,
	input [1:0]EOp,
	output [31:0]ext
    );
	 assign ext = (EOp == 2'b00)? ((imm[15] == 0)? {16'h0, imm} : {16'hffff, imm}):
					  (EOp == 2'b01)? ({16'h0, imm}):
					  (EOp == 2'b10)? ({16'h0, imm} << 16):
					  (((imm[15] == 0)? {16'h0, imm} : {16'hffff, imm}) << 2);


endmodule
