`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:08:37 12/21/2020 
// Design Name: 
// Module Name:    mips 
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
module mips(
	input clk,
	input reset,
	input interrupt,
	
	output [31:0]addr 
    );
	 
	//Cpu
	wire [31:0]dInCpu_Bridge;
	wire [5:0]hwIntCpu_Outside;
	//Bridge
	wire [31:0]addrBridge_Cpu;
	wire [31:0]dInBridge_Cpu;
	wire [31:0]dInBridge_Dev0;
	wire [31:0]dInBridge_Dev1;
	wire ifWrBridge_Cpu;
	//Dev
	wire [31:0]addrDev_Bridge;
	wire wEnDev0_Bridge;
	wire wEnDev1_Bridge;
	wire [31:0]dInDev_Bridge;
	
	assign hwIntCpu_Outside[2]		=	interrupt;
	assign hwIntCpu_Outside[5:3]	=	0;
		
	Cpu cpu(
		.clk(clk),
		.reset(reset),
		.dIn_Bridge(dInCpu_Bridge),
		.hwInt_Outside(hwIntCpu_Outside),
	
		.dOut_Bridge(dInBridge_Cpu),
		.addr_Bridge(addrBridge_Cpu),
		.ifWr_Bridge(ifWrBridge_Cpu),
		.globalAddr(addr)
	);
	
	Bridge bridge(
		.addr_Cpu(addrBridge_Cpu),
		.dIn_Cpu(dInBridge_Cpu),
		.dIn_Dev0(dInBridge_Dev0),
		.dIn_Dev1(dInBridge_Dev1),
		.ifWr_Cpu(ifWrBridge_Cpu),
	
		.ifWrDev0(wEnDev0_Bridge),
		.ifWrDev1(wEnDev1_Bridge),
		.addr_Dev(addrDev_Bridge),
		.dOut_Dev(dInDev_Bridge),
		.dOut_Cpu(dInCpu_Bridge)
	);
	
	Device0 timer0(
		.clk(clk),
		.reset(reset),
		.Addr(addrDev_Bridge[31:2]),
		.WE(wEnDev0_Bridge),
		.Din(dInDev_Bridge),
		
		.Dout(dInBridge_Dev0),
		.IRQ(hwIntCpu_Outside[0])
	);
	
	Device1 timer1(
		.clk(clk),
		.reset(reset),
		.Addr(addrDev_Bridge[31:2]),
		.WE(wEnDev1_Bridge),
		.Din(dInDev_Bridge),
		
		.Dout(dInBridge_Dev1),
		.IRQ(hwIntCpu_Outside[1])
	);
	

endmodule
