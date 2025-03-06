module tone_generator(
    input clk,
    input enable,
    output sound
    );
    
    // reset once counter hits a certain value
    // that value is decided by whether the user got it correct
    reg [15:0] counter;

    always@(posedge clk) begin
        counter <= counter + 1;
    end

    assign sound = (enable & counter[15]);
endmodule