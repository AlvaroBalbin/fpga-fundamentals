//lh2640 ab4647 nn587 jrdb21

`timescale 1ns / 1ps

module Adder_TB();

    logic [2:0] SW;   // input signals
    logic [1:0] LEDR; // output signals

    // create the adder3 unit under test
    Adder3 uut(.*);

    initial
    begin
        SW = 0; // start with 0

        // loop through all possible inputs (0 to 7)
        for (int i = 0; i < 8; i++)
        begin
            SW = i;  // set SW to i
            #10;     // wait 10 ns
        end
    end
endmodule
