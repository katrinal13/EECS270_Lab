module Lab6_2(
    input CLOCK_12,
    input [1:0]SW,
    output [6:0] HEX0
);

    wire [36:0] CLKS_out;
    wire [1:0] seconds;

    Clock_Div cd2(.CLK_in(CLOCK_12), .CLKS_out(CLKS_out));
    sec_counter sc(.clk(CLKS_out[23]), .reset(SW[0]), .seconds(seconds));
    seven_seg_decoder ssd(.seconds(seconds), .seg(HEX0));

endmodule