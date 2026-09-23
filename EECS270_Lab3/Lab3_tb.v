// File Name: Lab3_tb.v

`timescale 1 ns/1 ns
module TestBenchLab3();
    reg [17:0] SW;
    wire [6:0] LEDR;
    wire [3:0] LEDG;
    wire [3:0] LEDY;

    Lab3 L3(
        .SW(SW),
        .LEDR(LEDR),
        .LEDG(LEDG),
        .LEDY(LEDY)
    );

    initial begin
        $dumpvars(0, TestBenchLab3);

        // 00 A + B
        SW[3:0] = 4'b0001;
        SW[17:14] = 4'b0001;
        SW[9:8] = 2'b00;
        #10;

        SW[3:0] = 4'b1111;
        SW[17:14] = 4'b0000;
        SW[9:8] = 2'b00;
        #10;

        // 01 A - B
        SW[3:0] = 4'b0001;
        SW[17:14] = 4'b0001;
        SW[9:8] = 2'b01;
        #10;

        SW[3:0] = 4'b0000; // wrong
        SW[17:14] = 4'b1111;
        SW[9:8] = 2'b01;
        #10;

        // 10 A & B
        SW[3:0] = 4'b0001;
        SW[17:14] = 4'b0001;
        SW[9:8] = 2'b10;
        #10;

        SW[3:0] = 4'b0101;
        SW[17:14] = 4'b0101;
        SW[9:8] = 2'b10;
        #10;

        SW[3:0] = 4'b0000; // wrong
        SW[17:14] = 4'b1111;
        SW[9:8] = 2'b10;
        #10;

        SW[3:0] = 4'b0000;
        SW[17:14] = 4'b0000;
        SW[9:8] = 2'b10;
        #10;

        SW[3:0] = 4'b1111;
        SW[17:14] = 4'b1111;
        SW[9:8] = 2'b10;
        #10;

        // 11 A | B
        SW[3:0] = 4'b0001;
        SW[17:14] = 4'b0001;
        SW[9:8] = 2'b11;
        #10;

        SW[3:0] = 4'b0101; // wrong
        SW[17:14] = 4'b1010;
        SW[9:8] = 2'b11;
        #10;

        SW[3:0] = 4'b0000;
        SW[17:14] = 4'b0000;
        SW[9:8] = 2'b11;
        #10;

        SW[3:0] = 4'b1111;
        SW[17:14] = 4'b1111;
        SW[9:8] = 2'b11;
        #10;

        // assign A = SW[3:0];
        // assign B = SW[17:14];
        // assign Op = SW[9:8];
    end
endmodule