module Debounce(
    input clk, 
    input button,
    output reg debounce 
);

reg previous_state;
reg [21:0]Count; //assume count is null on FPGA configuration

//--------------------------------------------
always @(posedge clk) begin 
    // implement your logic here
    if (button == previous_state)
        previous_state <= previous_state;   // state has not changed
    else
        previous_state <= button;   // state has changed
        
    #3e7;   // time delay of 30 ms 
end 


endmodule

