`timescale 1ns/1ps

module tb_booth;

reg [31:0] data_in;
reg clk, start;
wire done;

booth b1 (qm1,eqz,clk,data_in,lda,sfta,clra,ldcnt,sftq,clrq,clrff,ldq,decr,addsub,ldm);
controller con(clk,lda,sfta,clra,ldq,sftq,clrq,clrff,decr,ldcnt,addsub,ldm,start,b1.qm1,b1.Q[0],b1.eqz,done);

initial
begin
    clk = 0;
    #1 start = 1;
    #1000 $finish;
end

always #5 clk = ~clk;

initial
begin
    #7 data_in = 172;
    #10 data_in = 15;
end

initial
begin
    $monitor("clk=%b, data_in=%d,count=%d, %b,%b, done=%b", clk, data_in, b1.count,b1.A,b1.Q ,done);
    $dumpfile("tb_booth.vcd"); 
    $dumpvars(0,tb_booth);
end
endmodule