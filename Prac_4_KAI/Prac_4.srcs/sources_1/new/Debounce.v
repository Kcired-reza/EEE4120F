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
    previous_state <= button;           //store the current reading to ensure stability
    if (debounce == ~previous_state) begin
        debounce <= previous_state;     // if state has changed, debounce by 30ns
        #30e6;                           // time delay of 30 ms 
    end
end 


endmodule

