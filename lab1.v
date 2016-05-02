module lab1(sign, bcd_out, overflow, c, a, b, f, w);
   input [5:0] a, b;
   input [1:0] f;
   input       w;
   output [11:0] c;
   output        overflow;
   output [27:0] bcd_out;
   output       sign;

   wire [11:0]   wsum, wdiff, wproduct;
   wire          wsum_overflow, wdiff_overflow;

   wire [15:0]   wbcd_format;

   s6bitadder add(wsum_overflow, wsum[5:0], a, b);

   s6bitsubtractor sub(wdiff_overflow, wdiff[5:0], a, b);

   s6bitmultiplier mul(wproduct, a, b);

   assign wsum[11:6] = 6'b000000;
   assign wdiff[11:6] = 6'b000000;

   assign overflow = (~f[0])&(~f[1])&wsum_overflow | (~f[0])&(f[1])&wdiff_overflow | 1'b0;

   assign c[0]     = (w&b[0]) | ((~w)&(((~f[0])&(~f[1])&wsum[0]) | ((f[0])&(~f[1])&wdiff[0]) | ((~f[0])&(f[1])&wproduct[0]) ));
   assign c[1]     = (w&b[1]) | ((~w)&(((~f[0])&(~f[1])&wsum[1]) | ((f[0])&(~f[1])&wdiff[1]) | ((~f[0])&(f[1])&wproduct[1]) ));
   assign c[2]     = (w&b[2]) | ((~w)&(((~f[0])&(~f[1])&wsum[2]) | ((f[0])&(~f[1])&wdiff[2]) | ((~f[0])&(f[1])&wproduct[2]) ));
   assign c[3]     = (w&b[3]) | ((~w)&(((~f[0])&(~f[1])&wsum[3]) | ((f[0])&(~f[1])&wdiff[3]) | ((~f[0])&(f[1])&wproduct[3]) ));
   assign c[4]     = (w&b[4]) | ((~w)&(((~f[0])&(~f[1])&wsum[4]) | ((f[0])&(~f[1])&wdiff[4]) | ((~f[0])&(f[1])&wproduct[4]) ));
   assign c[5]     = (w&b[5]) | ((~w)&(((~f[0])&(~f[1])&wsum[5]) | ((f[0])&(~f[1])&wdiff[5]) | ((~f[0])&(f[1])&wproduct[5]) ));
   assign c[6]     = (w&a[0]) | ((~w)&(((~f[0])&(~f[1])&wsum[6]) | ((f[0])&(~f[1])&wdiff[6]) | ((~f[0])&(f[1])&wproduct[6]) ));
   assign c[7]     = (w&a[1]) | ((~w)&(((~f[0])&(~f[1])&wsum[7]) | ((f[0])&(~f[1])&wdiff[7]) | ((~f[0])&(f[1])&wproduct[7]) ));
   assign c[8]     = (w&a[2]) | ((~w)&(((~f[0])&(~f[1])&wsum[8]) | ((f[0])&(~f[1])&wdiff[8]) | ((~f[0])&(f[1])&wproduct[8]) ));
   assign c[9]     = (w&a[3]) | ((~w)&(((~f[0])&(~f[1])&wsum[9]) | ((f[0])&(~f[1])&wdiff[9]) | ((~f[0])&(f[1])&wproduct[9]) ));
   assign c[10]    = (w&a[4]) | ((~w)&(((~f[0])&(~f[1])&wsum[10])| ((f[0])&(~f[1])&wdiff[10])| ((~f[0])&(f[1])&wproduct[10])));
   assign c[11]    = (w&a[5]) | ((~w)&(((~f[0])&(~f[1])&wsum[11])| ((f[0])&(~f[1])&wdiff[11])| ((~f[0])&(f[1])&wproduct[11])));

   s12bittobcd convert(sign, wbcd_format, c);

   bcd bcd_1(bcd_out[6:0], wbcd_format[3:0]);
   bcd bcd_2(bcd_out[13:7], wbcd_format[7:4]);
   bcd bcd_3(bcd_out[20:14], wbcd_format[11:8]);
   bcd bcd_4(bcd_out[27:21], wbcd_format[15:12]);

endmodule
