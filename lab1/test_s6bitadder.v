module test_s6bitadder();
   reg [5:0] x, y, cin;
   // integer   index, test_data, test_x, test_y, test_sum, test_diff, test_product;
   integer   index, test_data;
   reg signed [5:0] test_x, test_y, test_sum, test_diff, add_ans, diff_ans;
   reg signed [11:0] test_product, product_ans;
   reg               add_overflow, diff_overflow;
   wire [5:0]        wx, wy, wsum, wdiff;
   wire [11:0]       wproduct;
   wire              w_add_overflow, w_diff_overflow;

   assign wx = x;
   assign wy = y;

   s6bitadder a(w_add_overflow, wsum, wx, wy);
   s6bitsubtractor s(w_diff_overflow, wdiff, wx, wy);
   s6bitmultiplier m(wproduct, wx, wy);

   parameter range='b1000000000000;
   initial
     begin
        add_ans = 0;
        add_overflow = 0;
        diff_overflow = 0;
        diff_ans = 0;
        product_ans = 0;
        $display("range: %d - %b", range, range);
        for (test_data = 0; test_data < range; test_data = test_data + 1)
          begin
             for (index = 0; index < 6; index = index + 1)
               begin
                  x[index] = test_data[index];
                  y[index] = test_data[index + 6];
               end

             test_x = x;
             test_y = y;

             test_sum = test_x + test_y;
             test_diff = test_x - test_y;
             test_product = test_x*test_y;

             #1// adder
               for (index = 0; index < 6; index = index + 1)
                 begin
                    add_ans[index] = {wsum[index]};
                 end
             add_overflow = {w_add_overflow};

             if (!((add_ans[0] == test_sum[0]) &&
                   (add_ans[1] == test_sum[1]) &&
                   (add_ans[2] == test_sum[2]) &&
                   (add_ans[3] == test_sum[3]) &&
                   (add_ans[4] == test_sum[4]) &&
                   (add_ans[5] == test_sum[5])))
               begin
                  $display("---------");
                  $display("%b%b%b%b%b%b %b%b%b%b%b%b",
                           test_data[11], test_data[10], test_data[9], test_data[8], test_data[7], test_data[6],
                           test_data[5], test_data[4], test_data[3], test_data[2], test_data[1], test_data[0]);
                  $display("ty: %d, tx: %d, ts: %d, %b%b%b%b%b%b", test_y, test_x, test_sum, 
                           test_sum[5], test_sum[4], test_sum[3], test_sum[2], test_sum[1], test_sum[0]);
                  $display("module ans: %d, add_overflow? %d", add_ans, add_overflow);
               end

             // subtractor
             for (index = 0; index < 6; index = index + 1)
               begin
                  diff_ans[index] = {wdiff[index]};
               end
             diff_overflow = {w_diff_overflow};
             if (!((diff_ans[0] == test_diff[0]) &&
                   (diff_ans[1] == test_diff[1]) &&
                   (diff_ans[2] == test_diff[2]) &&
                   (diff_ans[3] == test_diff[3]) &&
                   (diff_ans[4] == test_diff[4]) &&
                   (diff_ans[5] == test_diff[5])))
               begin
                  $display("---------");
                  $display("%b%b%b%b%b%b %b%b%b%b%b%b", 
                           test_data[11], test_data[10], test_data[9], test_data[8], test_data[7], test_data[6],
                           test_data[5], test_data[4], test_data[3], test_data[2], test_data[1], test_data[0]);
                  $display("ty: %d, tx: %d, ts: %d, %b%b%b%b%b%b", test_y, test_x, test_diff, 
                           test_diff[5], test_diff[4], test_diff[3], test_diff[2], test_diff[1], test_diff[0]);
                  $display("module ans: %d, %b, diff_overflow? %d", diff_ans, diff_ans, diff_overflow);
               end

             // multiplier
             for (index = 0; index < 12; index = index + 1)
               begin
                  product_ans[index] = {wproduct[index]};
               end

             if (!((product_ans[0] == test_product[0]) &&
                   (product_ans[1] == test_product[1]) &&
                   (product_ans[2] == test_product[2]) &&
                   (product_ans[3] == test_product[3]) &&
                   (product_ans[4] == test_product[4]) &&
                   (product_ans[5] == test_product[5]) &&
                   (product_ans[6] == test_product[6]) &&
                   (product_ans[7] == test_product[7]) &&
                   (product_ans[8] == test_product[8]) &&
                   (product_ans[9] == test_product[9]) &&
                   (product_ans[10] == test_product[10]) &&
                   (product_ans[11] == test_product[11])))
               begin
                  $display("---------");
                  $display("%b%b%b%b%b%b %b%b%b%b%b%b",
                           test_data[11], test_data[10], test_data[9], test_data[8], test_data[7], test_data[6],
                           test_data[5], test_data[4], test_data[3], test_data[2], test_data[1], test_data[0]);
                  $display("ty: %d, tx: %d, ts: %d, %b", test_y, test_x, test_product, test_product);
                  $display("module ans: %d, %b", product_ans, product_ans);
               end
          end
     end
endmodule
