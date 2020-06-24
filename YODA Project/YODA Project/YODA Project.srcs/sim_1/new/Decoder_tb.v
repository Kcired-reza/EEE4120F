`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2020 20:45:13
// Design Name: 
// Module Name: Decoder_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Decoder_tb();

    reg CLK100MHZ=0;
    wire [7:0] message;
    
    Decoder UUT(CLK100MHZ,message);
    
    always #5 CLK100MHZ <= ~CLK100MHZ;
endmodule
