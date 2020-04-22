`timescale 1ns / 1ps

module WallClock(
	input wire CLK100MHZ, // 100 MHz clock                  inputs - these will depend on your board's constraint files
    output wire [3:0] an, // 4 digits of 7 seg display      outputs - these will depend on your board's constraint files
	output wire [6:0] seg // 7 segements of 7 seg display
);

	//Add the reset
	reg Reset;
    Delay_Reset Reset0 (CLK100MHZ, BTNC, Reset);

	//Add and debounce the buttons
	wire MButton;
	wire HButton;
	
	// Instantiate Debounce modules here
	
	// registers for storing the time
    reg [3:0]hours1=4'd0;   // ones hours
	reg [3:0]hours2=4'd0;   // tens hours
	reg [3:0]mins1=4'd0;   // ones minutes
	reg [3:0]mins2=4'd0;   // tens minutes
	reg [5:0] secs = 6'd0;
    
	//Initialize seven segment
	// You will need to change some signals depending on you constraints
	SS_Driver SS_Driver1(
		CLK100MHZ, Reset,
		4'd1, 4'd2, 4'd3, 4'd4, // Use temporary test values before adding hours2, hours1, mins2, mins1
		an[3:0], seg[6:0]
	);
	
	// 1 Hz clock divider
	reg CLK1HZ;    // stores value of 1 Hz Clock
	
	ClockDiv   SecCounter(
	   CLK100MHZ,  // 100 Mhz Clock
	   CLK1HZ      // 1 Hz Clock
	);
	//The main logic
	always @(posedge CLK1HZ) begin     // Run whenever 1 second passes
		// implement your logic here
		if (secs == 59) begin
		  secs <= 0;  // Reset to 0 each when 60 secs have passed
		  if (mins1 == 9) begin
		      mins1 <= 0; //  Reset to 0 each when 10 minutes have passed
		      if (mins2 == 5) begin
		          mins2 <= 0;     // Reset to 0 each when 60 minutes have passed
		          if (hours1 == 3 & hours2 == 2) begin
		              hours1 <= 0;    // Reset all to 0 each when 24 hours have passed
		              hours2 <= 0;
		              mins1 <= 0;
		              mins2 <= 0;
		              secs <= 0;
		          end
		          else if (hours1 == 9) begin
		              hours1 <= 0;    // Reset to 0 every 10 hours that pass
		              hours2 <= hours2 + 1;   // Increase by one every 10 hours that pass
		          end
		          else
		              hours1 <= hours1 + 1;   // Increase by 1 every hour that passes
		      end
		      else
		          mins2 <= mins2 + 1; // Increase by 1 every 10 minutes that pass
		  end
		  else
		      mins1 <= mins1 + 1; // Increase by 1 every minute that passes
		end
	    else
	       secs <= secs + 1;   // Increase by 1 each second
	end
endmodule  
