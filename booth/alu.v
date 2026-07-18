`timescale 1ns/1ps

module alu(data_out,din1,din2,addsub);

input [31:0] din1,din2; // 32 bit input data din1 and din2
input addsub;  //control signal for addition and subtraction

output reg [31:0] data_out; // 32 bit output data_out


always@(*)

begin
  if(addsub) // if addsub is 1 then perform addition
   data_out = din1 + din2;
  else 
   data_out = din1 - din2;
end

endmodule