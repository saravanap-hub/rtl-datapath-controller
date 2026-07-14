`timescale 1ns/1ps

module booth(qm1,eqz,clk,data_in,lda,stfa,clra,ldcnt,stfq,clrq,clrff,ldq,decr,addsub,ldm);

input clk,lda,stfa,clra,ldq,stfq,clrq,clrff,addsub,ldm,decr,ldcnt;
input [31:0] data_in;

output qm1,eqz;

wire [31:0] A,Q,M,Z;
wire [3:0] count;



assign eqz= ~|count;



shiftreg AR(A,Z,A[15],lda,stfa,clra,clk);

shiftreg QR(Q,data_in,A[0],ldq,sftq,clrq,clk);

alu A(Z,A,M,addsub);

dff fq(Q[0],qm1,clk,clrff);

pipo mr(M,data_in,clk,ldm);

counter cr(count,decr,ldcnt,clk);



endmodule