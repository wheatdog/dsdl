module test_fulladder1bit();
   reg x, y, cin;
   integer test_data, test_x, test_y, test_cin, test_sum;
   integer combine_ans;
   wire    wx, wy, wcin, wcout, wsum;

   assign wx = x;
   assign wy = y;
   assign wcin = cin;

   fulladder1bit a(wsum, wcout, wx, wy, wcin);

   parameter range=8;
   initial
     begin
        combine_ans = 0;
        test_x = 0;
        test_y = 0;
        test_cin = 0;
        test_sum = 0;

        for(test_data=0; test_data<range; test_data=test_data+1)
          begin

             $display("---------");
             $display("%b%b%b",test_data[2],test_data[1],test_data[0]);

             x = test_data[0];
             y = test_data[1];
             cin = test_data[2];

             test_x = x;
             test_y = y;
             test_cin = cin;

             test_sum = test_x+test_y+test_cin;


             #1//delay
               combine_ans[0] = {wsum};
             combine_ans[1] = {wcout};

             if (test_sum != combine_ans)
               $display("FATAL WRONG!: test data[%d], module output[%d]", test_sum, combine_ans);
             else
               $display("PASS");
          end
     end

endmodule
