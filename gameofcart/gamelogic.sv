// Final Project
// This module checks the game condition of adding points and determining game over. 
// If the bird hits the barrier, then the game is over. If it flies through the gap, then
// the score should be incremented by 1.


module gamelogic (clk, reset, user, barrier, add, crash);
	input logic clk, reset;
	// barrier is from the bottom row of the green led array.
	// user is the bird, which is the bottom row of the red led array.
	input logic [7:0] barrier, user;
	output logic add, crash;  // add for increment point, crash denotes game over.
		
	logic [7:0] psb, nsb;
	logic psuser, nsuser;
	
	// result is 1 if the bird crashed on barrier. 
	assign result = user[7] & barrier[7] | user[6] & barrier[6] | user[5] & barrier[5] | user[4] & barrier[4]
				   | user[3] & barrier[3] | user[2] & barrier[2] | user[1] & barrier[1] | user[0] & barrier[0];
	
	always_comb begin
		nsb = barrier;  // always update the new barrier pattern.
		case(psuser)
			1'b0: 
				if (result) // crashed, move to crash state 1'b1
					nsuser = 1'b1;
				else 					
					nsuser = 1'b0;	
			1'b1: 
					nsuser = 1'b1;
		endcase
	end
	
	assign crash = psuser;  // when psuser is 1, crash is also 1. otherwise crash is 0.
	// only checks when psb is blank and next state is not blank. result controls whether to add point.
	assign add = ~result & (~(barrier == 8'b00000000) & (psb == 8'b00000000));	
	
	always @(posedge clk) begin  // at every positive clock edge
		if (reset) begin  // if reset is true
			psuser <= 1'b0;  // set user back to non-crash state
			psb <= 8'b00000000;
		end
		else begin  // otherwise, every ps follows ns.
			psb <= nsb;
			psuser <= nsuser;	
		end
	end	
	
endmodule

module gamelogic_testbench();  // simulation code for gamelogic
	logic clk, reset, add, crash;
	logic [7:0] user, barrier;
	
	gamelogic dut (.clk, .reset, .user, .barrier, .add, .crash);
	
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;  // intially, the clock is 0
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  // clock filps value every half period
	end
	
	initial begin
		reset <= 1;														@(posedge clk);
		reset <= 0;														@(posedge clk);		
		user <= 8'b00000000;	barrier <= 8'b11101111; 		@(posedge clk);
									barrier <= 8'b11101111;			@(posedge clk);
									barrier <= 8'b00000000;			@(posedge clk);
		user <= 8'b00000001;											@(posedge clk);
									barrier <= 8'b11111000;			@(posedge clk);
		user <= 8'b00001000; barrier <= 8'b11111001;			@(posedge clk);
																			@(posedge clk);
																			@(posedge clk);
		$stop;
	end
endmodule
