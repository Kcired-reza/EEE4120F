module Debounce(
    input clk, 
    input button,
    output reg debounce
);
    //Variables
    reg previous_state = 0;
    reg [21:0]Count = 0; //assume count is null on FPGA configuration
    
    //Debounce Logic
    always @(posedge clk) begin
        previous_state <= button;   //capture button input on the clock edge
        if ((Count < 1) & (previous_state == 1)) begin
            //set output high until next clock edge, start counter
            debounce <= 1;
            Count <= 2000000;   //20ms of delay
        end
        else if ((Count < 1) & (previous_state == 0)) begin
            //input and output equal, do nothing
            debounce <= 0;
        end
        else
            //counter not 0, input irrelevant
            debounce <= 1;
            Count <= Count - 1;
    end
endmodule

