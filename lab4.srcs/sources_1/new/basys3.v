`timescale 1ns / 1ps

module basys3(
    input clk,
    input [15:0] sw,
    output [15:0] led,
    output [0:6] seg,
    output [3:0] digit
    );
    
    wire w_display = 0;
    wire w_blink = 0;
    wire[3:0] w_ones, w_tens, w_hundreds, w_thousands;

    wire restart = 0;
    wire inc_counter = 0;

    reg[2:0] level = 0;
    reg start_seq = 0;
    reg start_seq_d = 0;
    
    initial begin
        start_seq <= 1;
    end
    
    always @(posedge clk) begin
        start_seq_d <= start_seq;
        if (start_seq_d) begin
            start_seq <= 0;
        end
    end
    
    clock clock_(
        .clk (clk),
        .restart (restart),
        .clk_display (w_display),
        .clk_blink (w_blink)
    );
    
    seq_gen seq_gen_(
        .clk (clk),
        .clk_blink (w_blink),
        .start_seq (start_seq_d),
        .level (level),
        .led (led)
    );
    
    counter counter_ (
        .clk            (clk),
        .restart        (restart),
        .inc_counter    (inc_counter),
        .w_ones         (w_ones),
        .w_tens         (w_tens),
        .w_hundreds     (w_hundreds),
        .w_thousands    (w_thousands)
    );
    
    seg7_control seg7(
        .clk (clk),
        .clk_display (w_display),
        .clk_blink (w_blink),
        .restart (restart),
        .ones (w_ones),
        .tens (w_tens),
        .hundreds (w_hundreds),
        .thousands (w_thousands),
        .seg (seg),
        .digit (digit)
    );
    
endmodule
