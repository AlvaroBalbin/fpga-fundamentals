//lh2640 ab4647 nn587 jrdb21s

module HalfAdder
(
    input logic a,   // first input bit
    input logic b,   // second input bit
    output logic sum, // sum output
    output logic cout // carry output
);

    always_comb
    begin
        sum = a ^ b;  // sum is a xor b
        cout = a & b; // carry is a and b
    end
endmodule
