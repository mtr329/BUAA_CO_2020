`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:47:06 11/16/2020 
// Design Name: 
// Module Name:    Dm 
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
module Dm(
	input [31:0]pc,
	input clk,
	input reset,
	input rEn,
	input wEn,
	input [31:0]addr,
	input [31:0]dIn,
	output [31:0]dOut
    );
	
	reg [31:0] dmRegs[1023:0];
	
	assign dOut = dmRegs[addr[11:2]];
	
	integer i;
	initial begin
		for(i = 0; i < 1024; i = i + 1)
			dmRegs[i] <= 0;
	end
	
	always@(posedge clk)begin
		if(reset == 1)begin
			for(i = 0; i < 1024; i = i + 1)
				dmRegs[i] <= 0;
		end
		else begin
			if(wEn == 1)begin
				$display("%d@%h: *%h <= %h", $time, pc, addr, dIn);
				dmRegs[addr[11:2]] <= dIn;
			end
		end
	end

endmodule
