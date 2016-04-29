module testbcdtable();
   integer i, j;

   reg [6:0] out;
   reg [3:0] in;

   wire [6:0] wout;
   wire [3:0] win;

   assign win = in;

   bcd convert(wout, win);

   initial
     begin
        $display("3 2 1 0 6 5 4 3 2 1 0");
        for (i = 0; i < 10; i = i + 1)
          begin
             for (j = 0; j < 4; j = j + 1)
               begin
                  in[j] = i[j];
               end

             #1
               for (j = 0; j < 7; j = j + 1)
                 begin
                        out[j] = {wout[j]};
                 end

             $display("%b %b %b %b %b %b %b %b %b %b %b", i[3], i[2], i[1], i[0],
                      out[6], out[5], out[4], out[3], out[2], out[1], out[0]);
          end
     end
endmodule
