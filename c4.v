module c4(buzzer, led, clkLed, clkIn);
	input clkIn;
	output clkLed;
	output buzzer;
	output led; // beeper led
	
	wire clk;
	wire[6:0] bombTime;
	wire[6:0] timeLeft;
	
	// INSTANTIATIONS
	clkDiv cd(clk, clkLed, clkIn);
	
	counter c(bombTime, timeLeft, clk);
	
	beeper b(buzzer, led, bombTime, timeLeft);

endmodule