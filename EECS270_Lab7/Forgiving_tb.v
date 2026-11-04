
`timescale 1ns/1ns

module ForgivingTestbench;

  reg [3:3] KEY;
  reg [2:0] SW;
  wire [0:0] LEDG;

  // Instantiate DUT
  // State HEX outputs can be left unconnected
  ForgivingLock dut(
    .CLK(KEY[3]),
    .Reset(SW[2]),
    .In(SW[0]),
    .Unlocked(LEDG[0])
  );

  initial begin

    // Initialize inputs
    KEY[3] = 1'b1;
    SW = 3'b000;
    #5;


    //NOTE: These testcases are not exhaustive. Make sure to write your own testcases as well
    
    // Reset the state to 0000
    SW[2] = 1'b1;
    #5;
    KEY[3] = 1'b0;
    #5;
    KEY[3] = 1'b1;
    SW[2] = 1'b0;

    // Insert 0 -> 0000
    SW[0] = 1'b0;
    #5;
    KEY[3] = 1'b0;
    #5;
    KEY[3] = 1'b1;

    // Insert 1 -> 0001
    SW[0] = 1'b1;
    #5;
    KEY[3] = 1'b0;
    #5;
    KEY[3] = 1'b1;

    // Insert 0 -> 0010
    SW[0] = 1'b0;
    #5;
    KEY[3] = 1'b0;
    #5;
    KEY[3] = 1'b1;

    #5;
    $finish;

  end

endmodule
