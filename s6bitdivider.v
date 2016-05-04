// http://www.ece.lsu.edu/ee3755/2002/l07.html

module s6bitdivider(q, r, a, b, clk);
   input [5:0] a, b;
   input       clk;
   
   output reg [5:0] q, r;

   reg [11:0]   ra, rb, temp;
   wire         dummy;

   wire [11:0]  wdiff, wx, wy;

   assign wx = ra;
   assign wy = temp;

   s12bitsubtractor s(dummy, wdiff, wx, wy);

   integer      index;

   always @(posedge clk)
     begin
        ra = {6'b000000, a};
        rb = {6'b000000, b};
        for (index = 5; index >= 0; index = index - 1)
          begin
             temp = rb << index;
             if (temp > ra)
               begin
                  q[index] = 1'b0;
               end
             else
               begin
                  #1
                  ra = {wdiff};
                  q[index] = 1'b1;
               end
          end
        r = ra[5:0];
     end
endmodule
