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
    input restart,
    input inc_counter,
    output wire[3:0] w_ones,
    output wire[3:0] w_tens,
    output wire[3:0] w_hundreds,
    output wire[3:0] w_thousands
    );
    
    reg [3:0] ones = 1'b0;
    reg [3:0] tens = 1'b0;
    reg [3:0] hundreds = 1'b0;
    reg [3:0] thousands = 1'b0;
    
    always @(posedge clk) begin
        if (restart) begin
            ones <= 0;
            tens <= 0;
            hundreds <= 0;
            thousands <= 0;
        end
        
        if (inc_counter) begin
            // ones
            if(ones == 9)
                ones <= 0;
            else
                ones <= ones + 1;
                
            // tens
            if(ones == 9) begin
                if(tens == 5)
                    tens <= 0;
                else
                    tens <= tens + 1;
            end
                    
            // hundreds
            if(tens == 5 && ones == 9) begin
                if(hundreds == 9)
                    hundreds <= 0;
                else
                    hundreds <= hundreds + 1;
            end
                    
            // thousands
            if(hundreds == 9 && tens == 5 && ones == 9) begin
                if(thousands == 9)
                    thousands <= 0;
                else
                    thousands <= thousands + 1;
            end
        end
    end
    
    assign w_ones = ones;
    assign w_tens = tens;
    assign w_hundreds = hundreds;
    assign w_thousands = thousands;
    
endmodule