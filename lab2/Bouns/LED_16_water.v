module LED_16_water(CLOCK_50,KEY_0, KEY_1, KEY_2, KEY_3,LEDR);

input CLOCK_50;
input KEY_1, KEY_0, KEY_2, KEY_3;
output [15:0] LEDR;

 wire Clk_1Hz;

 clk_1 U0 (CLOCK_50, KEY_0, Clk_1Hz);
ledwater U1 (LEDR[15:0], Clk_1Hz ); 

 endmodule