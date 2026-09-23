// File Name: TestBenchLab2.v (Museum Security)
`timescale 1 ns/1 ns	// time scale for simulation
module TestBenchLab2();
	reg [3:0] SW;
	wire [0:0] LEDR;

// Instantiate Museum_Security module
Museum_Security MS(.A(LEDR[0]), .H(SW[3]), .D(SW[2]), .M(SW[1]), .V(SW[0]));

// Test Procedure
	initial
	begin		
	// add a dumpvars clause here
	// your testcases go here
	$dumpvars(0, TestBenchLab2);

	SW = 4'b0000; #5;
	SW = 4'b0001; #5;
	SW = 4'b0010; #5;
	SW = 4'b0011; #5;
	SW = 4'b0100; #5;
	SW = 4'b0101; #5;
	SW = 4'b0110; #5;
	SW = 4'b0111; #5;

	SW = 4'b1000; #5;
	SW = 4'b1001; #5;
	SW = 4'b1010; #5;
	SW = 4'b1011; #5;
	SW = 4'b1100; #5;
	SW = 4'b1101; #5;
	SW = 4'b1110; #5;
	SW = 4'b1111; #5;

	end
endmodule // TestBenchLab2