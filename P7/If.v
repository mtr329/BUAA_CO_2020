`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:58:05 12/01/2020 
// Design Name: 
// Module Name:    If 
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
module If(
	input clk,
	input reset,
	input ifStall,
	input ifBranchOrJump_Id,
	
	input ifEret_Id,
	input ifEret_Mem,
	//input ifMtc0_Wb,
	//input grfWa_Mem,
	input [31:0]epc_Mem,
	
	//input [31:0]dmWd_Fs,
	input [31:0]pc_Id,
	input ifExc,
	
	output reset_IfId,
	output [31:0]pc_IfId,
	output [4:0]excCode_IfId,
	output [31:0]instr_IfId,
	output ifBd_IfId
    );
	
	reg [31:0] iM [4095:0];
	reg [31:0]pcReg;
	wire ifBranch;
	wire ifJump;
	
	Controller controller_If(
		.instr(instr_IfId),
		
		.ifBranch(ifBranch),
		.ifJump(ifJump)
	);
	
	assign ifBd_IfId		=	(ifBranch | ifJump);
	
	assign reset_IfId 	=	reset;
	assign pc_IfId 		=	pcReg;
	assign instr_IfId 	=	iM[pcReg[31:2] - 3072]; // (pc / 4) - (32'h00003000 / 4)
	assign excCode_IfId	=	((pcReg[1:0] != 0) | (pcReg < 32'h00003000) | (pcReg > 32'h00004ffc))?
									4:
									0;
	
	initial begin
		$readmemh("code.txt", iM);
		$readmemh("code_handler.txt", iM, 1120, 2047);
		pcReg <= 32'h00003000;
		//pcBefore <= 32'h00003000;
	end
	
	always@(posedge clk)begin
		if(reset == 1)begin
			pcReg <= 32'h00003000;
			//pcBefore <= 32'h00003000;
		end
		else if(ifExc)begin
			pcReg	<=	32'h00004180;
		end
		else if(ifEret_Mem)begin
			pcReg	<=	epc_Mem;
		end
		else if(ifStall == 0)begin
			if(ifBranchOrJump_Id)begin
				pcReg <= pc_Id;	
			end
			else begin
				pcReg <= pcReg + 4;
			end
		end
	end
	
endmodule
