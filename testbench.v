

module testbench;
	reg clkIn;
	wire clkLed;
	wire buzzer;
	wire led; // beeper led
	
	c4 dut(buzzer, led, clkLed, clkIn);
	
	initial clkIn = 0;
	always #1 clkIn = ~clkIn;
	
	initial begin
		
	end
	
endmodule



/*
// TESTBENCH FOR COUNTER
module testbench;
	reg clk;
	wire[6:0] bombTime; // this is a reg because we will assign it the value of 't' and connect it to 'beeper'
	wire[6:0] timeLeft;
	
	counter dut(bombTime, timeLeft, clk);
	
	initial clk = 0;
	always #1 clk = ~clk;
	
endmodule
*/


/*
// TESTBENCH FOR BEEPER
module testbench;
	reg[6:0] bombTime;
	reg[6:0] timeLeft;
	
	wire led;
	wire buzzer; 
	
	beeper dut(buzzer, led, bombTime, timeLeft);
endmodule
*/