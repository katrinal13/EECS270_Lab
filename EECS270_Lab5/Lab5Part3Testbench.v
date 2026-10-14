`timescale 1ns / 1ps

module Lab5Part3TestBench;
    reg a, b, c;
    wire y_bad, y_fixed;

    // Instantiate the Hazardous Module
    Lab5Part3 dut_bad (
        .a(a), .b(b), .c(c), .y(y_bad)
    );

    // Instantiate the Fixed Module (See Part 3 below)
    Lab5Part3Fixed dut_good (
        .a(a), .b(b), .c(c), .y(y_fixed)
    );

    initial begin

        // 1. Initialization
        // We set B and C to 1. Logically, Y should ALWAYS be 1.
        a = 1; b = 1; c = 1;
        #10;

        // 2. The Trigger Event (1 -> 0 Transition)
        // We drop A to 0.
        // Because the inverter on A has a delay, the 'p1' term (A*B) drops 
        // INSTANTLY, but the 'p2' term (~A*C) doesn't rise until the inverter catches up.
        // The output Y will glitch to 0.
        a = 0; 
        #20;

        // 3. The Return (0 -> 1 Transition)
        // Usually safer, but worth observing.
        a = 1;
        #20;

    end
endmodule