`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:40:41 12/21/2020 
// Design Name: 
// Module Name:    Bridge 
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
module Bridge(
	input [31:0]addr_Cpu,
	input [31:0]dIn_Cpu,
	input [31:0]dIn_Dev0,
	input [31:0]dIn_Dev1,
	input ifWr_Cpu,
	
	output ifWrDev0,
	output ifWrDev1,
	output [31:0]addr_Dev,
	output [31:0]dOut_Dev,
	output [31:0]dOut_Cpu
    );
	
	wire hit0;
	wire hit1;
	
	assign hit0			=	(addr_Cpu>=32'h0000_7f00 && addr_Cpu<=32'h0000_7f0b);
	assign hit1			=	(addr_Cpu>=32'h0000_7f10 && addr_Cpu<=32'h0000_7f1b);	
	assign addr_Dev	=	addr_Cpu;
	assign dOut_Dev	=	dIn_Cpu;
	assign ifWrDev0	=	(hit0 & ifWr_Cpu);
	assign ifWrDev1	=	(hit1 & ifWr_Cpu);
	
	assign dOut_Cpu	=	(hit0)?
								(dIn_Dev0):
								(hit1)?
								(dIn_Dev1):
								0;
endmodule
