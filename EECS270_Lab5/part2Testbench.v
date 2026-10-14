`timescale 1ns/1ns

module part2Testbench;
  // Implement Here
  reg a, b;
  wire g;
  part1 p(.a(a), .b(b), .g(g));

  initial begin
    // start at 0
    a = 0; b = 0;
    #60;

    // Keep a at 0, toggle b
    b = 1;
    #60;

    // start at 0
    a = 0; b = 0;
    #60;

    // Keep b at 0, toggle a
    a = 1;
    #60;

    // start at 0
    a = 0; b = 0;
    #60;

    // toggle a->1
    a = 1;
    #60;

    // toggle b->1
    b = 1;
    #60;

    // toggle b->1
    b = 0;
    #60;

  end
  
endmodule