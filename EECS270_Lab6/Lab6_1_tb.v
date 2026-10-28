`timescale 1ns/1ps

module D_FlipFlop_tb;

    reg D, CLK;
    wire Q, Qn;

    D_FlipFlop dut (
        .D(D),
        .CLK(CLK),
        .Q(Q),
        .Qn(Qn)
    );

    initial begin
        $dumpvars(0, D_FlipFlop_tb);

        // Initialize inputs
        D = 0;
        CLK = 0;
        #10;

        // Test 1: Q captures D = 0 on rising edge
        D = 0;
        CLK = 0; #5
        CLK = 1;
        #10;

        // TODO: Test 2: Changing D while CLK = 1
        // should NOT change Q
        D = 1;
        #10;

        //WRITE MORE TEST CASES HERE
        // Test 3: Changing CLK from 1 -> 0
        // should NOT change Q
        CLK = 0; #5;

        // Test 4: Changing D while CLK = 0
        // should NOT change Q
        D = 0;
        #10;

        D = 1;
        #10;

        CLK = 1;
        #10;

        $finish;
    end

endmodule