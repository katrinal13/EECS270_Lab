module alu4(
    input  [3:0] A,
    input  [3:0] B,
    input  [1:0] Op,

    output [3:0] Result,
    output Overflow
);

    // Arithmetic signals
    wire [3:0] B_sub;
    wire [3:0] AddSubResult;
    wire       AddSubOver;

    // Logic results
    wire [3:0] AndResult;
    wire [3:0] OrResult;
    wire [3:0] XorResult;

    // For subtraction:
    // Op=001 -> invert B and set Cin=1
    assign B_sub = (Op == 2'b01) ? ~B : B;

    ripple_adder_4 ADDER(
        .A(A),
        .B(B_sub),
        .Cin(Op == 2'b01),
        .Sum(AddSubResult)
        .Overflow(AddSubOver)
    );

    assign AndResult = A && B;
    assign OrResult  = A || B;
    assign XorResult = A ^ B;

    
    
    assign Result = (Op == 2'b00) ? AddSubResult :
                     (Op == 2'b01) ? AddSubResult :
                     (Op == 2'b10) ? OrResult    :
                     AndResult;

    // CarryOut only meaningful for add/sub; 0 otherwise
    assign Overflow = (Op == 2'b00 || Op == 2'b01) ? AddSubOver : 1'b0;

        

endmodule

