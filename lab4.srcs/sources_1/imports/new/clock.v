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
    input clk,
    input reset,
    output reg clk_display,
    output reg clk_blink
    );
    
    // clock divider counters
    reg [31:0] countDisplay = 0;
    reg [31:0] countBlink = 0;
    
    parameter DIV_DISPLAY  = 200_000;      // 500 Hz
    parameter DIV_BLINK   = 100_000_000;  // 1 Hz

    initial begin
        clk_display = 0;
        clk_blink = 0;
    end
    
    // display clock
    always @(posedge clk) begin
        if (reset) begin
            countDisplay <= 0;
            clk_display  <= 0;
        end else begin
            if (countDisplay == DIV_DISPLAY - 1) begin
                countDisplay <= 0;
                clk_display <= 1;
            end else begin
                countDisplay <= countDisplay + 1;
                clk_display <= 0;
            end
        end
    end
    
    // blink clock
    always @(posedge clk) begin
        if (reset) begin
            countBlink <= 0;
            clk_blink  <= 0;
        end else begin
            if (countBlink == DIV_BLINK - 1) begin
                countBlink <= 0;
                clk_blink <= 1;
            end else begin
                countBlink <= countBlink + 1;
                clk_blink <= 0;
            end
        end
    end
    
endmodule
