`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2025 12:51:15 PM
// Design Name: 
// Module Name: seq_gen
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


module seq_gen(
    input clk,
    input clk_blink,
    input start_seq,
    input[2:0] level,
    output[15:0] led
    );
    
    integer sequences[7:0];
    reg[2:0] index = 0;  // 0-7
    
    reg[15:0] led_reg = 0;
    reg playing_seq = 0;
    
    initial begin
        sequences[0] = 32'h00000009;
        sequences[1] = 32'h000000a2;
        sequences[2] = 32'h00000f65;
        sequences[3] = 32'h000084a6;
        sequences[4] = 32'h000cc027;
        sequences[5] = 32'h0014b91a;
        sequences[6] = 32'h082ba092;
        sequences[7] = 32'h849ea746;
    end
    
    always @(posedge start_seq) begin
        playing_seq <= 1;
    end
    
    always @(posedge clk) begin
        if (playing_seq) begin
            if (index == level) begin
                playing_seq <= 0;  // why is playing_seq becoming low so early
                index <= 0;
            end
            else begin
                led_reg <= 0;
                led_reg[sequences[index]] <= 1;
                
                index <= index + 1;
            end
        end
    end
    
    assign led = led_reg;
    
endmodule
