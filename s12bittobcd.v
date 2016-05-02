// http://read.pudn.com/downloads114/sourcecode/embed/477952/BIN2BCD.pdf

module s12bittobcd(sign, out_flat, binary);
   input [11:0] binary;
   output       sign;
   output [15:0] out_flat;

   reg [11:0]    temp;

   reg [3:0]     out[3:0];
   wire [3:0]    wout[3:0];

   assign out_flat = {wout[3], wout[2], wout[1], wout[0]};
   assign sign = binary[11];

   genvar        index;
   generate
      for (index = 0; index < 4; index = index + 1)
        assign wout[index] = out[index];
   endgenerate

   integer       i, j;
   always @(binary)
     begin
        if (sign)
          temp = ~binary + 1;
        else
          temp = binary;

        for (i = 0; i < 4; i = i + 1)
          begin
             out[i] = 4'd0;
          end

        for (j = 11; j >= 0; j = j - 1)
          begin
             for (i = 0; i < 4; i = i + 1)
               begin
                  if (out[i] > 4) out [i] = out[i] + 3;
               end

             for (i = 3; i > 0; i = i - 1)
               begin
                  out[i] = out[i] << 1;
                  out[i][0] = out[i - 1][3];
               end
             out[0] = out[0] << 1;
             out[0][0] = temp[j];
          end
     end
endmodule
