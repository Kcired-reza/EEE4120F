`timescale 1ns / 1ps

module top(
    // These signal names are for the nexys A7. 
    // Check your constraint file to get the right names
    input  CLK100MHZ,
    //input [7:0] sw,
    output AUD_PWM, 
    output AUD_SD,
    output [1:0] LED
    );
    
    // Toggle arpeggiator enabled/disabled
    //wire arp_switch;
    //Debounce change_state (CLK100MHZ, BTNL, arp_switch); // ensure your button choice is correct
    
    // Memory IO
    reg ena = 1;
    reg wea = 0;
    reg [7:0] addra=0;
    reg [10:0] dina=0; //We're not putting data in, so we can leave this unassigned
    wire [10:0] douta;
    
    
    // Instantiate block memory here
    blk_mem_gen_0 myBRAM (
        .clka(CLK100MHZ),    // input wire clka
        .ena(ena),      // input wire ena
        .wea(wea),      // input wire [0 : 0] wea
        .addra(addra),  // input wire [7 : 0] addra
        .dina(dina),    // input wire [10 : 0] dina
        .douta(douta)  // output wire [10 : 0] douta
    );
    // Copy from the instantiation template and change signal names to the ones under "MemoryIO"
    
    //PWM Out - this gets tied to the BRAM
    reg [10:0] PWM = 0;
    
    // Instantiate the PWM module
    // PWM should take in the clock, the data from memory
    // PWM should output to AUD_PWM (or whatever the constraints file uses for the audio out.
    pwm_module myPWM (CLK100MHZ, PWM, AUD_PWM);
        
    // Devide our clock down
    reg [12:0] clkdiv = 0;
    
    // keep track of variables for implementation
    reg [26:0] note_switch = 0;
    reg [1:0] note = 0;
    reg [8:0] f_base = 0;
    reg [8:0] f_clk =0;
    
    always @(posedge CLK100MHZ) begin   
        f_base[8:0] = 746; // Base frequency is 262 Hz (middle C)
        note_switch = note_switch + 1;
        if (note_switch == 50000000) begin
            note = note +1;
            note_switch = 0;
        end
        
        clkdiv <= clkdiv + 1;
        case (note)
                0: begin    // base note
                    f_clk <= f_base*2;
                end
                1: begin    //1.25 faster
                    f_clk <= f_base*5/4;
                end
                2: begin    // 1.5 faster
                    f_clk <= f_base*3/2;
                end
                3: begin    // 2 times faster
                    f_clk <= f_base;
                end
                default: begin
                    f_clk <= 1493;
                end
        endcase;
        //check for overflow and increase or decrease address
        if (clkdiv >= f_clk) begin
            clkdiv[12:0] <= 0;
            PWM <= douta;
            addra <= addra + 1;
        end
        
// Loop to change the output note IF we're in the arp state


// FSM to switch between notes, otherwise just output the base note.

end

assign AUD_SD = 1'b1;  // Enable audio out
assign LED[1:0] = note[1:0]; // Tie FRM state to LEDs so we can see and hear changes

endmodule
