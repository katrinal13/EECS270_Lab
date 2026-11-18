// Datapath to Reaction Game
module ReactionGameDatapath(
    input  clk,             // 3.052 kHz Clock

    // User Inputs
    input  user_reset,      // User requesting to restart game immediately
    
    // Control Outputs (Datapth Commands)
    input ctrl_start_game,  // Controller requesting to start the game
    
    // Player Reaction Inputs
    // Assuming player_1 & player_2 are ACTIVE HIGH
    input  player_1,    // Player 1 Reacted
    input  player_2,    // Player 2 Reacted

    // Datapath outputs
    output datapath_oneSecondPassed,  // Indicator that 1 second has passed since game start
    output reg datapath_p1Pressed,    // Indicator that Player 1 has reacted
    output reg datapath_p2Pressed,    // Indicator that Player 2 has reacted

    output reg [15:0] datapath_p1_reactTime,  // Player 1 reaction time (in clock cycles)
    output reg [15:0] datapath_p2_reactTime,   // Player 2 reaction time (in clock cycles)
    output [15:0] datapath_random_delay
);


    // Internal registers
    reg [15:0] counter;
    reg        game_active;

    reg [15:0] random_counter = 0;
    reg [15:0] random_delay = 2930;

    initial counter = 16'd0;
    initial game_active = 0;
    initial datapath_p1Pressed = 0;
    initial datapath_p2Pressed = 0;
    initial datapath_p1_reactTime = 16'd0;
    initial datapath_p2_reactTime = 16'd0;

    //TODO: Procedural block for activating the game (game_active)
    // Once game is active, won't be deactivated until reset received.
    always @(posedge clk) begin
        begin
            if (ctrl_start_game) 
                game_active <= 1;
            else if (user_reset)
                game_active <= 0;
        end
    end

    // TODO: Procedural block for counter
    // Should reset counter on reset.
    // Otherwise, increment the counter when you are suppose to.
    always @(posedge clk) begin
        if (user_reset)
            counter <= 16'd0;
        else if (~user_reset && game_active)
            counter <= counter + 1;
    end

    //////////// THIS SECTION HAS BEEN IMPLEMENTED ///////////////////////
    // Procedural blocks for random start generator
    always @(posedge clk) begin
        random_counter <= random_counter + 1;
    end

    always @(posedge clk) begin
        if (user_reset) begin
            random_delay <= 2930;
        end
        else if (ctrl_start_game && !game_active) begin
            case (random_counter[1:0])
                2'b00: random_delay <= 16'd2930;   // 1 second
                2'b01: random_delay <= 16'd5860;   // 2 seconds
                2'b10: random_delay <= 16'd8790;   // 3 seconds
                2'b11: random_delay <= 16'd11720;  // 4 seconds
            endcase
        end
    end
    //////////// END OF IMPLEMENTED SECTION ///////////////////////


    // TODO: Procedural block for latching Player 1's earliest reaction.
    // Handle both datapath_p1Pressed and datapath_p1_reactTime here.
    // Make sure you are clocking user's time only when you're suppose to.
    always @(posedge clk) begin
        if (datapath_p1Pressed)
            datapath_p1_reactTime =  counter;
    end

    // TODO: Procedural block for latching Player 2's earliest reaction.
    // Handle both datapath_p1Pressed and datapath_p1_reactTime here.
    // Make sure you are clocking user's time only when you're suppose to.
    always @(posedge clk) begin
        if(datapath_p2Pressed)
            datapath_p2_reactTime = counter;
        
    end

    // TODO: Output assignments
    assign datapath_oneSecondPassed = counter;
    assign datapath_random_delay = random_delay;

endmodule
