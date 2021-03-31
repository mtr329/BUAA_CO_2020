`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:10:14 12/21/2020 
// Design Name: 
// Module Name:    Cp0 
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
/*
IM[7:2]：6位中断屏蔽位，分别对应6个外部中断
	1-允许中断，0-禁止中断
IE：全局中断使能
	1-允许中断；0-禁止中断
EXL：异常级
	1-进入异常，不允许再中断；0-允许中断
	重入需要OS的配合，特别是堆栈
*/
/*
IP[7:2]：6位待决的中断位，分别对应6个外部中断
	记录当前哪些硬件中断正在有效
	1-有中断；0-无中断
ExcCode[6:2]：异常编码，记录当前发生的是什么异常
	共计32种
	本课程要求表中3种
BD：受害指令是否在延迟槽
*/
//////////////////////////////////////////////////////////////////////////////////

module Cp0(
	input clk,
	input reset,
	input wEn,
	input exlSet,
	input exlClr,
	input ifBd,
	input [5:0]hwInt,
	input [4:0]excCode,
	input [4:0]rA,
	input [4:0]wA,
	input [31:0]dIn,
	input [31:0]pc,
	
	output [31:0]epc,
	output [31:0]dOut,
	output ifExcOrInt
    );
	
	reg [5:0]imReg;
	reg ieReg;
	reg exlReg;
	reg [5:0]ipReg;
	reg [4:0]excCodeReg;
	reg bdReg;
	reg [31:0]epcReg;
	reg [31:0]idReg;
	
	wire [31:0]reg12;
	wire [31:0]reg13;
	wire [31:0]reg14;
	wire [31:0]reg15;
	
	assign reg12	=	{16'b0, imReg, 8'b0, exlReg, ieReg};
	assign reg13	=	{bdReg, 15'b0, ipReg, 3'b0, excCodeReg, 2'b0};
	assign reg14	=	epcReg;
	assign reg15	=	idReg;
	
	assign ifExcOrInt	=	(!exlReg) & ( ((ieReg) & (|(imReg & hwInt))) || exlSet);
	assign epc			=	epcReg;
	assign dOut			=	(rA == 12)?
								reg12:
								(rA == 13)?
								reg13:
								(rA == 14)?
								reg14:
								(rA == 15)?
								reg15:
								0;

	initial begin
		imReg			<=	6'b111111;
		ieReg			<=	1;
		exlReg		<=	0;
		ipReg			<=	0;
		excCodeReg	<=	0;
		bdReg			<=	0;
		epcReg		<=	0;
		idReg			<=	32'h19374191;
	end
	
	always@(posedge clk)begin
		
		if(reset)begin
			imReg			<=	6'b111111;
			ieReg			<=	1;
			exlReg		<=	0;
			excCodeReg	<=	0;
			bdReg			<=	0;
			epcReg		<=	0;
			idReg			<=	32'h19374191;
			ipReg			<=	0;
		end
		else begin
			ipReg	<=	hwInt;
			if(exlClr)begin
				exlReg	<=	0;
			end
			else if(ifExcOrInt)begin
					exlReg		<=	1;
					
					excCodeReg	<=	((ieReg) & (|(imReg & hwInt)))?
										0:
										excCode;
										
					bdReg			<=	ifBd;
					
					epcReg		<=	(ifBd)?
										({pc[31:2], 2'b0} - 4):
										{pc[31:2], 2'b0};
			end
			else if(wEn)begin
				case(wA)
					12:	{imReg, exlReg, ieReg}	<=	{dIn[15:10], dIn[1], dIn[0]};
					14:	epcReg	<=	{dIn[31:2], 2'b0};
				endcase
			end
		end	
	end	

endmodule
