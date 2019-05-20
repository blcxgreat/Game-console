// Final Project
// This module shifts the barriers from the row above it to itself.
// It will also change based on the levels given by user input.

module shifter #(parameter WIDTH=2) (clk, reset, gg, in, out);
	input logic clk, reset, gg;  // gg is true when the game is over.
	input logic [7:0] in;  // in is the output of green array display from the row above it.
	output logic [7:0] out;  // out will display the barrier at its row.
		
	logic [WIDTH-1:0] incr = 0; // intentionally used as a sampling period.
	logic [7:0] ps, ns;
	
	always_comb begin
		if(gg)  // if the game is over.
			ns = ps;  // freeze the board.
		else 
			ns = in;  // shifts in.
	end
			
	assign out = ps;  // out is directly related to present state.
	
	always @(posedge clk) begin
		if (reset) begin
			ps <= 8'b00000000;  // default blank state.
			incr <= 0;  // resets the sampling clock.
		end
		else begin
			if (incr == 0) ps <= ns;  // samples when incr completes the cycle.
			incr <= incr + 1; 
		end
	end
endmodule

module shifter_testbench #(parameter WIDTH=2) ();  // test bench for the barrier shifter.
	logic clk, reset, gg;
	logic [7:0] in;
	logic [7:0] out;
	
	shifter dut(.clk, .reset, .gg, .in, .out);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;  // intially, the clock is 0
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  // clock filps value every half period
	end
	
	initial begin
		reset <= 1;											@(posedge clk);
		reset <= 0;											@(posedge clk);
		in <= 8'b10100110;								@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
		in <= 8'b11010101;								@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
		in <= 8'b11010111;								@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
		gg <= 1;		in <= 8'b11011110;				@(posedge clk);  // game is over at this point.
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
	$stop;
	end
endmodule