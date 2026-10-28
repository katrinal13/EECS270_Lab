module Lab6_2(
    input CLOCK_12,
    input [1:0]SW,
    output [6:0] HEX0
);

    wire [36:0] CLKS_out;

    Clock_Div cd2(.CLK_in(CLOCK_12), .CLKS_out(CLKS_out));


endmodule