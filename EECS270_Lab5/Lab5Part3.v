`timescale 1ns / 1ps

module Lab5Part3 (
    input  wire a, // The "Select" bit that causes the hazard
    input  wire b,
    input  wire c,
    output wire y
);

    wire a_n;    // Inverted A
    wire p1, p2; // Product terms

    // 1. The Inverter Delay (The Root Cause)
    // We add a delay of 2ns here. When 'a' switches 1->0, 'a_n' takes 2ns 
    // to become 1. During that 2ns gap, both 'a' and 'a_n' are essentially 0 
    // relative to the AND gates.
    not #2 inv1 (a_n, a);

    // 2. The Product Terms
    // We give these standard propagation delays (e.g., 2ns)
    and #2 g1 (p1, a, b);   // Term: A * B
    and #2 g2 (p2, a_n, c); // Term: ~A * C

    // 3. The Output
    or  #2 g3 (y, p1, p2);

endmodule