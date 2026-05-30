module c4_timer(cpld_clk,beep);
    input cpld_clk;
    wire clk_out;
    wire [25:0] interval;
    wire [5:0] t_left;
    output beep;
    
    counter cntr(
        .clk(clk_out), 
        .interval(interval),
        .t_left(t_left)
    );

    beeper bpr(
        .cpld_clk(cpld_clk),
        .interval(interval),
        .t_left(t_left),
        .beep(beep)
    );

    clk_div divider(
        .clk_in(cpld_clk),
        .clk_out(clk_out)
    );
endmodule 