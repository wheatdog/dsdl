module s6bitsubtractor(overflow, diff, a, b);
   input [5:0]  a, b;
   output [5:0] diff;
   output       overflow;

   wire         is32, wo;
   wire [5:0]   negb;

   s6bitadder ad1(is32, negb, ~b, 6'b000001);
   s6bitadder ad2(wo, diff, a, negb);
   assign overflow = ((is32)&((~a[5])&b[5])) |((~is32)&wo); 
endmodule
