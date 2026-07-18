# rtl-datapath-controller

This is a 32-bit signed multiplier built using Radix-2 Booth's algorithm, written in Verilog.
The design multiplies two 32-bit signed numbers and gives a result in the combined `A,Q` register pair (`A` holds the upper bits, `Q` holds the lower bits / the shifting multiplier)

**How it works**

Booth's algorithm looks at pairs of bits `(Q0, Q-1)` on every iteration and decides one of three things:

10 → subtract the multiplicand (M) from the accumulator (A)
01 → add the multiplicand (M) to the accumulator (A)
00 or `11` → do nothing

After the add/subtract (or instead of it) the combined A:Q register is arithmetically shifted right by one bit, and this repeats for every bit of the multiplier (32 times here) Q-1 is a separate 1-bit flip-flop that remembers the bit that just got shifted out of Q0 since that's what the next decision depends on.

**Project structure**

booth/
  booth_multiplier.v   - top-level datapath, wires everything together
  pipo.v                - the multiplicand (M) register
  shiftreg.v            - shared shift register used for both A and Q
  dff.v                 - the single-bit Q-1 flip-flop
  alu.v                 - adder/subtractor
  counter.v             - iteration counter (counts down from 32)
  
controller/
  controller.v          - the FSM that sequences everything
  
testbench/
  tb_booth.v            - testbench

  **The controller moves through states s0 to s6**

s0 - load the multiplicand M

s1 - load the multiplier into Q, clear A and Q-1, load the counter with 32

s2 - one-time initial decode (checks Q0, Q-1 right after loading)

s3 / s4 - add / subtract

s5- shift A and Q right, decrement the counter, and (for every iteration after the first) also do the next decode

s6 - done


**The datapath**

'A' and 'Q' are built from the same `shiftreg` module, connected so that a right shift moves `A`'s sign bit into itself and `A`'s LSB into `Q`'s MSB — this is what keeps the whole thing behaving as one continuous 64-bit shifting register across the two 32-bit halves. `M` is a simple parallel-load register, and the ALU just does `A+M` or `A-M` depending on the current state

