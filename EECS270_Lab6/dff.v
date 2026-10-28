`timescale 1ns/1ns

////////////////////////////////////
// Module 1: SR Latch (Active-High)
////////////////////////////////////
module SR_Latch (
    input  wire S,
    input  wire R,
    output wire Q,
    output wire Qn
);

assign Q = R ~| Qn;
assign Qn = S ~| Q;

endmodule


/////////////////////////////////////////////
// Module 2: Positive Level-Sensitive D Latch
/////////////////////////////////////////////
module D_Latch (
    input  wire D,
    input  wire EN,
    output wire Q,
    output wire Qn
);

wire S, R;
assign S = D & EN;
assign R = ~D & EN;
SR_Latch SR(.S(S), .R(R), .Q(Q), .Qn(Qn));

endmodule


/////////////////////////////////////////////////
// Module 3: Positive Edge-Triggered D Flip-Flop
/////////////////////////////////////////////////
module D_FlipFlop (
    input  wire D,
    input  wire CLK,
    output wire Q,
    output wire Qn
);

//wire QL;
//D_Latch Leader(.D(D), .EN(~CLK), .Q(QL), .Qn());
//D_Latch Follower(.D(QL), .EN(CLK), .Q(Q), .Qn(Qn)); 

// Synthesis Code
 always @(posedge CLK) begin
     Q <= D;
 end

endmodule
