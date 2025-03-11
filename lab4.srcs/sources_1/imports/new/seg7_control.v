`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2025 12:28:45 PM
// Design Name: 
// Module Name: seg7_control
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


`timescale 1ns / 1ps

module seg7_control(
    input clk_display,
    input reset,
    input [3:0] ones,
    output reg [0:6] seg,       // segment pattern 0-9
    output reg [3:0] digit      // digit select signals
    );
    
    // Parameters for segment patterns
    parameter CLEAR = 7'b111_1111;  // clear
    parameter ZERO  = 7'b000_0001;  // 0
    parameter ONE   = 7'b100_1111;  // 1
    parameter TWO   = 7'b001_0010;  // 2 
    parameter THREE = 7'b000_0110;  // 3
    parameter FOUR  = 7'b100_1100;  // 4
    parameter FIVE  = 7'b010_0100;  // 5
    parameter SIX   = 7'b010_0000;  // 6
    parameter SEVEN = 7'b000_1111;  // 7
    parameter EIGHT = 7'b000_0000;  // 8
    parameter NINE  = 7'b000_0100;  // 9
    parameter L     = 7'b111_0001;
    parameter V     = 7'b100_0001;
    
    // To select each digit in turn
    reg [1:0] digit_select = 0;     // 2 bit counter for selecting each of 4 digits
    
    // Logic for controlling digit select and digit timer
    always @(posedge clk_display or posedge reset) begin
        if(reset) begin
            digit_select <= 0;
        end
        else
            digit_select <=  digit_select + 1;
    end
    
    // Logic for driving the 4 bit anode output based on digit select
    always @(digit_select) begin
        case(digit_select) 
            2'b00 : digit = 4'b1110;   // Turn on ones digit
            2'b01 : digit = 4'b1101;   // Turn on tens digit
            2'b10 : digit = 4'b1011;   // Turn on hundreds digit
            2'b11 : digit = 4'b0111;   // Turn on thousands digit
        endcase
    end
    
    // Logic for driving segments based on which digit is selected and the value of each digit
    always @*
        case(digit_select)
            2'b00 : begin       // ONES DIGIT
                case(ones)
                    4'b0000 : seg = ZERO;
                    4'b0001 : seg = ONE;
                    4'b0010 : seg = TWO;
                    4'b0011 : seg = THREE;
                    4'b0100 : seg = FOUR;
                    4'b0101 : seg = FIVE;
                    4'b0110 : seg = SIX;
                    4'b0111 : seg = SEVEN;
                    4'b1000 : seg = EIGHT;
                    4'b1001 : seg = NINE;
                endcase
            end
            2'b01 : begin       // TENS DIGIT
                seg = L;
            end
            2'b10 : begin       // HUNDREDS DIGIT
                seg = V;
            end
            2'b11 : begin       // MINUTES ONES DIGIT
                seg = L;
            end
        endcase
endmodule
