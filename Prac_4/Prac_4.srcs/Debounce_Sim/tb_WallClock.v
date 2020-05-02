//////////////////////////////////////////////////////////////////////////////////
// Testbench for Wall Clock.v 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module tb_WallClock();
    //tb_variables
    integer n=0;        //counter for sim time
    
    //inputs
    reg CLK100MHZ = 0;  // 100 MHz clock
    reg [1:0] sw = 0;   // sw0 and sw1 for minutes and hours respectively
    
    //outputs
    wire [3:0] an;      // 4 digits of 7 seg display
    wire [7:0] seg;     // 7 segements of 7 seg display
    wire [5:0] LED;     // outputs seconds to LEDs in binary
    
    //UUT	
    WallClock UUT(
        .CLK100MHZ(CLK100MHZ),
        .sw(sw),
        .an(an),
        .seg(seg),
        .LED(LED)
    );
    
    //Initialise
    initial begin
        n = 0;
        CLK100MHZ = 1;
    end
    
    //TB_Logic
    //Activate clock - 10ns period, add counter
    always begin
        #5 CLK100MHZ = ~CLK100MHZ;
        n = n+1;
    end
    //test program
    always @(posedge CLK100MHZ) begin
        case (n)
            //long press sw0
            20: sw[0] <= 1;
            40: sw[0] <= 0;
            //long press sw1
            60: sw[1] <= 1;
            80: sw[1] <= 0;
            //two super fast presses sw0 (should debounce)
            120: sw[0] <= 1;
            122: sw[0] <= 0;
            124: sw[0] <= 1;
            126: sw[0] <= 0;
            //two super fast presses sw0 (should debounce)
            160: sw[1] <= 1;
            162: sw[1] <= 0;
            164: sw[1] <= 1;
            166: sw[1] <= 0;
        endcase
    end
endmodule