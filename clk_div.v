module clk_div(clk_in, clk_out);
	input clk_in;
	output reg clk_out = 0;
	
	localparam [25:0] CPLD_CLK = 50_000_000; 
	parameter period = 1;
	reg [24:0] half_cycle = CPLD_CLK / (period * 25'd2);
	reg [24:0] ticks = 0;

	always @(posedge clk_in) begin
		if(ticks != (half_cycle-1) ) ticks = ticks + 1'b1;
		else begin
			clk_out = !clk_out; // invert
			ticks = 0;          // reset ticks to zero
		end
	end
endmodule