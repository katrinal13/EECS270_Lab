`timescale 1ns/1ns

module part1(
  input a, b,
  output g
);
  // Implement Here

wire c, d, e, f;

not #8 not1(c, a);
nor #(5,9) nor1(d, a, b);
not #8 not2(f, b);
or #(6,2) or1(e, c, d);
nand #(4,7) nand1(g, e, f);

endmodule