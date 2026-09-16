module Lab2(
    input [3:0] SW,
    output [0:0] LEDR
);
    
    // Instantiate the Museum_Security module here!
    Museum_Security MS(.A(LEDR[0]), .H(SW[3]), .D(SW[2]), .M(SW[1]), .V(SW[0]));

endmodule // Lab2