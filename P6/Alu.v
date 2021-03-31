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
	
	/*1.�޷��żӣ�	2.���żӣ�		3.�޷��ż���		4.���ż���	5.�޷���С����1��
	  6.С����1��	7.�߼����ƣ�		8.�߼��ɱ����ƣ�	9.�߼����ƣ�	10.�߼��ɱ�����
	  11.�������ƣ�	12.�����ɱ����ƣ�13.�룬			14.��		15.���
	  16.��ǣ�		17.���ص���λ*/
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
