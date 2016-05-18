module s7bittobcd(out_bcd, binary);
   input [6:0] binary;
   output [7:0] out_bcd;

   reg [3:0]     out[1:0];
   wire [3:0]    wout[1:0];

   assign out_bcd = {wout[1], wout[0]};

   generate
        assign wout[0] = out[0];
        assign wout[1] = out[1];
   endgenerate

   integer       i;
   always @(binary)
     begin
        out[1] = 4'd0;
        out[0] = 4'd0;

        for (i = 6; i >= 0; i = i - 1)
          begin
            if(out[1] >= 5)
              out[1] = out[1] + 3;
            if(out[0] >= 5)
              out[0] = out[0] + 3;

            out[1] = out[1] << 1;
            out[1][0] = out[0][3];
            out[0] = out[0] << 1;
            out[0][0] = binary[i];
          end
     end
endmodule
