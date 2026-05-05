module clkDiv(clkOut, clkLed, clkIn);
	input clkIn;
	output reg clkOut = 0;
	output reg clkLed = 0; // led indicator for clock pulses
	
	parameter integer TICKS = 2;
	parameter integer FREQUENCY = 1;
	
	integer halfCycle = TICKS / (2 * FREQUENCY);
	
	integer ticksPassed = 0;
	
	always @(clkIn) begin
		ticksPassed <= ticksPassed + 1; // increment
		
		if(ticksPassed == TICKS) begin
			clkOut <= ~clkOut;
			clkLed <= ~clkOut;
			
			ticksPassed <= 0; // reset 
		end
		
	end

endmodule