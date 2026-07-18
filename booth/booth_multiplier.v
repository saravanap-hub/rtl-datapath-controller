`timescale 1ns/1ps

module booth(qm1,eqz,clk,data_in,lda,sfta,clra,ldcnt,sftq,clrq,clrff,ldq,decr,addsub,ldm);

input clk,lda,sfta,clra,ldq,sftq,clrq,clrff,addsub,ldm,decr,ldcnt;
input [31:0] data_in; // a 32 bit input data_in 

output qm1,eqz;

wire [31:0] A,Q,M,Z; // A is the accumulator, Q is the multiplier, M is the multiplicand, Z is the output of the ALU
wire [5:0] count; // count is the counter for the number of iterations


assign eqz= ~|count; // check if eqz is zero, if yes then set eqz to 1 else 0


shiftreg AR(A,Z,A[31],lda,sfta,clra,clk); // shift register A

shiftreg QR(Q,data_in,A[0],ldq,sftq,clrq,clk); // shift register Q

alu al(Z,A,M,addsub); // ALU for addition and subtraction

dff fq(qm1,Q[0],clk,clrff); // flip-flop for qm1

pipo mr(M,data_in,clk,ldm);

counter cr(count,decr,ldcnt,clk);



endmodule