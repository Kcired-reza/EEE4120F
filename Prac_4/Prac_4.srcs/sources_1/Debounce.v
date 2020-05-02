module Debounce(
    input clk, 
    input button,
    output reg debounce 
);
    //Variables
    reg previous_state;
    reg [21:0]Count; //assume count is null on FPGA configuration
    
    //Initialise
    initial begin
        debounce = 0;
        previous_state = 0;
        Count = 0;
    end
    
    //Debounce Logic
    always @(posedge clk) begin 
        // implement your logic here
        previous_state <= button;           //store the current reading to ensure stability
        if (debounce == ~previous_state) begin
            debounce <= previous_state;     // if state has changed, debounce by 30ns
            for (Count = 0; Count < 300; Count = Count +1) begin
                //idle while debouncing for ~30ms
            end
        end
    end 
endmodule

