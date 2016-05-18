module lab1(clear, sign, bcd_out, overflow, c, a, b, f, w, clk);
   input [5:0] a, b;
   input [1:0] f;
   input       w;
   input       clk;
   
   output reg [11:0] c;
   output        overflow;
   output [27:0] bcd_out;
   output       sign;
   output [5:0] clear;

   wire [11:0]   wsum, wdiff, wproduct, wqr;
   wire          wsum_overflow, wdiff_overflow, dummy;
   wire [27:0]   bcd_temp;
   wire [1:0]    wsign_temp;
   wire [3:0]    bcd_condition;

   wire [15:0]   wbcd_format[1:0];

   s6bitadder add(wsum_overflow, wsum[5:0], a, b);
   s6bitsubtractor sub(wdiff_overflow, wdiff[5:0], a, b);
   s6bitmultiplier mul(wproduct, a, b);
   s6bitdivider div(wqr[11:6], wqr[5:0], a, b, clk);

   s6bittobcd  s6convert_1(wsign_temp[0], wbcd_format[0][7:0], c[5:0]);
   s6bittobcd  s6convert_2(dummy, wbcd_format[0][15:8], c[11:6]);
   s12bittobcd s12convert(wsign_temp[1], wbcd_format[1], c);

   bcd bcd_1(bcd_temp[6:0], ((~bcd_condition)&wbcd_format[0][3:0])|(bcd_condition&wbcd_format[1][3:0]));
   bcd bcd_2(bcd_temp[13:7], ((~bcd_condition)&wbcd_format[0][7:4])|(bcd_condition&wbcd_format[1][7:4]));
   bcd bcd_3(bcd_temp[20:14], ((~bcd_condition)&wbcd_format[0][11:8])|(bcd_condition&wbcd_format[1][11:8]));
   bcd bcd_4(bcd_temp[27:21], ((~bcd_condition)&wbcd_format[0][15:12])|(bcd_condition&wbcd_format[1][15:12]));

   assign bcd_condition = {f[1]&(~f[0]),f[1]&(~f[0]),f[1]&(~f[0]),f[1]&(~f[0])};

   assign bcd_out = ~bcd_temp;
   assign sign = ~(((~f[1])&wsign_temp[0]) | (f[1]&wsign_temp[1]));
   assign clear = 6'b111111;

   assign wsum[11:6] = 6'b000000;
   assign wdiff[11:6] = 6'b000000;
   assign overflow = ((~f[0])&(~f[1])&wsum_overflow) | ((f[0])&(~f[1])&wdiff_overflow) | (1'b0);

   always @(posedge clk)
     begin
       #6
        if (w == 1'b0)
          begin
             case(f)
               2'b00: begin
                  c = {wsum};
               end
               2'b01: begin
                  c = {wdiff};
               end
               2'b10: begin
                  c = {wproduct};
               end
               2'b11: begin
                  c = {wqr};
               end
             endcase
          end
        else
          begin
             c = {a, b};
          end
     end
endmodule
