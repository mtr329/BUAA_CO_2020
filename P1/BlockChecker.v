`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:50:04 10/28/2020 
// Design Name: 
// Module Name:    BlockChecker 
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
module BlockChecker(
	input clk,
	input reset,
	input [7:0]in,
	output reg result
    );
	reg [8:0]num = 0;
	reg [3:0]status = 1;
	reg before;
	
	always@(posedge clk or posedge reset)begin
		if(reset == 1)begin
			status <= 1;
			num <= 0;
			result <= 1;
		end
		else begin
			case(status)
				0:	begin	//xx
						if(in == " ") 
							status <= 1;
					end
				1:	begin	//[]
						if(in == "b" || in == "B") 
							status <= 2;
						else if(in == "e" || in == "E")
							status <= 3;
						else if(in != " ")
							status <= 0;
					end
				2:	begin	//b
						if(in == "e" || in == "E")
							status <= 4;
						else if(in == " ")
							status <= 1;
						else
							status <= 0;
					end
				3:	begin	//e
						if(in == "n" || in == "N")
							status <= 5;
						else if(in == " ")
							status <= 1;
						else
							status <= 0;
					end
				4: begin	//be
						if(in == "g" || in == "G")
							status <= 6;
						else if(in == " ")
							status <= 1;
						else
							status <= 0;
					end
				5:	begin	//en
						before <= result;
						if(in == "d" || in == "D")begin
							status <= 7;
							if(num == 1)
								result <= 1;
								//before <= 1;
							else 
								result <= 0;
						end
						else if(in == " ")
							status <= 1;
						else
							status <= 0;
					end
				6:	begin	//beg
						if(in == "i" || in == "I")
							status <= 8;
						else if(in == " ")
							status <= 1;
						else
							status <= 0;
					end
				7:	begin	//end
						if(in == " ")begin
							if(num <= 0)begin
								status <= 15;
								//result <= 0;
							end
							else begin
								num <= num - 1;
								status <= 1;
							end
						end
						else begin
							status <= 0;
							result <= before;
						end
					end
				8: begin	//begi
						before <= result;
						if(in == "n" || in == "N")begin
							result <= 0;
							status <= 10;
						end
						else if(in == " ")
							status <= 1;
						else
							status <= 0;
					end
				10:begin	//begin
						if(in == " ")begin
							status <= 1;
							num <= num + 1;
						end
						else begin
							status <= 0;
							result <= before;
						end
					end	
				default: ;
			endcase
		end
	end

endmodule
