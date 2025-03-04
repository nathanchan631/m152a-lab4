module tb;
    
    reg clk;
    reg[15:0] sw;   
    
    wire[15:0] led;
    wire[0:6] seg;
    wire[3:0] digit;
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        sw = 0;

        #10000000 $finish;
    end
    
    basys3 uut_ (
        .clk (clk),
        .sw (sw),
        .led (led),
        .seg (seg),
        .digit (digit)
    );
    
endmodule