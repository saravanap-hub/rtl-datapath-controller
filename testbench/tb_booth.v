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
    #500 $finish;
end

always #5 clk = ~clk;

initial
begin
    #2 data_in = -172;
    #20 data_in = 172;
end

initial
begin
   $monitor(
"t=%0t state=%0d A=%b Q=%b q0=%b qm1=%b eqz=%b M=%b addsub=%b count=%d AQ = %h%h",
$time,
con.state,
b1.A,
b1.Q,
b1.Q[0],
b1.qm1,
b1.eqz,
b1.M,
b1.addsub,
b1.count,
b1.A,
b1.Q
);
    $dumpvars(0,tb_booth);
end
endmodule
