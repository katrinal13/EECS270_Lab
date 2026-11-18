// Handle presentation of game results
module GameResultsDatapath(
    
    // Controller Input
    input ctrl_show_results,  // Controller requesting to show game results

    // Reaction Game Datapath Outputs
    input datapath_p1Pressed,            // Indicator that Player 1 has reacted
    input datapath_p2Pressed,            // Indicator that Player 2 has reacted
    input [15:0] datapath_p1_reactTime,  // Player 1 reaction time (in clock cycles)
    input [15:0] datapath_p2_reactTime,  // Player 2 reaction time (in clock cycles)
    input [15:0] datapath_random_delay,

    // Game Results/Outputs
    output p1_winner, p2_winner, no_winner,  // Winner status flags
    output [6:0] P1_3, P1_2, P1_1, P1_0,     // HEX display for player 1 {thousands, hundreds, tens, ones} ms
    output [6:0] P2_3, P2_2, P2_1, P2_0      // HEX display for player 2 {thousands, hundreds, tens, ones} ms
);

    // TODO: Output logic for presenting winner
    // Must account for logic when users pressed too early
    // Will need assign states for p1_winner, p2_winner, and no_winner
    // If tie or both users pressed too early, there is no winner
    wire [1:0] winner;

    // Winner determination logic with false-start detection
    assign winner = (datapath_p1_reactTime == datapath_p2_reactTime) ? 2'b00 : (datapath_p1_reactTime < datapath_p2_reactTime) ? 2'b01 : 2'b10;

    // Winner: one-hot
    assign p1_winner = (winner == 2'b01) // P1 wins
    assign p2_winner = (winner == 2'b10) // P2 wins
    assign no_winner = (winner == 2'b00) // Tie/no winner

    // Handles HEX display for Player 1 Timing in ms
    // Will show full reaction time in ms AFTER LED appears
    // Will show INVALID across the HEXes if user Player 1 pressed too soon
    displayProperTime dpt1(
        .displayTime(ctrl_show_results), 
        .playerPressed(datapath_p1Pressed),
        .reactionTime(datapath_p1_reactTime), 
        .datapath_random_delay(datapath_random_delay),
        .PlayerDisp_3(P1_3), 
        .PlayerDisp_2(P1_2), 
        .PlayerDisp_1(P1_1), 
        .PlayerDisp_0(P1_0));

    // Handles HEX display for Player 2 Timing in ms
    // Will show full reaction time in ms AFTER LED appears
    // Will show INVALID across the HEXes if user Player 2 pressed too soon
    displayProperTime dpt2(
        .displayTime(ctrl_show_results),
        .playerPressed(datapath_p2Pressed), 
        .reactionTime(datapath_p2_reactTime), 
        .datapath_random_delay(datapath_random_delay),
        .PlayerDisp_3(P2_3), 
        .PlayerDisp_2(P2_2), 
        .PlayerDisp_1(P2_1), 
        .PlayerDisp_0(P2_0));

endmodule

// Helper module to handle HEX display outputs
module displayProperTime(
    input displayTime,          // Requesting for actual time to be displayed
    input playerPressed,        // Informing that player has reacted
    input [15:0] reactionTime,  // Providing reaction time of player if player has reacted
    input [15:0] datapath_random_delay,
    // The HEX displays associated with given player
    output reg [6:0] PlayerDisp_3, PlayerDisp_2, PlayerDisp_1, PlayerDisp_0
);


    // Watch video to view HEX outputs
    localparam [6:0] BLANK = 7'b1111111;     // Should show BLANK while user has not reacted
    localparam [6:0] INVALID = 7'b0111111;   // Should show INVALID if user pressed too soon
    localparam [6:0] DASH = 7'b0111111;

    // Converts reaction time from 2.930 kHz clock cycles -> milliseconds
    // Counts total cycles
    // Each cycle is ~0.34133 ms
    // DONE FOR YOU!
    wire [31:0] player_ms;
    assign player_ms = ((reactionTime * 32'd3413) / 32'd10000);

    // TODO: Use division (/) and modulo (%) to obtain the decimal digits of player_ms
    // Want to see time (in ms) AFTER the 1-second timer has finished (should involve a simple subtraction to one of the wires)
    wire [3:0] ms_thousands, ms_hundreds, ms_tens, ms_ones;
    wire [31:0] elapsed_ms;

    assign elapsed_ms = (player_ms >= 1000) ? player_ms - 1000 : 0;
    assign ms_thousands = (elapsed_ms / 1000) % 10 - 1;
    assign ms_hundreds = (elapsed_ms - (ms_thousands * 1000)) / 100;
    assign ms_tens = (elapsed_ms - (ms_thousands * 1000) - (ms_hundreds * 100)) / 10;
    assign ms_ones = (elapsed_ms - (ms_thousands * 1000) - (ms_hundreds * 100) - (ms_tens * 10));

    // Instantiate 4 instances of B4to7Seg to convert the digits -> display
    wire [6:0] thousands_display, hundreds_display, tens_display, ones_display;
    B4to7Seg b1(.digit(ms_thousands), .hexDisplay(thousands_display));
    B4to7Seg b2(.digit(ms_hundreds),  .hexDisplay(hundreds_display));
    B4to7Seg b3(.digit(ms_tens),      .hexDisplay(tens_display));
    B4to7Seg b4(.digit(ms_ones),      .hexDisplay(ones_display));

    always @* begin
        // If the results HAVE NOT been requested to be shown yet
        if (~displayTime) begin
            // If user has not reacted yet, show nothing
            // If the user has reacted, light up all of the HEX segments
            PlayerDisp_3 = BLANK ^ {7{playerPressed}};
            PlayerDisp_2 = BLANK ^ {7{playerPressed}};
            PlayerDisp_1 = BLANK ^ {7{playerPressed}};
            PlayerDisp_0 = BLANK ^ {7{playerPressed}};
        end 
        
        // TODO: If results HAVE been requested to be shown, but user pressed TOO EARLY
        else if (reactionTime < datapath_random_delay) begin
            PlayerDisp_3 = ;
            PlayerDisp_2 = ;
            PlayerDisp_1 = ;
            PlayerDisp_0 = ;
        end 

        // TODO: Reaction time exceeds the 4-digit display limit
        else if (elapsed_ms> 9999) begin
            PlayerDisp_3 = ;
            PlayerDisp_2 = ;
            PlayerDisp_1 = ;
            PlayerDisp_0 = ;
        end
        
        // TODO: If results HAVE been requested to be shown & user pressed at valid time
        else begin
            PlayerDisp_3 = thousands_display;
            PlayerDisp_2 = hundreds_display;
            PlayerDisp_1 = tens_display;
            PlayerDisp_0 = ones_display;
        end
    end

endmodule

// Helper module to convert digit to hexDisplay
module B4to7Seg(
    input [3:0] digit,
    output reg [6:0] hexDisplay
);
    always @* begin
        case (digit)
            4'd0: hexDisplay    = 7'b1000000;  // Display for 0
            4'd1: hexDisplay    = 7'b1111001;  // Display for 1
            4'd2: hexDisplay    = 7'b0100100;  // Display for 2
            4'd3: hexDisplay    = 7'b0110000;  // Display for 3
            4'd4: hexDisplay    = 7'b0011001;  // Display for 4
            4'd5: hexDisplay    = 7'b0010010;  // Display for 5
            4'd6: hexDisplay    = 7'b0000010;  // Display for 6
            4'd7: hexDisplay    = 7'b1111000;  // Display for 7
            4'd8: hexDisplay    = 7'b0000000;  // Display for 8
            4'd9: hexDisplay    = 7'b0010000;  // Display for 9
            default: hexDisplay = 7'b1111111;  // blank
        endcase
    end

endmodule

