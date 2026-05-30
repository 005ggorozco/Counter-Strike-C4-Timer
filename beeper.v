module beeper(cpld_clk,interval,t_left,beep);
    input cpld_clk;
    input [25:0] interval;
    input [5:0] t_left;
    output reg beep = 0;

    reg [25:0] i_ticks = 0;                      // interval ticks
    reg [22:0] b_ticks = 0;                      // beep ticks
    localparam [22:0] beep_duration = 6_250_000; // 125ms (50MHz * 0.125s)

    always @(posedge cpld_clk) begin 
        if(i_ticks < (interval-1) && t_left > 0) i_ticks = i_ticks + 1'b1;
        else if(beep == 0) beep = 1;

        // if beep is true,
        if(beep) begin
            if(b_ticks < (beep_duration-1)) b_ticks = b_ticks + 1'b1;
            else begin
                beep = 0; // reset all to ZERO
                i_ticks = 0;
                b_ticks = 0;
            end
        end

    end 
endmodule