`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
	pc = 
*/
//////////////////////////////////////////////////////////////////////////////////
module If(
	input clk,
	input reset,
	input stall,
	input [31:0]pc_Id,
	input ifPcBranch_Id,
			
	output [31:0]pc_IfToId,
	output [31:0]instr_IfToId,
	output reset_IfToId
    );


	reg [31:0] iM [1023:0];
	reg [31:0] pcReg;
	//reg [31:0] pcBefore;
	
	assign reset_IfToId = reset;
	assign pc_IfToId = pcReg;
	assign instr_IfToId = iM[pcReg[11:2]];
	
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
		else if(stall == 0)begin
			if(ifPcBranch_Id)begin
				pcReg <= pc_Id;	
				//pcBefore <= pcReg;
			end
			else begin
				pcReg <= pcReg + 4;
				//pcBefore <= pcReg;
			end
		end
		else begin
			pcReg <= pcReg;
		end
	end


endmodule
