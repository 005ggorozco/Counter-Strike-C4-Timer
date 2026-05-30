module counter(clk,cpld_clk,beep);
    input clk;
    input cpld_clk;
    output reg beep = 0;
    wire clk;

    // intervals
    localparam [25:0] I_45 = 50_000_000; localparam [25:0] I_40 = 39_500_000; localparam [25:0] I_35 = 34_500_000;
    localparam [25:0] I_44 = 43_500_000; localparam [25:0] I_39 = 38_500_000; localparam [25:0] I_34 = 33_500_000;
    localparam [25:0] I_43 = 42_500_000; localparam [25:0] I_38 = 37_500_000; localparam [25:0] I_33 = 32_500_000;
    localparam [25:0] I_42 = 41_500_000; localparam [25:0] I_37 = 36_500_000; localparam [25:0] I_32 = 32_000_000;
    localparam [25:0] I_41 = 41_000_000; localparam [25:0] I_36 = 36_000_000; localparam [25:0] I_31 = 30_500_000;

    localparam [25:0] I_30 = 29_500_000; localparam [25:0] I_25 = 24_500_000; localparam [25:0] I_20 = 19_500_000;
    localparam [25:0] I_29 = 28_500_000; localparam [25:0] I_24 = 23_500_000; localparam [25:0] I_19 = 18_500_000;
    localparam [25:0] I_28 = 27_500_000; localparam [25:0] I_23 = 23_000_000; localparam [25:0] I_18 = 18_000_000;
    localparam [25:0] I_27 = 27_000_000; localparam [25:0] I_22 = 21_500_000; localparam [25:0] I_17 = 16_500_000;
    localparam [25:0] I_26 = 25_500_000; localparam [25:0] I_21 = 20_500_000; localparam [25:0] I_16 = 15_500_000;

    localparam [23:0] I_15 = 14_500_000; localparam [25:0] I_10 = 9_500_000;
    localparam [23:0] I_14 = 14_000_000; localparam [25:0] I_9 = 9_000_000;
    localparam [23:0] I_13 = 12_500_000; localparam [25:0] I_min = 7_500_000; // minimum interval
    localparam [23:0] I_12 = 11_500_000;
    localparam [23:0] I_11 = 10_500_000;
    // end of intervals

    localparam [5:0] C4_TIME = 45;
    reg [5:0] t_left = C4_TIME; // time left
    reg [25:0] interval = I_45; // initial value is 50MHz or 1sec

    // counting down logic
    always @(posedge clk) begin
        if(t_left > 0) t_left = t_left - 1'b1;

        // set interval based on current value of time left
        case(t_left) 
            // no 45 as we've already assigned it as the initial value
            44:interval=I_44; 43:interval=I_43; 42:interval=I_42; 41:interval=I_41; 40:interval=I_40; 39:interval=I_39; 
            38:interval=I_38; 37:interval=I_37; 36:interval=I_36; 35:interval=I_35; 34:interval=I_34; 33:interval=I_33; 
            32:interval=I_32; 31:interval=I_31; 30:interval=I_30; 29:interval=I_29; 28:interval=I_28; 27:interval=I_27;
            26:interval=I_26; 25:interval=I_25; 24:interval=I_24; 23:interval=I_23; 22:interval=I_22; 21:interval=I_21;
            20:interval=I_20; 19:interval=I_19; 18:interval=I_18; 17:interval=I_17; 16:interval=I_16; 15:interval=I_15;
            14:interval=I_14; 13:interval=I_13; 12:interval=I_12; 11:interval=I_11; 10:interval=I_10; 9:interval=I_9;
            default:interval=I_min;
        endcase
    end

    localparam [22:0] BEEP_DURATION = 6_250_000;
    reg [25:0] i_ticks = 0;
    reg [22:0] b_ticks = 0;

    // beep logic
    always @(posedge cpld_clk) begin
        if(i_ticks < (interval-1)) i_ticks = i_ticks + 1'b1;
        else beep = 1;

        if(beep == 1) begin
            if(b_ticks < (BEEP_DURATION-1)) b_ticks = b_ticks + 1'b1;
            else begin
                beep = 0;
                i_ticks = 0;
                b_ticks = 0;
            end
        end

    end 
endmodule