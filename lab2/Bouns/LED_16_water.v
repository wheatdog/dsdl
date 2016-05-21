module LED_16_water(CLOCK_50,KEY,LEDR);

input CLOCK_50;
input [3:0]KEY;
output [15:0] LEDR;

 wire Clk_1Hz;

 clk_1 U0 (CLOCK_50, KEY[0], Clk_1Hz);
ledwater U1 (LEDR[15:0], Clk_1Hz ); 

 endmodule