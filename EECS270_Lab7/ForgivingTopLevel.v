module ForgivingTopLevel(
  input [3:3] KEY,
  input [2:0] SW,
  output [3:0] LEDG,

  // Additional outptuts for displaying the state
  output [6:0] HEX7, HEX6, HEX5, HEX4
);
    
  //TODO: Instantiate the Forgiving Lock module here

endmodule


module ForgivingLock(
  input CLK,
  input Reset, 
  input In,
  output Unlocked,
  
  // For displaying the states on the FPGA
  output [6:0] Bit3, Bit2, Bit1, Bit0
);

  //PART 1: Declare Parameters
      // For displaying the states on the FPGA
  localparam ZERO_DISP = ; //TODO: 7 segment bit stream that represents a '0' on the HEX Display
  localparam ONE_DISP  = ; //TODO: 7 segment bit stream that represents a '1' on the HEX Display

  //PART 2: Declaring state variables
      /* NOTE: All variables modified in procedural blocks need to be reg as well */
  reg [3:0] Code, Next_Code;

  // Not needed as we have a reset, but doesn't hurt
  // REMEMBER: initial is synthesizable for FPGAs!
  initial Code = 4'b0000;

  //PART 3: Next State Logic (Combinational)
      // always @* - Sensitivity list covers ALL inputs
      // If any input changes --> Block gets executed
  always @* begin
    //TODO: What should the next value of each bit be if a new bit is shifted in?
    Next_Code[3] = ;
    Next_Code[2] = ;
    Next_Code[1] = ;
    Next_Code[0] = ;
    
  end
  
  //PART 4: State Update (Sequential)
      // --> Sensitivity is clocked on CLK
      // Code only changes on negedge of CLK
  always @(negedge CLK) begin
    //TODO: What should we update the current value of 'Code' to? What if reset is asserted?
    Code = ;
  end

  // PART 5: Output Logic (Combinational)
    //TODO: Under what scenarios should Unlocked be set to 1?
  assign Unlocked = ;

    //TODO: Each Bit should represent the current value of Code
      //Hint: use the localparams declared above to assign the following values
  assign Bit3 = ;
  assign Bit2 = ;
  assign Bit1 = ;
  assign Bit0 = ;

endmodule
