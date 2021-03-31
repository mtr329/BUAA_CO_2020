`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:38:29 12/03/2020 
// Design Name: 
// Module Name:    Hilo 
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
module Hilo(
	input clk,
	input reset, 
	input start,//only */, not include load or save
	input [4:0]ctrl,//1.ÎÞ·ûºÅ³Ë£¬2.³Ë£¬3.ÎÞ·ûºÅ³ý£¬4.³ý£¬5.¶ÁHi£¬6.¶ÁLo, 7.Ð´Hi£¬ 8.Ð´Lo
	input [31:0]A,
	input [31:0]B,
	input wrHiloEn,
	
	//output [31:0]ans,
	output reg [31:0]rdHi,
	output reg [31:0]rdLo,
	output reg busy
    );
	
	reg [31:0]regA;
	reg [31:0]regB;
	reg [4:0]timer;
	reg [4:0]regCtrl;
	wire [63:0]multAns;
	wire [63:0]multuAns;
	wire [31:0]divHi;
	wire [31:0]divLo;
	wire [31:0]divuHi;
	wire [31:0]divuLo;
	
	//assign multAns = {{32{regA[31]}}, regA} * {{32{regB[31]}}, regB};
	//assign multuAns = {32'h0, regA} * {32'h0, regB};
	assign multAns = $signed(regA) * $signed(regB);
	assign multuAns = regA * regB;
	
	initial begin
		regA <= 0;
		regB <= 0;
		timer <= 0;
		rdHi <= 0;
		rdLo <= 0;
		busy <= 0;
		regCtrl <= 0;
	end
	
	always@(posedge clk)begin
		if(reset)begin
			regA <= 0;
			regB <= 0;
			timer <= 0;
			rdHi <= 0;
			rdLo <= 0;
			busy <= 0;
			regCtrl <= 0;
		end	
		else if(ctrl == 7 && wrHiloEn)begin
			rdHi <= A;
			regCtrl <= 0;
		end
		else if(ctrl == 8 && wrHiloEn)begin
			rdLo <= A;
			regCtrl <= 0;
		end
		else if(start)begin
			busy <= 1;
			regCtrl <= ctrl;
			regA <= A;
			regB <= B;
			if((ctrl == 1) | (ctrl == 2))begin
				timer <= 4;
			end
			else if((ctrl == 3) | (ctrl == 4))begin
				timer <= 9;
			end
		end
		else begin
			//ÔËËãÖÐ
			if(timer > 0)begin
				busy <= 1;
				timer <= timer - 1;
			end
			//ËãÍêÁË
			else begin
				busy <= 0;
				regCtrl <= 0;
				if(regCtrl == 2 && wrHiloEn)begin
					rdHi <= multAns[63:32];
					rdLo <= multAns[31:0];
				end
				else if(regCtrl == 1 && wrHiloEn)begin
					rdHi <= multuAns[63:32];
					rdLo <= multuAns[31:0];
				end
				else if(regCtrl == 4 && wrHiloEn)begin
					rdHi <= $signed(regA) % $signed(regB);
					rdLo <= $signed(regA) / $signed(regB);
				end
				else if(regCtrl == 3 && wrHiloEn)begin
					rdHi <= regA % regB;
					rdLo <= regA / regB;
				end
				
			end
		end
	end
	
endmodule
