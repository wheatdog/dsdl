module bcdtest();
   reg [6:0] binary;
   reg [7:0] ans;

   wire [6:0] wb;
   wire [7:0] wa;

   assign wb = binary;

   s7bittobcd convert(wa, wb);

   parameter range='b10000000;
   integer     test_data, i;
   initial
     begin
        for (test_data = 0; test_data < range; test_data = test_data + 1)
          begin
             $display("--------- --------- --------- ---------");

             for (i = 0; i < 8; i = i + 1)
               begin
                  binary[i] = test_data[i];
               end

             #1
               for (i = 0; i < 16; i = i + 1)
                 begin
                    ans[i] = {wa[i]};
                 end

             $display("%d: %b %b",test_data, ans[7:4], ans[3:0]);
          end
     end
endmodule
