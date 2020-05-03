module Debounce(
    input clk, 
    input button,
    output reg debounce
);
    //Variables
    reg previous_state = 0;
    reg [21:0]Count = 10; //100ns of delay, as each clock cycle is 10ns
    
    //Debounce Logic
    always @(posedge clk) begin
        previous_state = button;   //capture button input on the clock edge
        if ((Count > 9) & (previous_state == 1)) begin
            //set output high, start counter
            debounce = 1;
            Count = 0;   //count up to 10 whenever output goes high
        end
        else if ((Count > 9) & (previous_state == 0)) begin
            //input and output equal, do nothing
            debounce = 0;
        end
        else begin
            //counter not finished, input irrelevant
            debounce = 1;
            Count = Count + 1;
        end
    end
endmodule

