`timescale 1ns/1ps

module booth(qm1,eqz,clk,data_in,lda,sfta,clra,ldcnt,sftq,clrq,clrff,ldq,decr,addsub,ldm);

input clk,lda,sfta,clra,ldq,sftq,clrq,clrff,addsub,ldm,decr,ldcnt;
input [31:0] data_in;

output qm1,eqz;

wire [31:0] A,Q,M,Z;
wire [5:0] count;


assign eqz= ~|count;



shiftreg AR(A,Z,A[31],lda,sfta,clra,clk);

shiftreg QR(Q,data_in,A[0],ldq,sftq,clrq,clk);

alu al(Z,A,M,addsub);

dff fq(qm1,Q[0],clk,clrff);

pipo mr(M,data_in,clk,ldm);

counter cr(count,decr,ldcnt,clk);



endmodule