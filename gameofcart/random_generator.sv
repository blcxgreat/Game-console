// Final Project
// This module is a 10-bit LFSR that generates random number of 10 bits. The result is used for 
// creating randomness in producing barriers.

module random_generator(out, clk, reset);
	output logic [9:0] out;  // out is a 10-bit number
	input logic clk, reset;
	logic temp;  // temp is the result of inputs getting into the XNOR
	// the inputs to XNOR are selected from the table
	xnor x1 (temp, out[0], out[3]);  
	
	always_ff @(posedge clk)
	begin
		if(reset) // if reset is true
			out <= 10'b0000000100;  
		else 
			// concatenation, push out the LSB while adding the input to the MSB
			out <= {temp, out[9:1]};  
	end	
endmodule

module random_generator_testbench();  // simulation code for random_generator
	logic clk, reset;
	logic [9:0] out;

	random_generator dut(.out, .clk, .reset);

	// Set up the clock with period of 100 ps
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;  // intially, the clock is 0
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  // clock filps value every half period
	end

	// each line represents a clock cycle
	initial begin
		reset <= 1; 		@(posedge clk);
		reset <= 0; 		@(posedge clk);  // intial reset
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