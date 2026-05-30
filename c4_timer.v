module c4_timer(cpld_clk,beep);
    input cpld_clk;
    output beep;
    wire clk_out;

    counter cntr(
        .clk(clk_out),
        .cpld_clk(cpld_clk),
        .beep(beep)
    );

    clk_div cd(
        .clk_in(cpld_clk),
        .clk_out(clk_out)
    );
endmodule