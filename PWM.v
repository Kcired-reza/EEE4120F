`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:57:30 05/30/2017 
// Design Name: 
// Module Name:    PWM 
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
module PWM(
    input CLK100MHZ,			//input clock
    input [9:0] SW,
    output [3:0] Digits,
    output [7:0] Segs,
	output [3:0] LED
); 

wire rst0;
reg rst=0;
Delay_Reset Rst(CLK100MHZ, BTNC, rst0);

SS_Driver SS_Driver0(
        CLK100MHZ, rst,
        4'd1, 4'd2, 4'd3, 4'd4,
        Digits[3:0],
        Segs[7:0]
);
	
reg [16:0] counter = 0;
always @(posedge CLK100MHZ) begin
//    Write your implementation here
    rst = rst0;
    if(counter<10000)
    counter<= counter+1;
    else
    counter<= 0;
end

assign LED = (counter<2000 && SW == 8'b00000000) ? 1:0;
assign LED = (counter<4000 && SW == 8'b00000001) ? 1:0;
assign LED = (counter<6000 && SW == 8'b00000010) ? 1:0;
assign LED = (counter<8000 && SW == 8'b00000011) ? 1:0;

assign Digits = (counter<200 && SW == 8'b00000000) ? 1:0;
assign Digits = (counter<400 && SW == 8'b00000001) ? 1:0;
assign Digits = (counter<600 && SW == 8'b00000010) ? 1:0;
assign Digits = (counter<800 && SW == 8'b00000011) ? 1:0;
assign Digits = (counter<1000 && SW == 8'b00000100) ? 1:0;
assign Digits = (counter<1200 && SW == 8'b00000101) ? 1:0;
assign Digits = (counter<1400 && SW == 8'b00000110) ? 1:0;
assign Digits = (counter<1800 && SW == 8'b00000111) ? 1:0;
assign Digits = (counter<1000 && SW == 8'b00001000) ? 1:0;
assign Digits = (counter<1200 && SW == 8'b00001001) ? 1:0;
assign Digits = (counter<1400 && SW == 8'b00001010) ? 1:0;
assign Digits = (counter<1800 && SW == 8'b00001011) ? 1:0;
assign Digits = (counter<2000 && SW == 8'b00001100) ? 1:0;
assign Digits = (counter<2200 && SW == 8'b00001101) ? 1:0;
assign Digits = (counter<2400 && SW == 8'b00001110) ? 1:0;
assign Digits = (counter<2800 && SW == 8'b00001111) ? 1:0;

assign Segs = (counter<200 && SW == 8'b00000000) ? 1:0;
assign Segs = (counter<400 && SW == 8'b00000001) ? 1:0;
assign Segs = (counter<600 && SW == 8'b00000010) ? 1:0;
assign Segs = (counter<800 && SW == 8'b00000011) ? 1:0;
assign Segs = (counter<1000 && SW == 8'b00000100) ? 1:0;
assign Segs = (counter<1200 && SW == 8'b00000101) ? 1:0;
assign Segs = (counter<1400 && SW == 8'b00000110) ? 1:0;
assign Segs = (counter<1800 && SW == 8'b00000111) ? 1:0;
assign Segs = (counter<1000 && SW == 8'b00001000) ? 1:0;
assign Segs = (counter<1200 && SW == 8'b00001001) ? 1:0;
assign Segs = (counter<1400 && SW == 8'b00001010) ? 1:0;
assign Segs = (counter<1800 && SW == 8'b00001011) ? 1:0;
assign Segs = (counter<2000 && SW == 8'b00001100) ? 1:0;
assign Segs = (counter<2200 && SW == 8'b00001101) ? 1:0;
assign Segs = (counter<2400 && SW == 8'b00001110) ? 1:0;
assign Segs = (counter<2800 && SW == 8'b00001111) ? 1:0;

endmodule
