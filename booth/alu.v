`timescale 1ns/1ps

module alu(data_out,din1,din2,addsub);

input [31:0] din1,din2;
input addsub;  

output reg [31:0] data_out;


always@(*)

begin
  if(addsub)
   data_out = din1+din2;
  else 
   data_out = din1-din2;
end

endmodule