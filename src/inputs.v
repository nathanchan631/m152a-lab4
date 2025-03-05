`timescale 1ns / 1ps

module inputs(
    input clk,
    input [15:0] sw,
    output reg [15:0] sw_posedge
    );

    reg [1:0] shift_reg [15:0];  // 2-bit shift register for each switch
    reg [15:0] sw_debounced;
    reg [15:0] sw_debounced_prev;

    always @(posedge clk) begin
        // debounce
        shift_reg[0]  <= {shift_reg[0][0], sw[0]};
        shift_reg[1]  <= {shift_reg[1][0], sw[1]};
        shift_reg[2]  <= {shift_reg[2][0], sw[2]};
        shift_reg[3]  <= {shift_reg[3][0], sw[3]};
        shift_reg[4]  <= {shift_reg[4][0], sw[4]};
        shift_reg[5]  <= {shift_reg[5][0], sw[5]};
        shift_reg[6]  <= {shift_reg[6][0], sw[6]};
        shift_reg[7]  <= {shift_reg[7][0], sw[7]};
        shift_reg[8]  <= {shift_reg[8][0], sw[8]};
        shift_reg[9]  <= {shift_reg[9][0], sw[9]};
        shift_reg[10] <= {shift_reg[10][0], sw[10]};
        shift_reg[11] <= {shift_reg[11][0], sw[11]};
        shift_reg[12] <= {shift_reg[12][0], sw[12]};
        shift_reg[13] <= {shift_reg[13][0], sw[13]};
        shift_reg[14] <= {shift_reg[14][0], sw[14]};
        shift_reg[15] <= {shift_reg[15][0], sw[15]};
        
        // Only update output when both bits match
        sw_debounced[0]  <= (shift_reg[0]  == 2'b11) ? 1 : (shift_reg[0]  == 2'b00) ? 0 : sw_debounced[0];
        sw_debounced[1]  <= (shift_reg[1]  == 2'b11) ? 1 : (shift_reg[1]  == 2'b00) ? 0 : sw_debounced[1];
        sw_debounced[2]  <= (shift_reg[2]  == 2'b11) ? 1 : (shift_reg[2]  == 2'b00) ? 0 : sw_debounced[2];
        sw_debounced[3]  <= (shift_reg[3]  == 2'b11) ? 1 : (shift_reg[3]  == 2'b00) ? 0 : sw_debounced[3];
        sw_debounced[4]  <= (shift_reg[4]  == 2'b11) ? 1 : (shift_reg[4]  == 2'b00) ? 0 : sw_debounced[4];
        sw_debounced[5]  <= (shift_reg[5]  == 2'b11) ? 1 : (shift_reg[5]  == 2'b00) ? 0 : sw_debounced[5];
        sw_debounced[6]  <= (shift_reg[6]  == 2'b11) ? 1 : (shift_reg[6]  == 2'b00) ? 0 : sw_debounced[6];
        sw_debounced[7]  <= (shift_reg[7]  == 2'b11) ? 1 : (shift_reg[7]  == 2'b00) ? 0 : sw_debounced[7];
        sw_debounced[8]  <= (shift_reg[8]  == 2'b11) ? 1 : (shift_reg[8]  == 2'b00) ? 0 : sw_debounced[8];
        sw_debounced[9]  <= (shift_reg[9]  == 2'b11) ? 1 : (shift_reg[9]  == 2'b00) ? 0 : sw_debounced[9];
        sw_debounced[10] <= (shift_reg[10] == 2'b11) ? 1 : (shift_reg[10] == 2'b00) ? 0 : sw_debounced[10];
        sw_debounced[11] <= (shift_reg[11] == 2'b11) ? 1 : (shift_reg[11] == 2'b00) ? 0 : sw_debounced[11];
        sw_debounced[12] <= (shift_reg[12] == 2'b11) ? 1 : (shift_reg[12] == 2'b00) ? 0 : sw_debounced[12];
        sw_debounced[13] <= (shift_reg[13] == 2'b11) ? 1 : (shift_reg[13] == 2'b00) ? 0 : sw_debounced[13];
        sw_debounced[14] <= (shift_reg[14] == 2'b11) ? 1 : (shift_reg[14] == 2'b00) ? 0 : sw_debounced[14];
        sw_debounced[15] <= (shift_reg[15] == 2'b11) ? 1 : (shift_reg[15] == 2'b00) ? 0 : sw_debounced[15];

        sw_posedge <= sw_debounced & ~sw_debounced_prev;
        sw_debounced_prev <= sw_debounced;
    end
endmodule