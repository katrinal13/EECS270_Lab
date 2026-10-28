module seven_seg_decoder (
    input wire [1:0] seconds,
    output reg [6:0] seg
);

always @(*) begin
    case (seconds)
        2'b00: seg = 7'b1000000;
        2'b01: seg = 7'b1111001;
        2'b10: seg = 7'b0100100;
        2'b11: seg = 7'b0110000;
    endcase
end

endmodule