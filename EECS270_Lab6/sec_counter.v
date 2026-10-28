module sec_counter (
    input wire clk,
    input wire reset,
    input wire tick,
    output reg [1:0] seconds
);

parameter zero = 2'b00;
parameter one = 2'b01;
parameter two = 2'10;
parameter three = 2'b11;

initial seconds = zero;

always @(posedge clk) begin
    if (reset) seconds <= zero;
    case ():
        zero: if (tick) seconds <= one; else seconds <= zero;
        one: if (tick) seconds <= two; else seconds <= one;
        two: if (tick) seconds <= three; else seconds <= two;
        three: if (tick) seconds <= zero; else seconds <= three;
    endcase
end

endmodule