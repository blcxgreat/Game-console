// Final Project
// This module wipes out the playfield for the player per game for one time.

module bomb (in, clk, reset, out, swipe);
	input logic clk, reset, in;
	output logic out;  // link to LEDR0
	output logic swipe;  // link to barrier's reset
	
	logic ps, ns;
	
	localparam one = 1'b1;
	localparam zero = 1'b0;	
	
	always_comb begin
		case(ps)
			one: if (in) ns = zero;  // no more bombs
					 else ns = one;	
			zero: ns = zero;  // stays there	
		endcase	
	end
	
	always_ff@(posedge clk) begin
		if (reset) begin
			ps <= one;  // restart with one bomb
			out <= 0;
		end else begin
			ps <= ns;
			out <= ps;
		end
	end
	
	assign swipe = (ps != ns);  // swipe logic	
endmodule



module bomb_testbench();  // simulation code for bomb
	logic clk, reset, in;
	logic out;
	logic swipe;

	bomb dut(.in, .clk, .reset, .out, .swipe);

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
		in <= 0; 		@(posedge clk);
							@(posedge clk);
		in <= 1; 		@(posedge clk);
							@(posedge clk);						
		$stop();
	end
	
endmodule

