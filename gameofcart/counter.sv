// Final Project
// This module shows the sequential logic of a 4-bit counter. In charge of keeping the score of player, the
// counter will increment its value everytime the bird passes through a pipe. It will counts up to 999.

// parameter indicates that this is a 4-bit counter
module counter #(parameter WIDTH = 4) (HEX, cycle, in, clk, reset);  
	// input in is the output from winDisplay, it indicates who wins the round
	input logic in, clk, reset;  
	logic [WIDTH - 1:0] out;
	output logic [6:0] HEX;
	output logic cycle;  // functions as cout in the fulladder;
	
	always_ff@(posedge clk) 
	begin
		if (reset)  // recount from 0 if reset is pressed
			out <= 4'b0000;
		else if (in)
			if (out == 4'b1001)  // stops when it reaches decimal 9 based on the need of the game.
				out <= 4'b0000;
			else
				out <= out + 1;
		else 
			out <= out;  // hold the value
	end
	
	// similar to the carry in logic of the full adder.
	assign cycle = (out == 4'b1001) & in;
	
	seg7 display (.bcd(out), .leds(HEX));  // hook up the 7-segment display with the counter.
	
endmodule


module counter_testbench #(parameter WIDTH = 4) ();  // simulation code for counter
	logic in, clk, reset, cycle;
	logic [6:0] HEX;

	counter dut (.HEX, .cycle, .in, .clk, .reset);

	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;  // intially, the clock is 0
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  // clock filps value every half period
	end

	// each line represents a clock cycle
	initial begin
		reset <= 1; 	@(posedge clk);
		reset <= 0; 	@(posedge clk);  // intial reset
		in <= 1; 		@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
		in <= 0; 		@(posedge clk);
							@(posedge clk);
							@(posedge clk);
		in <= 1; 		@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);
							@(posedge clk);	
							@(posedge clk);
							@(posedge clk);							
		$stop();
	end
	
endmodule
