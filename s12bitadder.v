module s12bitadder(overflow, sum, a, b);
   input [11:0]  a, b;
   output [11:0] sum;
   output       overflow;

   wire [10:0]   coutinner;
   wire         dummy;


   fulladder1bit fa1(sum[0], coutinner[0], a[0], b[0], 1'b0);
   fulladder1bit fa2(sum[1], coutinner[1], a[1], b[1], coutinner[0]);
   fulladder1bit fa3(sum[2], coutinner[2], a[2], b[2], coutinner[1]);
   fulladder1bit fa4(sum[3], coutinner[3], a[3], b[3], coutinner[2]);
   fulladder1bit fa5(sum[4], coutinner[4], a[4], b[4], coutinner[3]);
   fulladder1bit fa6(sum[5], coutinner[5], a[5], b[5], coutinner[4]);
   fulladder1bit fa7(sum[6], coutinner[6], a[6], b[6], coutinner[5]);
   fulladder1bit fa8(sum[7], coutinner[7], a[7], b[7], coutinner[6]);
   fulladder1bit fa9(sum[8], coutinner[8], a[8], b[8], coutinner[7]);
   fulladder1bit fa10(sum[9], coutinner[9], a[9], b[9], coutinner[8]);
   fulladder1bit fa11(sum[10], coutinner[10], a[10], b[10], coutinner[9]);
   fulladder1bit fa12(sum[11], dummy, a[11], b[11], coutinner[10]);

   assign overflow = ((~a[11])&(~b[11])&(sum[11]))|((a[11])&(b[11])&(~sum[11]));

endmodule
