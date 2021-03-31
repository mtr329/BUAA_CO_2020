`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:11:04 11/22/2020 
// Design Name: 
// Module Name:    Grf 
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
module Grf(
	input [31:0]pc,
	input wEn,
	input clk,
	input reset,
	input [4:0]rA1,
	input [4:0]rA2,
	input [4:0]wA,
	input [31:0]wD,
	output [31:0]rD1,
	output [31:0]rD2
    );

	reg [31:0] grfRegs[31:0];
	
	assign rD1 = grfRegs[rA1];
	assign rD2 = grfRegs[rA2];
	
	integer i;
	initial begin
		for(i = 0; i < 32; i = i + 1)begin
			grfRegs[i] <= 0;
		end
	end

	always@(posedge clk)begin
		if(reset == 1)begin
			for(i = 0; i < 32; i = i + 1)
				grfRegs[i] <= 0;
		end
		else begin
			if(wEn == 1)begin
				if(wA != 0)begin
					$display("%d@%h: $%d <= %h", $time, pc, wA, wD);
					grfRegs[wA] <= wD;
				end
			end
		end
	end

endmodule
