//lh2640 ab4647 nn587 jrdb21

`timescale 1ns / 1ps
// set time unit to 1ns, precision to 1ps

module FullAdder_TB();

    logic a;
    logic b;
    logic cin;
    logic sum;
    logic cout;

    // create the full adder to test
    FullAdder uut(.a(a), .b(b), .sum(sum), .cout(cout), .cin(cin));

    initial
    begin
        a = 0;
        b = 0;
        cin = 0;

        // loop through all input combinations (000 to 111)
        for (int i = 0; i < 8; i++)
        begin
            {a, b, cin} = i; // assign a, b, cin together
            #10; // wait 10 ns
        end
    end
endmodule
