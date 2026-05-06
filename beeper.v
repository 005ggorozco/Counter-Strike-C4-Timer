module beeper(bp_time_left, bp_max_time, cpld_clk, beep);
	input [6:0] bp_time_left;
	input [6:0] bp_max_time; // get max time from counter module
	input cpld_clk;
	output reg beep;
	
	// initialize values
	initial beep = 0;
	
	localparam [25:0] CLK_HZ = 50_000_000;
	
	reg [32:0] interval = 50_000_000;   // max val = 100 * CLK_HZ, default value equivalent to CLK_HZ
	localparam [3:0] MIN_INTERVAL = 15; // minimum interval
	reg [6:0] i_formula;                // 7-bits since it can store values up to 100
	
	// INTERVAL CALCULATOR
	always @(bp_time_left) begin
		i_formula = (100 + 9 * ((bp_time_left * 100) / bp_max_time)) / 10;
		
		if (i_formula > MIN_INTERVAL)
			interval = (i_formula * CLK_HZ) / 100;
		else 
			interval = (MIN_INTERVAL * CLK_HZ) / 100;
		
	end
	
	reg on_time = 6_250_000; // duration of each pulse
	reg [25:0] ticks_passed = 0;
	
	// BEEP
	always @(cpld_clk) begin
		if (beep == 0) begin // if beep is off (this is the time during interval)
			ticks_passed = ticks_passed + 1;
			
			if (ticks_passed == interval) begin
				beep = !beep; // toggle beep_mode
				ticks_passed = 0;       // reset value to zero
				
			end // inner if
		end    // outer if
		
		else begin // if beep is 1 (on)
			ticks_passed = ticks_passed + 1;
		
			if (ticks_passed == on_time) begin
				beep = !beep; // toggle beep_mode
				ticks_passed = 0;       // reset value to zero
				
			end // inner if
		end    // else
	end       // always block

endmodule