module div_rill
(
input[5:0] a, 
input[5:0] b,

output reg [5:0] x,
output reg [5:0] y
);

reg[5:0] tempa;
reg[5:0] tempb;
reg[11:0] temp_a;
reg[11:0] temp_b;
reg[5:0] temp_1;
reg overflow;

integer i;

always @(a or b)
begin
    tempa <= a;
    tempb <= b;
end

always @(tempa or tempb)
begin
    temp_a = {6'b0,tempa};
    temp_b = {tempb,6'b0};
		temp_1 = {5'b0, 1'b1};	
    for(i=0;i<6;i=i+1)
        begin
            temp_a = {temp_a[11:0],1'b0};
            if(temp_a[11:6] >= tempb)
								s6bitsubtractor s1(overflow, temp_a, temp_a, temp_b);
								s6bitadder s2(overflow, temp_a, temp_a, temp_1);
                //temp_a = temp_a - temp_b + 1'b1;
            else
								temp_a = temp_a;
        end    
    x <= temp_a[5:0];
    y <= temp_a[11:6];
end

endmodule
