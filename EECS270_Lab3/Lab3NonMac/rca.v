module ripple_adder_4(
    input  [3:0] A,
    input  [3:0] B,
    input        Cin,
    output [3:0] Sum,
    output       Overflow
);

    wire c1, c2, c3,c4;

    full_adder (
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),
        .Sum(Sum[0]),
        .Cout(c1)
    );

    full_adder FA(
        A(A[1]),
        .B(B[1]),
        .Cin(c1),
        .Sum(Sum[1]),
        .Cout(c2)
    );

    full_adder FA(
        .A(A[2]),
        .B(B[2]),
        .Cin(c2),
        .Sum(Sum[2]),
        .cout(c2)
    );

    full_adder FA(
        .A(A[3]),
        .B(B[3]),
        .Cin(c3),
        .Sum(Sum[3]),
        .cout(c4)
    );
    assign Overflow = c4;

endmodule