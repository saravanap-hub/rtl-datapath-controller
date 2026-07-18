// Q flip-flop module for qm1

`timescale 1ns/1ps

module dff(q,d,clk,clrff);

input d,clk,clrff;
output reg q;


 always@(posedge clk)

 begin
   if (clrff)
    q<=0;
   else
    q<=d;
 end
 
 endmodule
 