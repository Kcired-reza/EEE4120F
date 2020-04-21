`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench for Wall Clock (Q1 of Prac 4)
//////////////////////////////////////////////////////////////////////////////////


module testbench_WallClock;
    reg CLK100MHZ; // 100 MHz clock               
    wire [3:0] an; // 4 digits of 7 seg display
    wire [6:0] seg; // 7 segements of 7 seg display
	
WallClock UUT(
    .CLK100MHZ(CLK100MHZ),
    .an(an),
    .seg(seg)
);

always #5 CLK100MHZ = ~CLK100MHZ;
endmodule
