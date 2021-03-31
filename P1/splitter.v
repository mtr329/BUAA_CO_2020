`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:25:06 10/24/2020 
// Design Name: 
// Module Name:    splitter 
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
module splitter(
	input [31:0]A,
	output [7:0]O1,//31-24
	output [7:0]O2,//23-16
	output [7:0]O3,//15-8
	output [7:0]O4//7-0
    );
	 assign O1 = A[31:24];
	 assign O2 = A[23:16];
	 assign O3 = A[15:8];
	 assign O4 = A[7:0];


endmodule
