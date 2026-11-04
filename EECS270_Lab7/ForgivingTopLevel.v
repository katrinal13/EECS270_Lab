module ForgivingTopLevel(
  input [3:3] KEY,
  input [2:0] SW,
  output [3:0] LEDG,

  // Additional outptuts for displaying the state
  output [6:0] HEX7, HEX6, HEX5, HEX4
);
    
  //TODO: Instantiate the Forgiving Lock module here DONE
  ForgivingLock f0(.CLK(KEY[3]), .Reset(SW[2]), .In(SW[0]), .Unlocked(LEDG[0]), .Bit3(HEX7[6:0]), .Bit2(HEX6[6:0]), .Bit1(HEX5[6:0]), .Bit0(HEX4[6:0]));

endmodule


module ForgivingLock(
  input CLK,
  input Reset, 
  input In,
  output Unlocked,
  
  // For displaying the states on the FPGA
  output [6:0] Bit3, Bit2, Bit1, Bit0
);

  //PART 1: Declare Parameters //DONE
      // For displaying the states on the FPGA
  localparam ZERO_DISP = 7'b1000000; //TODO: 7 segment bit stream that represents a '0' on the HEX Display DONE
  localparam ONE_DISP  = 7'b1111001; //TODO: 7 segment bit stream that represents a '1' on the HEX Display DONE


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
    //TODO: What should the next value of each bit be if a new bit is shifted in? DONE
    Next_Code[3] = Code[2];
    Next_Code[2] = Code[1];
    Next_Code[1] = Code[0];
    Next_Code[0] = In;
    
  end
  
  //PART 4: State Update (Sequential)
      // --> Sensitivity is clocked on CLK
      // Code only changes on negedge of CLK
  always @(negedge CLK) begin //DONE
    //TODO: What should we update the current value of 'Code' to? What if reset is asserted?
    Code <= Reset ? 4'b000 : Next_Code;
  end

  // PART 5: Output Logic (Combinational)
    //TODO: Under what scenarios should Unlocked be set to 1? DONE
  assign Unlocked = (~Code[3] & Code[2] & ~Code[1]) | (Code[3] & ~Code[2] & Code[1]) | (~Code[2] & Code[1] & ~Code[0]) | (Code[2] & ~Code[1] & Code[0]);

    //TODO: Each Bit should represent the current value of Code DONE
      //Hint: use the localparams declared above to assign the following values
  assign Bit3 = Code[3] ? ONE_DISP : ZERO_DISP;
  assign Bit2 = Code[2] ? ONE_DISP : ZERO_DISP;
  assign Bit1 = Code [1] ? ONE_DISP : ZERO_DISP;
  assign Bit0 = Code[0] ? ONE_DISP : ZERO_DISP;

endmodule
