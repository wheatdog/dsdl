module clk_1( input clk_50mhz, input reset_n, output  reg clk_1hz);

 reg [25:0]  count;

 always @(posedge clk_50mhz or negedge reset_n)
    if(!reset_n) begin
                        count   <= 26'd2499999;
                        clk_1hz <= 1'b0;
    end else begin
                        count   <= count + 26'h1ffffff;
        if(!count) begin
                        count   <= 26'd2499999;
                        clk_1hz <= ~clk_1hz;
        end
    end

 endmodule
