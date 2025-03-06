module player_seq(
    input clk,
    input restart,
    input[15:0] sw,
    input [3:0] level,
    output reg correct,
    output reg incorrect
    );

    reg[3:0] index = 0; // 0-8
    integer sequences[7:0];

    reg[31:0] player_input = 32'h00000000;
    wire[3:0] encoded_sw;

    initial begin
        sequences[0] = 32'h00000009;
        sequences[1] = 32'h000000a2;
        sequences[2] = 32'h00000f65;
        sequences[3] = 32'h000084a6;
        sequences[4] = 32'h000cc027;
        sequences[5] = 32'h0014b91a;
        sequences[6] = 32'h082ba092;
        sequences[7] = 32'h849ea746;
        correct = 0;
        incorrect = 0;
    end

    encoder16to4 encoder_(
        .in (sw),
        .out (encoded_sw)
    );

    always @(posedge clk) begin
        if (restart) begin
            player_input <= 32'h00000000;
            index <= 0;
        end
        else if (index > level) begin
            player_input <= 32'h00000000;
            index <= 0;
            correct <= ((player_input >> (32 - 4*(level+1))) == sequences[level]);
            incorrect <= ((player_input >> (32 - 4*(level+1))) != sequences[level]);
        end
        else if (sw) begin
            player_input <= (encoded_sw << 28) | (player_input >> 4);
            index = index + 1;
        end

        if (correct) begin
            correct <= 0;
        end
        if (incorrect) begin
            incorrect <= 0;
        end
    end

endmodule