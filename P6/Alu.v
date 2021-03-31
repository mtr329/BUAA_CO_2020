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
	input [31:0]instr,
	input [31:0]a,
	input [31:0]b,
	input [4:0]ctrl,
	
	output [31:0]ans,
	output overflow
    );
	 
	wire [32:0]addTemp;
	wire [32:0]subTemp;
	
	/*1.无符号加，	2.符号加，		3.无符号减，		4.符号减，	5.无符号小于置1，
	  6.小于置1，	7.逻辑左移，		8.逻辑可变左移，	9.逻辑右移，	10.逻辑可变右移
	  11.算数右移，	12.算数可变右移，13.与，			14.或，		15.异或，
	  16.或非，		17.加载到高位*/
	assign ans = (ctrl == 1)? (a + b):
					 (ctrl == 2)? $signed($signed(a) + $signed(b)):
					 (ctrl == 3)? (a - b):
					 (ctrl == 4)? $signed($signed(a) - $signed(b)):			 
					 (ctrl == 5)? ((a < b)? 1 : 0):
					 (ctrl == 6)? (($signed(a) < $signed(b))? 1 : 0):
					 (ctrl == 7)? (b << (instr[10:6])):
					 (ctrl == 8)? (b << (a[4:0])):
					 (ctrl == 9)? (b >> (instr[10:6])):
					 (ctrl == 10)? (b >> (a[4:0])):
					 (ctrl == 11)? $signed($signed(b) >>> (instr[10:6])):
					 (ctrl == 12)? $signed($signed(b) >>> (a[4:0])):
					 (ctrl == 13)? (a & b):
					 (ctrl == 14)? (a | b):
					 (ctrl == 15)? (a ^ b):
					 (ctrl == 16)? ~(a | b):
					 (ctrl == 17)? (b << 16):
					 0;
	
	assign addTemp = {a[31], a} + {b[31], b};
	assign subTemp = {a[31], a} - {b[31], b};
	assign overflow = (addTemp[32] != addTemp[31]) | 
							(subTemp[32] != subTemp[31]);
	
endmodule
