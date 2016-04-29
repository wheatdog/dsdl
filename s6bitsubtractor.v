module s6bitsubtractor(overflow, diff, a, b);
   input [5:0]  a, b;
   output [5:0] diff;
   output       overflow;

   wire         dummy;
   wire [5:0]   minusb;

   s6bitadder ad1(dummy, minusb, ~b, 6'b000001);
   s6bitadder ad2(overflow, diff, a, minusb);
endmodule
