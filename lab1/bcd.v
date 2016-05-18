/*
 http://www.allaboutcircuits.com/textbook/digital/chpt-9/encoder/
 output:
  --         6
 |  |      5   4
  --         3
 |  |      2   1
  --         0
*/


module bcd(out, in);
   input [3:0] in;
   output [6:0] out;

   assign out[0] = in[3] | ((~in[2])&(in[1])) | ((~in[2])&(~in[0])) | (in[1]&(~in[0])) | (in[2]&(~in[1])&(in[0]));
   assign out[1] = in[3] | in[2] | (~in[1]) | in[0];
   assign out[2] = ((~in[2])&(~in[0])) | (in[1]&(~in[0]));
   assign out[3] = in[3] | (in[2]&(~in[1])) | (in[1]&(~in[0])) | ((~in[2])&in[1]);
   assign out[4] = in[3] | (~in[2]) | ((~in[1])&(~in[0])) | (in[1]&in[0]);
   assign out[5] = in[3] | (in[2]&(~in[1])) | ((~in[1])&(~in[0])) | (in[2]&(~in[0]));
   assign out[6] = in[3] | in[1] | (in[2]&in[0]) | ((~in[2])&(~in[0]));

endmodule
