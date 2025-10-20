//lh2640 ab4647 nn587 jrdb21

module FullAdder
(
    input logic a,   // first input bit
    input logic b,   // second input bit
    input logic cin, // carry in
    output logic sum, // sum output
    output logic cout // carry out
);

    logic c0; // carry from first half adder
    logic c1; // carry from second half adder
    logic s0; // sum from first half adder

    // first half adder: add a and b
    HalfAdder i1(a, b, s0, c0);

    // second half adder: add s0 and cin
    HalfAdder i2(s0, cin, sum, c1);

    // final carry out
    assign cout = c0 | c1;

endmodule
