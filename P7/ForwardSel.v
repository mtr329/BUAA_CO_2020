`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:36:38 12/06/2020 
// Design Name: 
// Module Name:    ForwardSel 
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
module ForwardSel(
	//for IdCmp
	input [4:0]grfRa1_IfId,
	input [4:0]grfRa2_IfId,
	input [4:0]grfWa_IdEx,
	input [4:0]grfWa_ExMem,
	input [4:0]grfWa_MemWb,
	input [31:0]grfWd_IdEx,
	input [31:0]grfWd_ExMem,
	input [31:0]grfWd_MemWb,
	input [31:0]grfDirRd1_Id,
	input [31:0]grfDirRd2_Id,
	output [31:0]grfCmp1_Id,
	output [31:0]grfCmp2_Id,
	//for calA, calB
	input [4:0]grfRa1_IdEx,
	input [4:0]grfRa2_IdEx,
	input [31:0]grfRd1_IdEx,
	input [31:0]grfRd2_IdEx,
	output [31:0]calA_Ex,
	output [31:0]calB_Ex,
	//for dmWd
	input [4:0]grfRa2_ExMem,
	input [31:0]grfRd2_ExMem,
	output [31:0]dmWd_Mem
    );
	 
	 //for IdCmp
	assign grfCmp1_Id = ((grfRa1_IfId == grfWa_IdEx) & (grfWa_IdEx != 0))?
							  (grfWd_IdEx):
							  ((grfRa1_IfId == grfWa_ExMem) & (grfWa_ExMem != 0))?
							  (grfWd_ExMem):
							  ((grfRa1_IfId == grfWa_MemWb) & (grfWa_MemWb != 0))?
							  (grfWd_MemWb):
							  grfDirRd1_Id;
						  
	assign grfCmp2_Id = ((grfRa2_IfId == grfWa_IdEx) & (grfWa_IdEx != 0))?
							  (grfWd_IdEx):
							  ((grfRa2_IfId == grfWa_ExMem) & (grfWa_ExMem != 0))?
							  (grfWd_ExMem):
							  ((grfRa2_IfId == grfWa_MemWb) & (grfWa_MemWb != 0))?
							  (grfWd_MemWb):
							  grfDirRd2_Id;
	///////////					  
	
	////for calA, calB
	assign calA_Ex = ((grfRa1_IdEx == grfWa_ExMem) & (grfWa_ExMem != 0))?
						  (grfWd_ExMem) :
						  ((grfRa1_IdEx == grfWa_MemWb) & (grfWa_MemWb != 0))?
						  (grfWd_MemWb) :
						  (grfRd1_IdEx);
						  
	assign calB_Ex = ((grfRa2_IdEx == grfWa_ExMem) & (grfWa_ExMem != 0))?
						  (grfWd_ExMem) :
						  ((grfRa2_IdEx == grfWa_MemWb) & (grfWa_MemWb != 0))?
						  (grfWd_MemWb) :
						  (grfRd2_IdEx);
	//////////////////

	//for dmWd
	assign dmWd_Mem = ((grfRa2_ExMem == grfWa_MemWb) & (grfWa_MemWb != 0))?
							(grfWd_MemWb):
							(grfRd2_ExMem);
	//////////
	
endmodule
