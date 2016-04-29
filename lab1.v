module lab1_alu(overflow, c, a, b, f, w);
   input [5:0] a, b;
   input [1:0] f;
   input       w;
   output reg [11:0] c;
   output        overflow;

   reg [11:0]    ans, sum, diff, product;
   reg           sum_overflow, diffoverflow;

   wire [11:0]   wsum, wdiff, wproduct;

   assign wsum = sum;
   assign wdiff = diff;
   assign wproduct = product;

   assign wsum[11:6] = 6'b000000;
   s6bitadder add(sum_overflow, sum[5:0], a, b);

   assign wdiff[11:6] = 6'b000000;
   s6bitsubtractor sub(diff_overflow, diff[5:0], a, b);

   s6bitmultiplier mul(product, a, b);

   always @(a, b, f, w)
     begin
        if ((~f[0])&(~f[1])) ans = sum;
        if ((~f[0])&(f[1])) ans = diff;
        if ((f[0])&(~f[1])) ans = product;

        if (w)
          begin
             c = ans;
          end
        else
          begin
             c[5:0] = b;
             c[11:0] = a;
          end
     end
endmodule
