`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:17:40 12/02/2020 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
	input [31:0]instr,
	
	//ctrl
	output [4:0]aluCtrl,
	output [4:0]hiloCtrl,
	output [4:0]loadCtrl,
	output [4:0]saveCtrl,
	//output ifWrGrf,
	output ifImmZeroExt,		//for AluB & hiloB
	output ifImmSignExt,		//for AluB & hiloB
	output ifReDm,		
	output ifWrDm,
	output ifUseDmAns,	//maybe useful
	output ifUseAluAns,
	output ifUseHiloAns,
	//for grf
	output ifReGrf1,
	output ifReGrf2,
	output ifWrGrf,
	output [4:0]grfRa1,
	output [4:0]grfRa2,
	output [4:0]grfWa,
	output [4:0]tUseRs,
	output [4:0]tUseRt,
	output [4:0]tNew,			//assign once
	//for hilo	¼¸ºõ²»ÓÃ
	output ifReHi,
	output ifReLo,
	output ifWrHi,
	output ifWrLo,
	output [4:0]tUseHi,
	output [4:0]tUseLo,
	//classification
	output ifRR,
	output ifRI,
	output ifLoad,
	output ifSave,
	output ifBranch,
	output ifJump,
	output ifTrans,
	//specific
	//load
	output ifLb,
	output ifLbu,
	output ifLh,
	output ifLhu,
	output ifLw,
	//save
	output ifSb,
	output ifSh,
	output ifSw,
	//RR
	output ifAdd,
	output ifAddu,
	output ifSub,
	output ifSubu,
	output ifMult,
	output ifMultu,
	output ifDiv,
	output ifDivu,
	output ifSlt,
	output ifSltu,
	output ifSll,
	output ifSrl,
	output ifSra,
	output ifSllv,
	output ifSrlv,
	output ifSrav,
	output ifAnd,
	output ifOr,
	output ifXor,
	output ifNor,
	//RI
	output ifAddi,
	output ifAddiu,
	output ifAndi,
	output ifOri,
	output ifXori,
	output ifLui,
	output ifSlti,
	output ifSltiu,
	//branch
	output ifBeq,
	output ifBne,
	output ifBlez,
	output ifBgtz,
	output ifBltz,
	output ifBgez,
	//jump
	output ifJ,
	output ifJal,
	output ifJalr,
	output ifJr,
	//trans
	output ifMfhi,
	output ifMflo,
	output ifMthi,
	output ifMtlo
    );
	
	wire ifNop;
	wire [5:0]op;
	wire [5:0]low6;
	wire [4:0]rs;
	wire [4:0]rt;
	wire [4:0]rd;
	wire [15:0]imm;
	wire [25:0]jTo;
	assign op = instr[31:26];
	assign low6 = instr[5:0];
	assign rs = instr[25:21];
	assign rt = instr[20:16];
	assign rd = instr[15:11];
	assign imm = instr[15:0];
	assign jTo = instr[25:0];
	assign ifNop = (instr == 0);
	
	//for ctrl
	/*1.ÎÞ·ûºÅ¼Ó£¬2.·ûºÅ¼Ó£¬3.ÎÞ·ûºÅ¼õ£¬4.·ûºÅ¼õ£¬5.ÎÞ·ûºÅÐ¡ÓÚÖÃ1£¬6.Ð¡ÓÚÖÃ1£¬7.Âß¼­×óÒÆ£¬8.Âß¼­¿É±ä×óÒÆ£¬9.Âß¼­ÓÒÒÆ£¬10.Âß¼­¿É±äÓÒÒÆ
	  11.ËãÊýÓÒÒÆ£¬12.ËãÊý¿É±äÓÒÒÆ£¬13.Óë£¬14.»ò£¬15.Òì»ò£¬16.»ò·Ç£¬17.¼ÓÔØµ½¸ßÎ»*/
	assign aluCtrl = (ifNop)? 0:
						  (ifLoad || ifSave || ifAddu || ifAddiu)? 1:
						  (ifAdd || ifAddi)? 2:
						  (ifSubu)? 3:
						  (ifSub)? 4:
						  (ifSltu || ifSltiu)? 5: 
						  (ifSlt || ifSlti)? 6:
						  (ifSll)? 7:
						  (ifSllv)? 8:
						  (ifSrl)? 9:
						  (ifSrlv)? 10:
						  (ifSra)? 11:
						  (ifSrav)? 12:
						  (ifAnd || ifAndi)? 13:
						  (ifOr || ifOri)? 14:
						  (ifXor || ifXori)? 15:
						  (ifNor)? 16:
						  (ifLui)? 17:
						  0;
	//1.ÎÞ·ûºÅ³Ë£¬2.³Ë£¬3.ÎÞ·ûºÅ³ý£¬4.³ý£¬5.¶ÁHi£¬6.¶ÁLo£¬7.Ð´Hi£¬8.Ð´Lo
	assign hiloCtrl = (ifNop)? 0:
							(ifMultu)? 1:
							(ifMult)? 2:
							(ifDivu)? 3:
							(ifDiv)? 4:
							(ifMfhi)? 5:
							(ifMflo)? 6:
							(ifMthi)? 7:
							(ifMtlo)? 8:
							0;
	
	assign loadCtrl = (ifNop)? 0:
							(ifLb)? 1:
							(ifLbu)? 2:
							(ifLh)? 3:
							(ifLhu)? 4:
							(ifLw)? 5:
							0;
							
	assign saveCtrl = (ifNop)? 0:
							(ifSb)? 1:
							(ifSh)? 2:
							(ifSw)? 3:
							0;
	
	assign ifWrGrf = (ifNop)? 0:
						  (
						  ifLoad  
						  | ifRI 
						  | ifMfhi | ifMflo 
						  | ifAdd | ifAddu | ifSub | ifSubu | ifSlt | ifSltu | ifSll | ifSrl | ifSra | ifSllv | ifSrlv | ifSrav | ifAnd | ifOr | ifXor | ifNor
						  | ifJal | ifJalr
						  );
	//assign ifWrRt = (ifLoad | ifRI);
	assign ifImmZeroExt = (ifNop)? 0:
								 (ifAndi | ifOri | ifXori);	//for AluB & hiloB
	
	assign ifImmSignExt = (ifNop)? 0:
								 (ifLoad 
								 | ifSave 
								 | ifAddi | ifAddiu | ifLui | ifSlti | ifSltiu
								 );		//for AluB & hiloB, take care of lui
	
	assign ifReDm = (ifNop)? 0:
						 (ifLoad);
						 
	assign ifWrDm = (ifNop)? 0:
						 (ifSave);
						 
	//for grf
	assign ifReGrf1 = (ifNop)? 0:
							((ifLoad) | 
							(ifSave) |
							(ifAdd | ifAddu | ifSub | ifSubu | ifMult | ifMultu | ifDiv | ifDivu | ifSlt | ifSltu | ifAnd | ifOr | ifXor | ifNor) |
							(ifAddi | ifAddiu | ifAndi | ifOri | ifXori | ifSlti | ifSltiu) | 
							(ifBranch) |
							(ifJalr | ifJr) | 
							(ifMthi | ifMtlo));
							
	assign ifReGrf2 = (ifNop)? 0:
							((ifSave) | (ifRR) | (ifBeq) | (ifBne));	
							
	assign grfRa1 = (ifNop)? 0:
						 instr[25:21];
						 
	assign grfRa2 = (ifNop)? 0:
						 instr[20:16];
						 
	assign grfWa = (ifNop)? 0:
						(ifLoad | ifRI)? rt:
						(ifAdd | ifAddu | ifSub | ifSubu | ifSlt | ifSltu | ifSll | ifSrl | ifSra | ifSllv | ifSrlv | ifSrav | ifAnd | ifOr | ifXor | ifNor | ifJalr | ifMfhi | ifMflo)? rd:
						(ifJal)? 31:
						0;
						
	assign tUseRs = (ifNop)? 0:
						 (
						 (ifLoad | ifSave) | 
						 (ifAdd | ifAddu | ifSub | ifSubu | ifMult | ifMultu | ifDiv | ifDivu | ifSlt | ifSltu | ifAnd | ifOr | ifXor | ifNor) |
						 (ifAddi | ifAddiu | ifAndi | ifOri | ifXori | ifSlti | ifSltiu) | 
						 (ifMthi | ifMtlo)
						 )? 1:
						 0;
						 
	assign tUseRt = (ifNop)? 0:
						 (ifSave)? 2:						 
						 (ifRR)? 1:
						 0;	 
						 
	assign tNew = 	(ifNop)? 0:
						(ifLoad)? 2:
						(ifRR | ifRI | ifMfhi | ifMflo)? 1:
						0;
						
	//classification	
	assign ifLoad = (ifLb | ifLbu | ifLh | ifLhu | ifLw);
	assign ifSave = (ifSb | ifSh | ifSw);
	assign ifRR = (ifAdd | ifAddu | ifSub | ifSubu | ifMult | ifMultu | ifDiv | ifDivu | ifSlt | ifSltu | ifSll | ifSrl | ifSra | ifSllv | ifSrlv | ifSrav | ifAnd | ifOr | ifXor | ifNor);
	assign ifRI = (ifAddi | ifAddiu | ifAndi | ifOri | ifXori | ifLui | ifSlti | ifSltiu);
	assign ifBranch = (ifBeq | ifBne | ifBlez | ifBgtz | ifBltz | ifBgez);
	assign ifJump = (ifJ | ifJal | ifJalr | ifJr);
	assign ifTrans = (ifMfhi | ifMflo | ifMthi | ifMtlo);
	
	//specific
	//load
	assign ifLb =  	(op == 6'b100000);
	assign ifLbu = 	(op == 6'b100100);
	assign ifLh = 	 	(op == 6'b100001);
	assign ifLhu = 	(op == 6'b100101);
	assign ifLw = 		(op == 6'b100011);
	//save
	assign ifSb = 		(op == 6'b101000);
	assign ifSh = 		(op == 6'b101001);
	assign ifSw = 		(op == 6'b101011);
	//RR
	assign ifAdd = 	(op == 6'b000000) && (low6 == 6'b100000);
	assign ifAddu = 	(op == 6'b000000) && (low6 == 6'b100001);
	assign ifSub = 	(op == 6'b000000) && (low6 == 6'b100010);
	assign ifSubu = 	(op == 6'b000000) && (low6 == 6'b100011);
	assign ifMult = 	(op == 6'b000000) && (low6 == 6'b011000);
	assign ifMultu = 	(op == 6'b000000) && (low6 == 6'b011001);
	assign ifDiv = 	(op == 6'b000000) && (low6 == 6'b011010);
	assign ifDivu = 	(op == 6'b000000) && (low6 == 6'b011011);
	assign ifSlt = 	(op == 6'b000000) && (low6 == 6'b101010);
	assign ifSltu = 	(op == 6'b000000) && (low6 == 6'b101011);
	assign ifSll = 	(op == 6'b000000) && (low6 == 6'b000000);
	assign ifSrl = 	(op == 6'b000000) && (low6 == 6'b000010);
	assign ifSra = 	(op == 6'b000000) && (low6 == 6'b000011);
	assign ifSllv = 	(op == 6'b000000) && (low6 == 6'b000100);
	assign ifSrlv = 	(op == 6'b000000) && (low6 == 6'b000110);
	assign ifSrav = 	(op == 6'b000000) && (low6 == 6'b000111);
	assign ifAnd = 	(op == 6'b000000) && (low6 == 6'b100100);
	assign ifOr = 		(op == 6'b000000) && (low6 == 6'b100101);
	assign ifXor = 	(op == 6'b000000) && (low6 == 6'b100110);
	assign ifNor = 	(op == 6'b000000) && (low6 == 6'b100111);
	//RI
	assign ifAddi =  	(op == 6'b001000);
	assign ifAddiu =  (op == 6'b001001);
	assign ifAndi =   (op == 6'b001100);
	assign ifOri =   	(op == 6'b001101);
	assign ifXori =   (op == 6'b001110);
	assign ifLui =   	(op == 6'b001111);
	assign ifSlti =   (op == 6'b001010);
	assign ifSltiu =  (op == 6'b001011);
	//branch
	assign ifBeq =    (op == 6'b000100);
	assign ifBne =    (op == 6'b000101);
	assign ifBlez =   (op == 6'b000110);
	assign ifBgtz =   (op == 6'b000111);
	assign ifBltz =   (op == 6'b000001) && (rt == 5'b00000);
	assign ifBgez =   (op == 6'b000001) && (rt == 5'b00001);
	//jump
	assign ifJ = 	   (op == 6'b000010);
	assign ifJal =    (op == 6'b000011);
	assign ifJalr =   (op == 6'b000000) && (low6 == 6'b001001);
	assign ifJr = 		(op == 6'b000000) && (low6 == 6'b001000);
	//trans
	assign ifMfhi = 	(op == 6'b000000) && (low6 == 6'b010000);
	assign ifMflo = 	(op == 6'b000000) && (low6 == 6'b010010);
	assign ifMthi = 	(op == 6'b000000) && (low6 == 6'b010001);
	assign ifMtlo = 	(op == 6'b000000) && (low6 == 6'b010011);
	//////////
	
endmodule
