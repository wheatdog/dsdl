module bcdtest();
   reg [11:0] binary;
   reg [15:0] ans;
   reg        sign;

   wire [11:0] wb;
   wire [15:0] wa;
   wire        ws;

   assign wb = binary;

   s12bittobcd convert(ws, wa, wb);

   parameter range='b1000000000000;
   integer     test_data, i;
   initial
     begin
        for (test_data = 0; test_data < range; test_data = test_data + 1)
          begin
             $display("---------");
             $display("%d: %012b", test_data, test_data);

             for (i = 0; i < 12; i = i + 1)
               begin
                  binary[i] = test_data[i];
               end

             #1
               for (i = 0; i < 16; i = i + 1)
                 begin
                    ans[i] = {wa[i]};
                 end
             sign = ws;

             $display("%b %b %b %b", ans[15:12], ans[11:8], ans[7:4], ans[3:0]);
          end
     end
endmodule
