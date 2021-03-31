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
	input [31:0]pc_Id,
	
	output reset_IfId,
	output [31:0]pc_IfId,
	output [31:0]instr_IfId
    );
	
	reg [31:0] iM [4095:0];
	reg [31:0]pcReg;
	
	assign reset_IfId = reset;
	assign pc_IfId = pcReg;
	assign instr_IfId = iM[pcReg[31:2] - 3072]; // (pc / 4) - (32'h00003000 / 4)
	
	initial begin
		$readmemh("code.txt", iM);
		pcReg <= 32'h00003000;
		//pcBefore <= 32'h00003000;
	end
	
	always@(posedge clk)begin
		if(reset == 1)begin
			pcReg <= 32'h00003000;
			//pcBefore <= 32'h00003000;
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
