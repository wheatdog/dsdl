module s6bitadder(overflow, sum, a, b);
   input [5:0]  a, b;
   output [5:0] sum;
   output       overflow;

   wire [4:0] coutinner;
   wire       dummy;


   fulladder1bit fa1(sum[0], coutinner[0], a[0], b[0], 1'b0);
   fulladder1bit fa2(sum[1], coutinner[1], a[1], b[1], coutinner[0]);
   fulladder1bit fa3(sum[2], coutinner[2], a[2], b[2], coutinner[1]);
   fulladder1bit fa4(sum[3], coutinner[3], a[3], b[3], coutinner[2]);
   fulladder1bit fa5(sum[4], coutinner[4], a[4], b[4], coutinner[3]);
   fulladder1bit fa6(sum[5], dummy, a[5], b[5], coutinner[4]);
   assign overflow = (~(a[5]^b[5]))^sum[5];

endmodule
