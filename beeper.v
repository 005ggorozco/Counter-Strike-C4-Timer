module beeper(buzzer, led, bombTime, timeLeft);
	input[6:0] bombTime;
	input[6:0] timeLeft;
	
	output led;
	output reg buzzer; 
	
	integer F = 50_000_000; // clock frequency 
	integer f; // clock frequency used to represent floating-point numbers
	
	integer interval; // interval between each bomb beep
	integer tLeftPercentage;
	integer x;
	integer minInterval = 15; // (0.15s) the minimum interval 
	
	initial buzzer = 0; // set initial value to zero
	
	// SEQUENTIAL
	always @(timeLeft) begin
	
		// multiply by 100 all floating point numbers
		tLeftPercentage = ( (timeLeft * 100) / bombTime ); // percentage of time remaining
		x = 1000 + (90 * tLeftPercentage);
		
		interval = (x > minInterval) ? (x * F) / 10000 : (minInterval * F) / 100;
		
	end
	
	// OUTPUT
	always #interval buzzer = ~buzzer;
	
	assign led = buzzer;
	
endmodule