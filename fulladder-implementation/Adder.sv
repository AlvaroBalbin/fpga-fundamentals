//lh2640 ab4647 nn587 jrdb21

module Adder
(
    input logic [2:0] SW,   // 3 input bits (2 numbers + carry in)
    output logic [1:0] LEDR // 2 output bits (sum + carry out)
);

    // use a full adder to add the 3 bits
    FullAdder i0(SW[0], SW[1], SW[2], LEDR[0], LEDR[1]);
endmodule
