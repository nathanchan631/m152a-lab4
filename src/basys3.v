`timescale 1ns / 1ps

module basys3(
    input clk,
    input [15:0] sw,
    output [15:0] led,
    output [0:6] seg,
    output [3:0] digit
    );

    wire [15:0] sw_posedge;
    
    wire w_display;
    wire w_blink;
    wire [3:0] w_ones;
    wire [3:0] level;

    wire restart_input;  // TODO: connect this to a register and set its initial value to 0
    wire reset_game;
    wire next_level;

    reg start_seq;

    assign level = w_ones - 1;

    // Start by playing the sequence
    initial begin
        start_seq = 1;
    end

    // bring start_seq down to low after one cycle
    always @(posedge clk) begin
        if (reset_game || next_level) begin
            start_seq <= 1;
        end
        if (start_seq) begin
            start_seq <= 0;
        end
    end

    inputs inputs_(
        .clk (clk),
        .sw (sw),
        .sw_posedge (sw_posedge)
    );
    
    clock clock_(
        .clk (clk),
        .reset (reset_game),
        .clk_display (w_display),
        .clk_blink (w_blink)
    );
    
    seq_gen seq_gen_(
        .clk (clk),
        .clk_blink (w_blink),
        .reset (reset_game),
        .start_seq (start_seq),
        .level (level),
        .led (led)
    );

    player_seq player_seq_(
        .clk (clk),
        .restart (restart_input),
        .sw (sw_posedge),
        .level (level),
        .correct (next_level),
        .incorrect (reset_game)
    );
    
    counter counter_ (
        .clk            (clk),
        .reset          (reset_game),
        .inc_counter    (next_level),
        .w_ones         (w_ones)
    );
    
    seg7_control seg7(
        .clk (clk),
        .clk_display (w_display),
        .clk_blink (w_blink),
        .reset (reset_game),
        .ones (w_ones),
        .seg (seg),
        .digit (digit)
    );
    
endmodule
