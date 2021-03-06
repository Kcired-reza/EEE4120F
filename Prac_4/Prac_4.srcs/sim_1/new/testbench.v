`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench for 1 Hz clock divider
//////////////////////////////////////////////////////////////////////////////////
module testbench;
    reg clk = 0;             //100 MHz clock
    wire clk_div;     // Clock at 1 Hz
    
// wrapper
ClockDiv UUT (
    .clk(clk),
    .clk_div(clk_div)
);

always #5 clk = ~clk;  //signal flips every 5 ns --> 100 MHz
endmodule
