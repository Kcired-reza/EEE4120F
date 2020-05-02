`timescale 1ns / 1ps

module ClockDiv(
    input wire clk,             //100 MHz clock 
    output wire clk_div     // Clock at 1 Hz
    );

localparam div_val = 49;//1Mhz(1us period) - 49; 1hz - 49999999;    
// div_val = 100 Mhz/(2*wanted freq) - 1
integer counter = 0;
reg clk0 = 1;
assign clk_div = clk0;

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
        clk0 <= ~clk0;
    else
        clk0 <= clk0;
end
endmodule
