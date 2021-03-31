`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:00:41 11/26/2020 
// Design Name: 
// Module Name:    Wb 
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
module Wb(
	input [31:0]instr_MemToWb,
	input [4:0]grfWa_MemToWb,
	input [31:0]grfWd_MemToWb,
	input [31:0]pc_MemToWb,
		
	output [31:0]grfWd_Id,
	output [4:0]grfWa_Id,
	output ifWrGrf_Id,
	output [31:0]pc_Id
    );
	
	assign pc_Id = pc_MemToWb;
	
	Controller controller_Wb(
		.op(instr_MemToWb[31:26]),
		.low6(instr_MemToWb[5:0]),
		
		.ifWrGrf(ifWrGrf_Id)
	);
	
	//for Id
	assign grfWd_Id = grfWd_MemToWb;
	assign grfWa_Id = grfWa_MemToWb;
	//

endmodule
