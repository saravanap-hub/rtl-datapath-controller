`timescale 1ns/1ps

module shiftreg AR(data_out,data_in,s_in,Z,lda,stfa,clra,clk);

input [31:0] data_in;
input clk,lda,stfa,clra,s_in;

output reg [31:0] data_out;


always@(posedge clk)

begin
  if(clra) 
   data_out <= 0;
  else if(lda) 
   data_out <= data_in;
  else if(sfta)
   data_out <= {s_in,data_out[31:1]} ;
end

endmodule


