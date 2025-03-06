module tb;
    
    reg clk;
    reg[15:0] sw;   
    
    wire[15:0] led;
    wire[0:6] seg;
    wire[3:0] digit;
    
    always #5 clk = ~clk;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end
    
    initial begin
        clk = 0;
        sw = 0;

        #10000000 sw = 16'd512;  // 9
        #1000 sw = 0;

        #10000000 sw = 16'd256;  // 8
        #1000 sw = 0;
        #1000 sw = 16'd2048;  // 11 (b)
        #1000 sw = 0;

        #10000000 sw = 16'd512; 
        #1000 sw = 0;
        
        #10000000 sw = 16'd4;  // 2
        #1000 sw = 0;
        #1000 sw = 16'd1024;  // 10 (a)
        #1000 sw = 0;
        
        #1000 $finish;
    end
    
    basys3 uut_ (
        .clk (clk),
        .sw (sw),
        .led (led),
        .seg (seg),
        .digit (digit)
    );
    
endmodule