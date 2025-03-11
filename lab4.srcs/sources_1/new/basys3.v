`timescale 1ns / 1ps

module basys3(
    input clk,
    input [15:0] sw,
    input btn0,
    output [15:0] led,
    output [0:6] seg,
    output [3:0] digit,
    output sound,
    output [0:6] seg2,
    output seg2_sel
    );

    wire [15:0] sw_posedge;
    
    wire w_display;
    wire w_blink;
    wire [3:0] w_ones;
    wire [3:0] level;
    wire [3:0] w_high_score;
    
    reg start_seq;

    wire restart_input;
    wire reset_game;
    wire next_level;

    assign level = w_ones - 1;
    assign restart_input = btn0;

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
    
    tone_generator buzzer(
      .clk (clk),
      .correct (next_level),
      .incorrect (reset_game),
      .sound (sound)
    );

    counter counter_ (
        .clk            (clk),
        .reset          (reset_game),
        .inc_counter    (next_level),
        .w_ones         (w_ones),
        .w_high_score   (w_high_score)
    );
    
    seg7_control seg7_(
        .clk_display (w_display),
        .reset (reset_game),
        .ones (w_ones),
        .seg (seg),
        .digit (digit)
    );
    
    seg7_2_control seg7_2(
        .ones (w_high_score),
        .seg (seg2)
    );
    
    assign seg2_sel = 0;
    
endmodule
