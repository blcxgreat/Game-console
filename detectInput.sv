// Jinyue Zhu Lab 4
// This module shows the sequential logic of detecting user inputs. This FSM contains 2 states
// and helps maintain the user inputs in the way we want for the game. The user will be given
// a point only if the key is pressed, not continously holding.


module detectInput (out, clk, reset, in);
	
	output logic out;
	input logic clk, reset, in;
	// represents the state where the user has pressed the key
	localparam press = 1'b1;  
	// represents the state where the user has not pressed (released) the key
	localparam Npress = 1'b0;  
	logic ps, ns;  // present state and next state
	
	always_comb begin  // next state logic
		case (ps)  // different cases based on present state
			press: if (in)  // if input is true  
						ns = press;
				    else      
						ns = Npress;
			Npress: if (in)  
						ns = press;
				    else      
						ns = Npress;
		endcase
	end

	assign out = in & ~ps;  // find the pattern that will make output true
	
	always_ff@(posedge clk)  // at every positive edge of the flip-flop
	begin
		if(reset)  // if reset is true
		 ps <= Npress;  // set ps to be Npress at the next clock cycle
	 else 
		 ps <= ns;
	end
	

endmodule

module detectInput_testbench();  // simulation code for detectInput
	logic out, clk, reset, in;

	detectInput dut(.out, .clk, .reset, .in);

	// Set up the clock with period of 100 ps
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
		$stop();
	end
endmodule