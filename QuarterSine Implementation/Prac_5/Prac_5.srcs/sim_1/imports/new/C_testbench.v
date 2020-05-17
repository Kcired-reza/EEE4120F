`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench for waveform generator
//////////////////////////////////////////////////////////////////////////////////


module C_testbench;
    reg  CLK100MHZ=0;
    //reg [7:0] sw;
    wire AUD_PWM; 
    wire AUD_SD;
    wire [1:0] LED;
    
    top UUT(
    .CLK100MHZ(CLK100MHZ),
    //.sw(SW),
    .AUD_PWM(AUD_PWM), 
    .AUD_SD(AUD_SD),
    .LED(LED)
    );
    
    always #5 CLK100MHZ = ~CLK100MHZ;
endmodule
