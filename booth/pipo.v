// 32 bit parallel in parallel out register module for M


`timescale 1ns/1ps

module pipo(data_out,data_in,clk,ldm);

input [31:0] data_in;
input clk,ldm;
output reg [31:0] data_out;


always@(posedge clk)

  if(ldm) data_out <= data_in;

endmodule