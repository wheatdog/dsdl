module test_div();

   reg [5:0] ia, ib, q, r;
   wire [5:0] wa, wb, wq, wr;

   assign wa = ia;
   assign wb = ib;

   s6bitdivider s(wq, wr, wa, wb);

   initial
     begin
        for (ia = 6'd1; ia < 6'b100000; ia = ia + 1'b1)
          begin
             for (ib = 6'd1; ib < 6'b100000; ib = ib + 1'b1)
               begin
                  #6;
                  q = {wq};
                  r = {wr};
                  $display("%d / %d = %d ... %d", ia, ib, q, r);
                  
               end
          end
     end

endmodule
