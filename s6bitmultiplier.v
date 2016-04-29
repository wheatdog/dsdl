module s6bitmultiplier(product, a, b);
   input [5:0] a, b;
   output [11:0] product;

   wire [30:0]   coutinner;
   wire [19:0]   suminner;

   assign product[0] = a[0]&b[0];
   fulladder1bit fa1(product[1], coutinner[0], a[1]&b[0], a[0]&b[1], 1'b0);

   fulladder1bit fa2(suminner[0], coutinner[1], a[2]&b[0], a[1]&b[1], coutinner[0]);
   fulladder1bit fa3(product[2], coutinner[2], suminner[0], a[0]&b[2], 1'b0);

   fulladder1bit fa4(suminner[1], coutinner[3], a[3]&b[0], a[2]&b[1], a[1]&b[2]);
   fulladder1bit fa5(suminner[2], coutinner[4], a[0]&b[3], suminner[1], coutinner[1]);
   fulladder1bit fa6(product[3], coutinner[5], coutinner[2], suminner[2], 1'b0);

   fulladder1bit fa7(suminner[3], coutinner[6], a[4]&b[0], a[3]&b[1], a[2]&b[2]);
   fulladder1bit fa8(suminner[4], coutinner[7], a[1]&b[3], a[0]&b[4], suminner[3]);
   fulladder1bit fa9(suminner[5], coutinner[8], coutinner[3], coutinner[4], coutinner[5]);
   fulladder1bit fa10(product[4], coutinner[9], suminner[5], suminner[4], 1'b0);

   fulladder1bit fa11(suminner[6], coutinner[10], ~(a[5]&b[0]), a[4]&b[1], a[3]&b[2]);
   fulladder1bit fa12(suminner[7], coutinner[11], ~(a[0]&b[5]), a[1]&b[4], a[2]&b[3]);
   fulladder1bit fa13(suminner[8], coutinner[12], coutinner[6], coutinner[7], coutinner[8]);
   fulladder1bit fa14(suminner[9], coutinner[13], coutinner[9], suminner[7], suminner[6]);
   fulladder1bit fa15(product[5], coutinner[14], suminner[9], suminner[8], 1'b0);

   fulladder1bit fa16(suminner[10], coutinner[15], ~(a[5]&b[1]), a[4]&b[2], a[3]&b[3]);
   fulladder1bit fa17(suminner[11], coutinner[16], ~(a[1]&b[5]), a[2]&b[4], suminner[10]);
   fulladder1bit fa18(suminner[12], coutinner[17], coutinner[10], coutinner[11], coutinner[12]);
   fulladder1bit fa19(suminner[13], coutinner[18], suminner[11], suminner[12], coutinner[13]);
   fulladder1bit fa20(product[6], coutinner[19], suminner[13], coutinner[14], 1'b1);

   fulladder1bit fa21(suminner[14], coutinner[20], ~(a[5]&b[2]), a[4]&b[3], a[3]&b[4]);
   fulladder1bit fa22(suminner[15], coutinner[21], coutinner[15], coutinner[16], coutinner[17]);
   fulladder1bit fa23(suminner[16], coutinner[22], coutinner[18], coutinner[19], ~(a[2]&b[5]));
   fulladder1bit fa24(product[7], coutinner[23], suminner[14], suminner[15], suminner[16]);

   fulladder1bit fa25(suminner[17], coutinner[24], ~(a[5]&b[3]), a[4]&b[4], ~(a[3]&b[5]));
   fulladder1bit fa26(suminner[18], coutinner[25], coutinner[20], coutinner[21], coutinner[22]);
   fulladder1bit fa27(product[8], coutinner[26], coutinner[23], suminner[17], suminner[18]);

   fulladder1bit fa28(suminner[19], coutinner[27], ~(a[5]&b[4]), ~(a[4]&b[5]), coutinner[24]);
   fulladder1bit fa29(product[9], coutinner[28], coutinner[25], coutinner[26], suminner[19]);

   fulladder1bit fa30(product[10], coutinner[29], a[5]&b[5], coutinner[27], coutinner[28]);

   fulladder1bit fa31(product[11], coutinner[30], coutinner[29], 1'b1, 1'b0);
endmodule
