`timescale 1ns / 1ps
// The line above determines that the # delay
// command uses 1ns steps and that the shortest
// delay considered is 1 ps.

//lh2640 ab4647 nn587 jrdb21

module HalfAdder_TB();

    // Declare testbench variables
    logic a;
    logic b;
    logic sum;
    logic cout;

    // Instantiate the design and connect the inputs/outputs of the HalfAdder
    // with the testbench variables
    HalfAdder uut(.a(a), .b(b), .sum(sum), .cout(cout));

    initial
    begin
        // At the beginning, all inputs are initialised to a known value
        // in this case we have chosen it to be 0.
        a = 0;
        b = 0;

        // Use a $monitor task to print any change in the signal to
        // the console in ModelSim
        $monitor("a=%0b b=%0b sum=%0b cout=%0b", a, b, sum, cout);

        // Because there are only 2 inputs, there can be 4 different input combinations
        // Use an iterator "i" to increment from 0 to 4 and assign the value to the testbench variables
        // that will provide the input signal to the HalfAdder or uut.
        for (int i = 0; i < 4; i++ )
        begin
            {a, b} = i;
            #10;
        end
    end
endmodule
