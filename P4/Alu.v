`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:46:53 11/16/2020 
// Design Name: 
// Module Name:    Alu 
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
module Alu(
	input [31:0]a,
	input [31:0]b,
	input [4:0]ctrl,
	output [31:0]out,
	output bigger,
	output equal,
	output smaller
    );
	
	assign bigger = (a > b);
	assign equal = (a == b);
	assign smaller = (a < b);
	assign out = (ctrl == 1)? (a + b):
					 (ctrl == 2)? (a - b):
					 //(ctrl == 3)? (a * b):
					 //(ctrl == 4)? (a / b):
					 (ctrl == 5)? (a & b):
					 (ctrl == 6)? (a | b):
					 (ctrl == 7)? (b << 16):
					 (ctrl == 8)? ((b[15] == 0)? (a + b): (a + b + 32'hffff0000)):
					 0;

endmodule
