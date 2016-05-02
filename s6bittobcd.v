// http://read.pudn.com/downloads114/sourcecode/embed/477952/BIN2BCD.pdf

module s6bittobcd(sign, out_flat, binary);
   input [5:0] binary;
   output       sign;
   output [7:0] out_flat;

   reg [5:0]    temp;

   reg [3:0]     out[1:0];
   wire [3:0]    wout[1:0];

   assign out_flat = {wout[1], wout[0]};
   assign sign = binary[5];

   genvar        index;
   generate
      for (index = 0; index < 2; index = index + 1)
        assign wout[index] = out[index];
   endgenerate

   integer       i, j;
   always @(binary)
     begin
        if (sign)
          temp = ~binary + 1;
        else
          temp = binary;

        for (i = 0; i < 2; i = i + 1)
          begin
             out[i] = 4'd0;
          end

        for (j = 5; j >= 0; j = j - 1)
          begin
             for (i = 0; i < 2; i = i + 1)
               begin
                  if (out[i] > 4) out [i] = out[i] + 3;
               end

             for (i = 1; i > 0; i = i - 1)
               begin
                  out[i] = out[i] << 1;
                  out[i][0] = out[i - 1][3];
               end
             out[0] = out[0] << 1;
             out[0][0] = temp[j];
          end
     end
endmodule
