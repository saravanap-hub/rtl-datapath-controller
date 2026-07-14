`timescale 1ns/1ps

module counter(data_out,dec,ldcr,clk);

output [5:0] data_out;
input dec,ldcr,clk;


always@(posedge clk)

begin 
  if (ldcr) 
   data_out <= 6b'100000;
  else if (dec)
   data_out <= data_out-1;
end

endmodule