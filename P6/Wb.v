`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:59:14 12/01/2020 
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
	input [31:0]pc_MemWb,
	input [31:0]instr_MemWb,
	input [4:0]grfWa_MemWb,
	input [31:0]grfWd_MemWb,
	
	output [31:0]pc_Id,
	output [31:0]grfWd_Id,
	output [4:0]grfWa_Id,
	output ifWrGrf_Id
    );
	
	Controller controller_Wb(
		.instr(instr_MemWb),
		
		.ifWrGrf(ifWrGrf_Id)
	);
	
	assign pc_Id = pc_MemWb;
	assign grfWa_Id = grfWa_MemWb;
	assign grfWd_Id = grfWd_MemWb;
	

endmodule
