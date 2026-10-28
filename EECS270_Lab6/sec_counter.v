module sec_counter (
    input wire clk,
    input wire reset,
    output reg [1:0] seconds
);

parameter zero = 2'b00;
parameter one = 2'b01;
parameter two = 2'b10;
parameter three = 2'b11;

initial seconds = zero;

always @(posedge clk) begin
    if (seconds == zero) seconds <= one; 
    if (seconds == one) seconds <= two; 
    if (seconds == two) seconds <= three; 
    if (seconds == three) seconds <= zero; 
    if (reset) seconds <= zero;
end

endmodule
