module testbench;
    reg clk;
    wire [25:0] interval;

    counter dut(
        .clk(clk),
        .interval(interval)
    );

    initial clk = 0;
    always #1 clk = !clk;

    
endmodule