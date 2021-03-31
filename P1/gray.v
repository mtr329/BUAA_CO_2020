`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:07:49 10/24/2020 
// Design Name: 
// Module Name:    gray 
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
module gray(
	input Clk,
	input Reset,
	input En,
	output reg [2:0]Output = 0,
	output reg Overflow = 0
    );
	always @(posedge Clk)begin
		if(Reset == 1)begin
			Output <= 0;
			Overflow <= 0;
		end
		else if(En == 1)begin
			case(Output)
				0: Output <= 1;
				1: Output <= 3;
				3: Output <= 2;
				2: Output <= 6;
				6:	Output <= 7;
				7: Output <= 5;
				5: Output <= 4;
				4:	begin
						Output <= 0;
						Overflow <= 1;
					end
				default: ;
			endcase
		end	
	end

endmodule
