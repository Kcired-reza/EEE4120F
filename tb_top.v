`timescale 1ns / 1ps

module tb_top;

//registers and wires
reg CLK100MHZ;
reg [9:0] SW;
wire [3:0] an;
wire [7:0] seg;
wire [5:0] LED;

//UUT
WallClock dut(.CLK100MHZ(CLK100MHZ), 
        .SW(SW),
        .an(an),
        .seg(seg),
        .LED(LED));

//Initialize
initial begin

CLK100MHZ = 0;
forever #50 CLK100MHZ = ~CLK100MHZ;

end

//Test cases
initial begin
SW= 8'b00000000;
#20
SW= 8'b00000001;
#20
SW = 8'b00000010; 
#20
SW= 8'b00000011;
#20
SW= 8'b00000100;
#20
SW= 8'b00000101;
#20
SW= 8'b00000110;
#20
SW = 8'b00000111; 
#20
SW= 8'b00001000;
#20
SW= 8'b00001001;
#20
SW= 8'b00001010;
#20
SW= 8'b00001011;
#20
SW = 8'b00001100; 
#20
SW = 8'b00001101;
#10
SW = 8'b00001110;
#20
SW = 8'b00001111;
#100 $stop;
end

endmodule