`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2025 12:39:01 PM
// Design Name: 
// Module Name: clock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock(
    clk, restart,  // inputs
    clk_display, clk_blink  // outputs
    );
    
    input clk;
    input restart;
    output clk_display;
    output clk_blink;
    
    // output registers
    reg clk_display_reg;
    reg clk_blink_reg;
    
    // clock divider counters
    reg [31:0] countDisplay  = 0;
    reg [31:0] countBlink = 0;
    
    // TODO: These should be 1000 times larger
    parameter DIV_DISPLAY  = 200;      // 500 Hz
    parameter DIV_BLINK   = 100_000;  // 1 Hz
    
    // display clock
    always @(posedge clk) begin
        if (restart) begin
            countDisplay <= 0;
            clk_display_reg  <= 0;
        end else begin
            if (countDisplay == DIV_DISPLAY - 1) begin
                countDisplay <= 0;
                clk_display_reg <= 1;
            end else begin
                countDisplay <= countDisplay + 1;
                clk_display_reg <= 0;
            end
        end
    end
    
    // blink clock
    always @(posedge clk) begin
        if (restart) begin
            countBlink <= 0;
            clk_blink_reg  <= 0;
        end else begin
            if (countBlink == DIV_BLINK - 1) begin
                countBlink <= 0;
                clk_blink_reg <= 1;
            end else begin
                countBlink <= countBlink + 1;
                clk_blink_reg <= 0;
            end
        end
    end
    
    assign clk_display = clk_display_reg;
    assign clk_blink = clk_blink_reg;
    
endmodule
