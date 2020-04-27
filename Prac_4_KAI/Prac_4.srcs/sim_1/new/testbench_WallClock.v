//////////////////////////////////////////////////////////////////////////////////
// Testbench for Wall Clock (Q1 of Prac 4)
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module testbench_WallClock;
    reg CLK100MHZ = 0; // 100 MHz clock                  inputs - these will depend on your board's constraint files
	reg [1:0] sw = 0;  // sw0 and sw1 for minutes and hours respectively
    wire [3:0] an; // 4 digits of 7 seg display      outputs - these will depend on your board's constraint files
	wire [7:0] seg; // 7 segements of 7 seg display
	wire [5:0] LED;  // outputs seconds to LEDs in binary
	
WallClock UUT(
    .CLK100MHZ(CLK100MHZ),
    .sw(sw),
    .an(an),
    .seg(seg),
    .LED(LED)
);

integer n=0;

initial
begin
    for (n=0; n<1000000; n=n+1)
        #5 CLK100MHZ = ~CLK100MHZ;
        case (n)
            400000: sw[0] <= 1;
            400005: sw[0] <= 0;
            450000: sw[1] <= 1;
            450005: sw[1] <= 0;
            600000: sw[0] <= 1;
            600001: sw[0] <= 0;
            600002: sw[0] <= 1;
            600003: sw[0] <= 0;
            800000: sw[1] <= 1;
            800001: sw[1] <= 0;
            800002: sw[1] <= 1;
            800003: sw[1] <= 0;
        endcase
    #5 $finish;
end
endmodule
