// Controller to Reaction Game
module ReactionGameController(
    input clk,               // 3.052 kHz Clock

    // User Inputs
    input user_reset,        // User requesting to restart game immediately
    input user_start,        // User requesting to begin new game
    input user_showResults,  // User requesting to see results of finished game

    // Datapath Output (Inputs for Controller)
    input datapath_p1Pressed,  // Datapath informing P1 pressed their button
    input datapath_p2Pressed,  // Datapath informing P2 pressed their button

    // Control Outputs (Datapth Commands)
    output ctrl_start_game,    // Controller requesting to start the game
    output ctrl_show_results,  // Controller requesting to show the results
    output ctrl_game_ready     // Controller informing the game is ready to be played
);

    // Defining Controller States
    localparam Ready = 3'd0;
    localparam StartGame = 3'd1;
    localparam StartLightOn = 3'd2;
    localparam PlayersPressed = 3'd3;
    localparam ShowResults = 3'd4;

    // Declaring Current & Next State of Controller
    reg [2:0] Q, Q_Next;

    // TODO: Initialize Q to be at READY Stage
    initial Q = Ready;

    // TODO: Next-State Logic (case statement)
    always @* begin
        case(Q)
            Ready:
                if (user_start) Q_next <= StartGame;
            StartGame:
                Q_next <= StartLightOn;
            StartLightOn:
                if (datapath_p1Pressed && datapath_p2Pressed) Q_next <= PlayersPressed;
            PlayersPressed:
                if (user_showResults) Q_next <= ShowResults;
            ShowResults: 
                if (user_reset) Q_next <= Ready;
        endcase
    end

    // TODO: Controller State Update
    always @(posedge clk) begin
        Q <= Q_next
    end

    // TODO: Controller Output Logic
    assign ctrl_start_game = (Q == StartGame);
    assign ctrl_show_results = (Q == ShowResults);
    assign ctrl_game_ready = (Q == StartLightOn);
    
endmodule

