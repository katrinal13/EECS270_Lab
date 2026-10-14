`timescale 1ns / 1ps

module Lab5Part3Fixed (
    input  wire a,
    input  wire b,
    input  wire c,
    output wire y
);

    wire a_n;
    wire p1, p2, p3;// maybe add something here

    // Same delays as before
    not #2 inv1 (a_n, a);

    and #2 g1 (p1, a, b);    // Term: A * B
    and #2 g2 (p2, a_n, c);  // Term: ~A * C
    
    // uncomment the next line, and implement the fix here
    and #2 g4 (p3, b, c);

    or  #2 g3 (y, p3, p2, p1); // ?

endmodule