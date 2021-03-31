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
	input [4:0]loadCtrl, // 1.lb, 2.lbu, 3.lh, 4.lhu, 5.lw
	input [4:0]saveCtrl, // 1.sb, 2.sh,  3.sw
	
	output [31:0]dOut
    );
	
	reg [31:0] dmRegs[4095:0];
	wire [31:0]memWord; 
	wire [15:0]memHalf;
	wire [7:0]memByte;
	//for dOut
	assign memWord = dmRegs[addr[13:2]];
	
	assign memHalf = (addr[1] == 0)?
						  (memWord[15:0]):
						  (memWord[31:16]);
						  
	assign memByte = (addr[1:0] == 0)?
						  (memWord[7:0]):
						  (addr[1:0] == 1)?
						  (memWord[15:8]):
						  (addr[1:0] == 2)?
						  (memWord[23:16]):
						  (addr[1:0] == 3)?
						  (memWord[31:24]):
						  0;
						  
	assign dOut = (loadCtrl == 1)?
					  ({{24{memByte[7]}}, memByte[7:0]}):
					  (loadCtrl == 2)?
					  ({24'b0, memByte[7:0]}):
					  (loadCtrl == 3)?
					  ({{16{memHalf[15]}}, memHalf[15:0]}):
					  (loadCtrl == 4)?
					  ({16'b0, memHalf[15:0]}):
					  (loadCtrl == 5)?
					  (memWord[31:0]):
					  0;
	//////////
	
	integer i;
	initial begin
		for(i = 0; i < 4096; i = i + 1)
			dmRegs[i] <= 0;
	end
	
	always@(posedge clk)begin
		if(reset == 1)begin
			for(i = 0; i < 4096; i = i + 1)
				dmRegs[i] <= 0;
		end
		else begin
			if(wEn == 1)begin
				//$display("%d@%h: *%h <= %h", $time, pc, addr, dIn);
				//sb
				if(saveCtrl == 1)begin
					if(addr[1:0] == 0)begin
						dmRegs[addr[13:2]][7:0] <= dIn[7:0];
						$display("%d@%h: *%h <= %h", $time, pc, {addr[31:2], 2'b0}, {dmRegs[addr[13:2]][31:8], dIn[7:0]});
					end
					else if(addr[1:0] == 1)begin
						dmRegs[addr[13:2]][15:8] <= dIn[7:0];
						$display("%d@%h: *%h <= %h", $time, pc, {addr[31:2], 2'b0}, {dmRegs[addr[13:2]][31:16], dIn[7:0], dmRegs[addr[13:2]][7:0]});
					end
					else if(addr[1:0] == 2)begin
						dmRegs[addr[13:2]][23:16] <= dIn[7:0];
						$display("%d@%h: *%h <= %h", $time, pc, {addr[31:2], 2'b0}, {dmRegs[addr[13:2]][31:24], dIn[7:0], dmRegs[addr[13:2]][15:0]});
					end
					else begin
						dmRegs[addr[13:2]][31:24] <= dIn[7:0];
						$display("%d@%h: *%h <= %h", $time, pc, {addr[31:2], 2'b0}, {dIn[7:0], dmRegs[addr[13:2]][23:0]});
					end
				end
				//sh
				else if(saveCtrl == 2)begin
					if(addr[1] == 0)begin
						dmRegs[addr[13:2]][15:0] <= dIn[15:0];
						$display("%d@%h: *%h <= %h", $time, pc, {addr[31:2], 2'b0}, {dmRegs[addr[13:2]][31:16], dIn[15:0]});
					end
					else begin
						dmRegs[addr[13:2]][31:16] <= dIn[15:0];
						$display("%d@%h: *%h <= %h", $time, pc, {addr[31:2], 2'b0}, {dIn[15:0], dmRegs[addr[13:2]][15:0]});
					end
				end
				//sw
				else if(saveCtrl == 3)begin
					dmRegs[addr[13:2]] <= dIn;
					$display("%d@%h: *%h <= %h", $time, pc, {addr[31:2], 2'b0}, dIn);
				end
			end
		end
	end

endmodule
