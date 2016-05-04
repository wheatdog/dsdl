module s12bitsubtractor(overflow, diff, a, b);
   input [11:0]  a, b;
   output [11:0] diff;
   output       overflow;

   wire         is4096, wo;
   wire [11:0]   negb;

   s12bitadder ad1(is4096, negb, ~b, 12'b000000000001);
   s12bitadder ad2(wo, diff, a, negb);
   assign overflow = ((is4096)&((~a[11])&b[11])) |((~is4096)&wo); 
endmodule
