`timescale 1ns / 1ps

module ClockDiv(
    input wire clk,             //100 MHz clock 
    output reg clk_div  = 0     // Clock at 1 Hz
    );

integer div_val = 49999999;    
// div_val = 100 Mhz/(2*wanted freq) - 1
integer counter = 0;

always@ (posedge clk)
begin
    if (counter == div_val)
        counter <= 0;   // reset counter
    else
        counter <= counter +1;
end

always@ (posedge clk)
begin
    if (counter == div_val)
        clk_div <= ~clk_div;
    else
        clk_div <= clk_div;
end
endmodule
