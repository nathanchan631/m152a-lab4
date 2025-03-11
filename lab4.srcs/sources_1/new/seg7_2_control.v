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

module seg7_2_control(
    input [3:0] ones,
    output reg [0:6] seg       // segment pattern 0-9
    );
    
    // Parameters for segment patterns
    parameter ZERO  = ~7'b000_0001;  // 0
    parameter ONE   = ~7'b100_1111;  // 1
    parameter TWO   = ~7'b001_0010;  // 2 
    parameter THREE = ~7'b000_0110;  // 3
    parameter FOUR  = ~7'b100_1100;  // 4
    parameter FIVE  = ~7'b010_0100;  // 5
    parameter SIX   = ~7'b010_0000;  // 6
    parameter SEVEN = ~7'b000_1111;  // 7
    parameter EIGHT = ~7'b000_0000;  // 8
    parameter NINE  = ~7'b000_0100;  // 9
    
    always @*
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
endmodule
