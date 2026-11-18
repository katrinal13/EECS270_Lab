module ReactionGameTL(
    input CLOCK_12,          // 50 MHz Clock
    input [3:0] KEY,         // User buttons
    input [17:17] SW,       
    output [6:0] HEX7, HEX6, HEX5, HEX4,  // P1 display
    output [6:0] HEX3, HEX2, HEX1, HEX0,  // P2 display
    output [6:0] LEDR,
    output [3:0] LEDY,
    output [3:0] LEDG
);

    // Using the 50 MHz Clock and Clock_Div, generate a 3.052 kHz Clock
    wire [36:0] CLKS_out;
    Clock_Div cd (
        .CLK_in(CLOCK_12),
        .CLKS_out(CLKS_out)
    );
    wire slowed_clk = CLKS_out[12];

    // =====================================
    // Control & Datapath Wires
    // =====================================
    wire ctrl_start_game, ctrl_show_results, ctrl_game_ready;

    wire datapath_p1Pressed, datapath_p2Pressed;
    wire [15:0] datapath_p1_reactTime;
    wire [15:0] datapath_p2_reactTime;
    wire [15:0] datapath_random_delay;
    wire [1:0] datapath_winner;
    
    wire p1_winner, p2_winner, no_winner;

    // =====================================
    // Controller
    // =====================================
    ReactionGameController rgc (
        .clk(slowed_clk),

        .user_reset(SW[17]),
        .user_start(~KEY[2]),
        .user_showResults(~KEY[1]),

        .datapath_p1Pressed(datapath_p1Pressed),
        .datapath_p2Pressed(datapath_p2Pressed),

        .ctrl_game_ready(ctrl_game_ready),
        .ctrl_start_game(ctrl_start_game),
        .ctrl_show_results(ctrl_show_results)
    );

    // =====================================
    // Reaction Game Datapath
    // =====================================
    ReactionGameDatapath rgd (
        .clk(slowed_clk),
        .user_reset(SW[17]),
        .ctrl_start_game(ctrl_start_game),

        .player_1(~KEY[3]),
        .player_2(~KEY[0]),

        .datapath_oneSecondPassed(LEDR[6]),
        .datapath_p1Pressed(datapath_p1Pressed),
        .datapath_p2Pressed(datapath_p2Pressed),

        .datapath_p1_reactTime(datapath_p1_reactTime),
        .datapath_p2_reactTime(datapath_p2_reactTime),
        .datapath_random_delay(datapath_random_delay)
    );


    // =====================================
    // Game Result Display
    // =====================================
    GameResultsDatapath grd (
        .ctrl_show_results(ctrl_show_results),

        .datapath_p1Pressed(datapath_p1Pressed),
        .datapath_p2Pressed(datapath_p2Pressed),
        .datapath_random_delay(datapath_random_delay),

        .datapath_p1_reactTime(datapath_p1_reactTime),
        .datapath_p2_reactTime(datapath_p2_reactTime),

        .p1_winner(p1_winner),
        .p2_winner(p2_winner),
        .no_winner(no_winner),

        .P1_3(HEX7), .P1_2(HEX6), .P1_1(HEX5), .P1_0(HEX4),
        .P2_3(HEX3), .P2_2(HEX2), .P2_1(HEX1), .P2_0(HEX0)
    );

    // =====================================
    // Additional Output Logic
    // =====================================
    assign LEDR[5:0] = {6{ctrl_game_ready}};
    assign LEDG[3:0] = {4{p1_winner & ~no_winner}};
    assign LEDY[3:0] = {4{p2_winner & ~no_winner}};

endmodule
