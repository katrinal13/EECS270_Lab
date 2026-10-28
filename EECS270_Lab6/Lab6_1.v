module Lab6_1(
    input [1:0] SW,
    output [1:0] LEDG
);

D_FlipFlop FF(.CLK(SW[0]), .D(SW[1]), .Q(LEDG[0]), .Qn(LEDG[1]));

endmodule