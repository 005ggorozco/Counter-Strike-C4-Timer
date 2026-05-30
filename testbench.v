module testbench;
    reg clk;

    counter dut(
        .clk(clk)
    );

    initial clk = 0;
    always #1 clk = !clk;
endmodule