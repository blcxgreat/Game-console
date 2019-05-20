// Final Project
// This module shows the sequential logic for displaying the cart on the first row in the LED matrix. 
// This FSM contains 10 states that the cart pattern could possibly be. The cart is represented by a red light,
// and will change its' position based on user input.

// parameter used to adjust the sampling period
module cart #(parameter WIDTH=2) (out, clk, reset, inL, inR, gg); 
	
	// clk denotes clock while reset is used to set circuit to a particulat state
	// if inL is true, the cart will move one spot to the left. If inR is true, then move one spot to the right.
	// if gameover, then the cart will disappear.
	input logic clk, reset, inL, inR, gg;  
	output logic [7:0] out;  // all LEDRs are outputs, and LEDR0 is always off	
	logic [WIDTH - 1 : 0] incr;  // intentionally choose the sampling period
	logic [7:0] ps;  // present state are 10-bit sequences
	logic [7:0] ns;  // next state are 10-bit sequences 

	localparam OFF = 8'b00000000;
	localparam up3 = 8'b10000000;
	localparam up2 = 8'b01000000;
	localparam up1 = 8'b00100000;
	localparam start = 8'b00010000;
	localparam down1 = 8'b00001000;
	localparam down2 = 8'b00000100;
	localparam down3 = 8'b00000010;
	localparam down4 = 8'b00000001;
	// the states are depicted as:
	// up3 - up2 - up1 - start - down1 - down2 - down3 - down4
	
   // to add flexibility, the cart can move from up3 to down 4 by moving left.
	// the cart can also move from down4 to up3 by moving right.
	always_comb
	begin
		case(ps) 
			OFF:  // once died, just remain diseappered
				ns = OFF;
			up3:
				if (inL & ~inR)
					ns = down4;  // cycle to down4
				else if (~inL & inR)
					ns = up2;
				else // two buttons pressed simultanously or both not pressed
					ns = up3; // remain at that state
			up2:
				if (inL & ~inR)
					ns = up3;
				else if (~inL & inR)
					ns = up1;
				else
					ns = up2;					
			up1:
				if (inL & ~inR)
					ns = up2;
				else if (~inL & inR)
					ns = start;
				else
					ns = up1;	
			start:
				if (inL & ~inR)
					ns = up1;
				else if (~inL & inR)
					ns = down1;
				else
					ns = start;								
			down1:
				if (inL & ~inR)
					ns = start;
				else if (~inL & inR)
					ns = down2;
				else
					ns = down1;					
			down2:  
				if (inL & ~inR)
					ns = down1;
				else if (~inL & inR)
					ns = down3;
				else
					ns = down2;	
			down3:
				if (inL & ~inR)
					ns = down2;
				else if (~inL & inR)
					ns = down4;
				else
					ns = down3;						
			down4:  
				if (inL & ~inR)
					ns = down3;
				else if (~inL & inR)
					ns = up3;  // cycle to up3
				else
					ns = down4;			
		endcase
	end
		
	assign out = ps;  // It turned out output pattern is directly related to ps
					
	always_ff @(posedge clk)  // at every positive edge of the flip-flop
	begin
		if(reset) begin  // if reset is true
			ps <= start; //set the circuit back to start.
			incr <= 0;
		end
		else if (gg) begin  // game is over
			ps <= OFF;
			incr <= 0;
		end
		else begin
			//only changes pattern every time incr goes through a full cycle
			if (incr == 0) ps <= ns; 
			incr <= incr + 1;
		end
	end
	
endmodule

module cart_testbench #(parameter WIDTH=2) ();  // simulation code for cart
	logic [7:0] out;
	logic clk, reset, inL, inR, gg;

	cart dut(.out, .clk, .reset, .inL, .inR, .gg);
	
	// Set up the clock with period of 100 ps
	parameter CLOCK_PERIOD=100;
		initial begin
		clk <= 0;  // intially, the clock is 0
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  // clock filps value every half period
	end

	// each line represents a clock cycle
	initial begin
		reset <= 1;						@(posedge clk);
		reset <= 0;						@(posedge clk);  // initial reset
											@(posedge clk);
		inL <= 1; inR <= 0;			@(posedge clk);
		inL <= 1; inR <= 1;			@(posedge clk);
	   inL <= 1; inR <= 0;			@(posedge clk);
		inL <= 1; inR <= 0;			@(posedge clk);
		inL <= 1; inR <= 0;			@(posedge clk);
		inL <= 1; inR <= 0;			@(posedge clk);
		inL <= 1; inR <= 0;			@(posedge clk);
		inL <= 1; inR <= 0;			@(posedge clk);
		inR <= 1; inR <= 0;			@(posedge clk);
											@(posedge clk);
		gg <= 1;							@(posedge clk);
											@(posedge clk);
		$stop; // simulation stops
	end
endmodule 
	