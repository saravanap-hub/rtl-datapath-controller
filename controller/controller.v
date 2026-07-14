`timescale 1ns/1ps 


module controller(clk,lda,stfa,clra,ldq,stfq,clrq,clrff,decr,ldcnt,addsub,ldm,start,qm1,Q[0],eqz,done);

output reg lda,stfa,clra,ldq,stfq,clrq,clrff,addsub,ldm,decr,ldcnt,done;
input qm1,Q[0],eqz,clk,start;

reg [2:0] state ;
parameter s0=3b'000 , s1=3b'001 , s2=3b'010 , s3=3b'011 , s4=3b'100 , s5=3b'101, s6=3b'110;


always@(posedge clk)

begin
case(state)
 
 s0 : if(start) state<=s1;
 
 s1 : state <= s2;
 
 s2 : #5 if ({Q[0],qm1}==2b'01) state<=s3; 
  else if({Q[0],qm1}==2b'10) state<=s4;
  else state<=s5;

 s3 : state<=s5;
 
 s4 : state<=s5;
 
 s5 : #5 if({Q[0],qm1}==2b'01 && !eqz) state <= s3;
 else if({Q[0],qm1}==2b'10 && !eqz) state<=s4;
 else if(eqz) state<=s6;

 s6 : state<=s6;

 default : state<=s0;
endcase

end

always@(*)

begin
case(state)
 
 s0 : begin clra=0; clrq=0; clrff=0; done=0; lda=0; ldq=0; stfa=0; sftq=0; end

 s1 : begin ldm=1; clrff=1; clra=1; ldcnt=1; end

 s2 : begin ldq=1; clra=0; clrff=0; ldcnt=0; ldm=0; end
 
 s3 : begin lda=1; addsub=1; ldq=0; sfta=0; sftq=0; decr=0; end
 
 s4 : begin lda=1; addsub=0; end
 
 s5 : begin sfta=1; sftq=1; decr=1; end
 
 s6 : done=1;
 
 default : begin clra=0; sfta=0; ldq=0; sftq=0; end
endcase

end

endmodule