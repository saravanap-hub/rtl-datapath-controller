// 32 bit shift register module for A and Q



`timescale 1ns/1ps

module shiftreg(data_out,data_in,s_in,lda,sfta,clra,clk);

input [31:0] data_in;
input clk,lda,sfta,clra,s_in;

output reg [31:0] data_out;


always@(posedge clk)

begin
  if(clra) 
   data_out <= 0;
  else if(lda) // if load signal is high then load the data_in to data_out
   data_out <= data_in;
  else if(sfta) // if shift signal is high then shift 
   data_out <= {s_in,data_out[31:1]} ;
end

endmodule


