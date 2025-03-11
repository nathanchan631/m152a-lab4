module tone_generator(
    input clk,
    input correct,
    input incorrect,
    output sound
    );
    
    parameter DIV_CORRECT = (1 << 16);
    parameter DIV_INCORRECT = (1 << 19);
    parameter DIV_PLAYSOUND = 50_000_000;
    
    // reset once counter hits a certain value
    // that value is decided by whether the user got it correct
    reg [32:0] sound_counter = 0;
    reg [32:0] play_counter = 0;
    reg play_enable = 0;
    reg sound_enable = 0;
    reg sound_sel = 0;  // 0 = incorrect, 1 = correct

    always @(posedge clk) begin
        if (correct) begin
            play_enable <= 1;
            sound_sel <= 1;
        end
        if (incorrect) begin
            play_enable <= 1;
            sound_sel <= 0;
        end
        
        if (play_counter == DIV_PLAYSOUND - 1) begin
            play_counter <= 0;
            play_enable <= 0;
            sound_counter <= 0;
            sound_enable <= 0;
        end
        
        if (play_enable) begin
            if (sound_sel) begin
                if (sound_counter == DIV_CORRECT - 1) begin
                    sound_enable <= ~sound_enable;
                    sound_counter <= 0;
                end
                else begin
                    sound_counter <= sound_counter + 1;
                end
            end
            else begin
                if (sound_counter == DIV_INCORRECT - 1) begin
                    sound_enable <= ~sound_enable;
                    sound_counter <= 0;
                end
                else begin
                    sound_counter <= sound_counter + 1;
                end
            end
            
            play_counter <= play_counter + 1;
        end
        else begin
            sound_counter <= 0;
            play_counter <= 0;
        end
    end

    assign sound = (play_enable & sound_enable);

endmodule