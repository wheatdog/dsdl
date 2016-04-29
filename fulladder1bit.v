module fulladder1bit(sum, cout, x, y, cin);
   input x, y, cin;
   output sum, cout;
   assign sum = x^y^cin;
   assign cout = (x&y)|(y&cin)|(x&cin);
endmodule
