module counter(clk,interval,t_left);
    input clk;

    parameter [5:0] countdown_t = 45;           // other option is 40s
    localparam [22:0] min_interval = 7_500_000; // 7.5MHz ; minimum interval (50M * 0.15s)

    localparam [25:0] cpld_clk_freq = 50_000_000; // 50 MHz

    output reg [5:0] t_left = countdown_t;
    reg [9:0] cs_interval = 89;                 // value taken from simulation
    output reg [25:0] interval = cpld_clk_freq; // 1 whole second in terms of cpld clock

    // handle interval calculation
    always @(posedge clk) begin
        if(t_left > 0) t_left = t_left - 1'b1; // decrement by ONE per clock tick

        cs_interval = cs_interval - 2'd2;

        /* if(t_left > 8) interval = (cpld_clk_freq / 7'd100) * cs_interval;
        else interval = min_interval; */

        interval = (cpld_clk_freq / 7'd100) * cs_interval;
        
    end
endmodule