`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:45:39 11/16/2020 
// Design Name: 
// Module Name:    Ifu 
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
module Ifu(
	input [31:0]pcIn,
	input clk,
	input reset,
	output [31:0]pc,
	output [31:0]pcAdd4,
	output [31:0]instr
    );
	
	reg [31:0] iM [1023:0];
	reg [31:0] pcReg;
	
	assign pc = pcReg;
	assign pcAdd4 = pcReg + 4;
	assign instr = iM[pcReg[11:2]];
	
	initial begin
		$readmemh("code.txt", iM);
		pcReg <= 32'h00003000;
	end
	
	always@(posedge clk)begin
		if(reset == 1)begin
			pcReg <= 32'h00003000;
		end
		else begin
			pcReg <= pcIn;
		end
	end

endmodule
