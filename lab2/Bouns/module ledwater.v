module ledwater( led, clk );            
output[15:0] led; 
input  clk;  

 reg[15:0] led_r = 16'b000_000_0000_0001;  // 初始設定
assign led = led_r[15:0];  
reg dir = 1;  // 方向
always @(posedge clk)    
begin 
 if(led_r == 16'b0000_0000_0000_0001)    
 begin 
  dir = 1;    
  led_r <= 16'b0000_0000_0000_0001; 
 end 
  
 if(led_r == 16'b1000_0000_0000_0000) 
 begin 
  dir = 0;    
  led_r <= 9'b1000_0000_0000_0000; 
 end 
  
 if(dir) 
  led_r <= led_r << 1;   // 左移  
 else 
  led_r <= led_r >> 1;   // 右移 
  
end 
endmodule
