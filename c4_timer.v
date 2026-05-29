module c4_timer(cpld_clk,beep);
    input cpld_clk;
    wire clk_out;
    wire [25:0] interval;
    output beep;
    
    counter cntr(
        .clk(clk_out), 
        .interval(interval)
    );

    beeper bpr(
        .cpld_clk(cpld_clk),
        .interval(interval),
        .beep(beep)
    );

    clk_div divider(
        .clk_in(cpld_clk),
        .clk_out(clk_out)
    );
endmodule 