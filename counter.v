module counter(clk, time_left, max_time);
	input clk;
	output reg [6:0] time_left;
	output reg [6:0] max_time;
	
	parameter [6:0] BOMB_TIME = 45;
	initial time_left = BOMB_TIME;
	initial max_time = BOMB_TIME; // to be passed to beeper module
	
	always @(posedge clk) 
		time_left = time_left - 1'd1;
	
endmodule