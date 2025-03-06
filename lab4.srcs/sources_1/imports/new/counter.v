`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2025 12:40:46 PM
// Design Name: 
// Module Name: counter
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

module counter(
    input clk,
    input reset,
    input inc_counter,
    output [3:0] w_ones,
    output [3:0] w_high_score
    );
    
    reg [3:0] ones = 1'b1;
    reg [3:0] high_score = 1'b1;
    
    always @(posedge clk) begin
        if (reset) begin
            ones <= 1;  // Reset to level 1
        end
        
        if (inc_counter) begin
            if (ones == 8)
                ones <= 1;
            else
                ones <= ones + 1;
        end
        
        if (ones > high_score)
            high_score <= ones;
    end
    
    assign w_ones = ones;
    assign w_high_score = high_score;
    
endmodule