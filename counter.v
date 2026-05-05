module counter(bombTime, timeLeft, clk);
	input clk;
	output reg[6:0] bombTime; // this is a reg because we will assign it the value of 't' and connect it to 'beeper'
	output[6:0] timeLeft;
	
	parameter T = 45; // time
	integer s = T; // 32-bit by default
	
	// SEQUENTIAL
	always @(posedge clk) begin
		s = s - 1;
	end
	
	// OUTPUT
	initial bombTime = T;
	assign timeLeft = s;
	
endmodule