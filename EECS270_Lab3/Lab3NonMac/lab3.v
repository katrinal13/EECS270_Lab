module Lab3(
    input [17:0] SW,
    output [6:0] LEDR,
    output [3:0] LEDG,
    output [3:0] LEDY
);

    wire [4:0] A, B, Result;
    wire [1:0] Op;
    wire       Overflow;

    assign A  = SW[3:0];
    assign B  = SW[17:14];
    assign Op = SW[9:8];

    alu4 ALU(
        .A(A),
        .B(B),
        .Op(Op),
        .Result(Result),
        .Overflow(Overflow)
    );

    assign LEDG = A;
    assign LEDY = B;
    assign LEDR[3:0] = Result;
    assign LEDR[6:6] = Overflow;
    //assign LEDG = {3'b000, Overflow};
    //assign LEDY = {1'b0, Op};    


endmodule // Lab2