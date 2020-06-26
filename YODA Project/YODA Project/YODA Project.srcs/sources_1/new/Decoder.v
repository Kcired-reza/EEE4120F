`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2020 16:41:37
// Design Name: 
// Module Name: Decoder
// Project Name: YODA Project
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:Bram has a depth of 256 samples, therefore a maximum of
//                     255 characters can be recovered from message. First byte
//                     will be used to tell you how many characters to retrieve
//////////////////////////////////////////////////////////////////////////////////


module Decoder(
    input CLK100MHZ,
    output wire [7:0] message   // 8-bit message to be extracted
    );
    
    reg start=0;             // Indicates if program is just starting
    reg [7:0] final=0;
    //reg [7:0] char = 8'd255; // stores nmber of characters to retrieve; value will be adjusted once character number is determined 
    reg [18:0] samples=0;     // Keeps track of number of samples stored
    reg [3:0] bit=-1;           // Keeps track of number bits captured for a byte          
    reg [7:0] temp_decoded=0;  // Temporary storage of stored bits, will end up as byte to be recorded
    reg [7:0] encoded=0;       // Encoded byte from image   
    integer rst_count=0;     // Keeps track of number of samples that have been reset
    
    // BRAM decoded Variables
    reg ena_d =1;
    reg wea_d = 1;      // High when writing to BRAM
    reg [7:0] addra_d = 0;    // Current address in BRAM
    reg [7:0] dina_d= 0;      // Byte to be written into BRAM
    wire [7:0] douta_d;        // Byte read from BRAM
    
    bram_decoded_message Decoded_Message (
  .clka(CLK100MHZ),    // input wire clka
  .ena(ena_d),      // input wire ena
  .wea(wea_d),      // input wire [0 : 0] wea
  .addra(addra_d),  // input wire [7 : 0] addra
  .dina(dina_d),    // input wire [7 : 0] dina
  .douta(douta_d)  // output wire [7 : 0] douta
);

    // BRAM encoded (encrypted) Variables
    reg ena_e =1;
    reg wea_e = 0;    // High when writing to BRAM
    reg [7:0] addra_e = 0;  // Current address in BRAM
    reg [7:0] dina_e = 0;       // Byte to be written into BRAM
    wire [7:0] douta_e;      // Byte read from BRAM
    
    // BRAM Containing encoded message
    bram_encoded_message Encoded_Message (
  .clka(CLK100MHZ),    // input wire clka
  .ena(ena_e),      // input wire ena
  .wea(wea_e),      // input wire [0 : 0] wea
  .addra(addra_e),  // input wire [7 : 0] addra
  .dina(dina_e),    // input wire [7 : 0] dina
  .douta(douta_e)  // output wire [7 : 0] douta
);

    //Clock Divider
    wire CLK1MHZ;
    ClockDiv CLK1MHZ_Div (CLK100MHZ,CLK1MHZ);
    
//    initial begin
//        for (rst_count=0;rst_count<50;rst_count=rst_count+1) begin
//            dina_d = 8'b0;
//            addra_d = addra_d + 1;
//        end
//            start <=0;
//            addra_d <= 0;
//    end
    
    // This always block resets all the addresses in bram_decoded_message to zero at the start
//    always @(posedge CLK1MHZ & start==1) begin
//            dina_d = 8'b0;
//            addra_d = addra_d + 1;
//            rst_count = rst_count+1;
//            if (rst_count == 50) begin
//                // wea_d =0;
//                start <=0;
//                addra_d <= 0;
//            end     
//    end
    
     //Main Logic: Runs after BRAM reset is complete
    always @ (posedge CLK1MHZ & start == 0 & samples < 6) begin
        //encoded = douta_e;
        temp_decoded[bit] = douta_e[0]; // Puts first bit of extracyed byte into temp register
        
        bit = bit + 1;
        if (bit >=8) begin  // if entire byte has been retrieved
            bit <= 0;
            addra_d <= addra_d +1;
            dina_d <= temp_decoded; // write decrypted byte into BRAM Decoded_Message
            final <= temp_decoded;    // Pass byte to message register to be outputed by module
            samples <= samples + 1; // Increase everytime a byte is decrypted
            temp_decoded = 0;
        end
        addra_e = addra_e + 1;
    end
    assign message = final;
endmodule
