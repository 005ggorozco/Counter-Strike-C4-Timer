module counter(clk, interval);
    input clk;
    //output reg beep = 0;

    parameter [5:0] countdown_t = 45;           // other option is 40s
    localparam [22:0] min_interval = 7_500_000; // 7.5MHz ; minimum interval (50M * 0.15s)

    localparam [25:0] cpld_clk_freq = 50_000_000; // 50 MHz

    reg [5:0] t_left = countdown_t;
    reg [12:0] t_left_percent = 100;      // percentage of time left
    reg [9:0] cs_interval = 100;         // 1s (x100)
    output reg [25:0] interval = cpld_clk_freq * 4'd10; // 1 whole second in terms of cpld clock
    reg [25:0] aux = 0;                  // auxiliary for storing interval calculated

    // handle interval calculation
    always @(posedge clk) begin
        if(t_left != 0) t_left = t_left - 1'b1; // decrement by ONE per clock tick

        t_left_percent = (t_left * 7'd100) / countdown_t;

        cs_interval = ( 1'b1 + 4'd9 * t_left_percent ) / 4'd10;

        // get using cpld clock
        aux = (cpld_clk_freq / 7'd100) * cs_interval;

        interval = (aux > min_interval) ? aux : min_interval;
        
    end

endmodule