`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:34:19 10/24/2020 
// Design Name: 
// Module Name:    string 
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
module string(
	input clk,
	input clr,
	input [7:0]in,
	output reg out = 0
    );
	reg [1:0]state = 0;
	always@(posedge clk, posedge clr)begin
		if(clr == 1)begin
			out <= 0;
			state <= 0;
		end
		else begin
			case(state)
				0:	begin
						if(in >= "0" && in <= "9")begin
							state <= 1;
							out <= 1;
						end
						else begin
							out <= 0;
							state <= 3;
						end
					end
				1:	begin
						if(in == "+" || in == "*")begin
							state <= 2;
							out <= 0;
						end
						else begin
							out <= 0;
							state <= 3;
						end
					end
				2:	begin
						if(in >= "0" && in <= "9")begin
							state <= 1;
							out <= 1;
						end
						else begin
							out <= 0;
							state <= 3;
						end
					end
				3:	begin
					end
				default: ;
			endcase
		end
	end

endmodule
