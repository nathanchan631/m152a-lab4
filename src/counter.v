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
    output [3:0] w_ones
    );
    
    reg [3:0] ones = 1'b1;
    
    always @(posedge clk) begin
        if (reset) begin
            ones <= 1;  // Reset to level 1
        end
        
        if (inc_counter) begin
            if(ones == 9)
                ones <= 0;
            else
                ones <= ones + 1;
        end
    end
    
    assign w_ones = ones;
    
endmodule