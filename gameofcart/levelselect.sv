// Final Project
// This module generates barriers at the top row of the led matrix using green lights at certain frequency.
// It will also change based on the levels given by user input.

module levelselect #(parameter WIDTH=2) (clk, reset, gg, in, display, levelSW);
	input logic clk, reset, gg;
	input logic [8:0] levelSW;  // SW8 to 0.
	input logic [2:0] in;  // input is a 3-bit number dissected from the 10 bit output from LFSR_10.
	output logic [7:0] display;  // output will be displayed as a row on led matrix.
	
	logic [WIDTH - 1: 0] incr;  // intentionally set to control sampling period.
	logic temp = 1'b0;	// used to create gaps between new barriers.
	logic [7:0] ps, ns;

	// levels that represented by input SW patterns.
	localparam level0 = 9'b000000000;
	localparam level1 = 9'b000000001;
	localparam level2 = 9'b000000010;
	localparam level3 = 9'b000000100;
	localparam level4 = 9'b000001000;
	localparam level5 = 9'b000010000;
	localparam level6 = 9'b000100000;
	localparam level7 = 9'b001000000;
	localparam level8 = 9'b010000000;
	localparam level9 = 9'b100000000;
												
	always_comb begin
		if (gg)  // if the game is over
			ns = ps;  // freeze the board
		else if (temp == 0)  // select a new pattern to display as the barrier
			case(levelSW)  // based on difficulty
				level0:
					case(in)    // 8 bit number represents the barrier
						3'b000:	ns = 8'b10000001;
						3'b001:	ns = 8'b01000010;
						3'b010:	ns = 8'b00100100;
						3'b011:	ns = 8'b00011000;
						3'b100:	ns = 8'b10000010;
						3'b101:	ns = 8'b01000001;
						3'b110:	ns = 8'b00101000;
						3'b111:	ns = 8'b00010010; 
						default:	ns = 8'b00000000;
					endcase
				level1:
					case(in)
						3'b000:	ns = 8'b11000001;
						3'b001:	ns = 8'b10100101;
						3'b010:	ns = 8'b10011001;
						3'b011:	ns = 8'b01101000;
						3'b100:	ns = 8'b00111000;
						3'b101:	ns = 8'b00011100;
						3'b110:	ns = 8'b01010001;
						3'b111:	ns = 8'b00101010; 
						default:	ns = 8'b00000000;
					endcase	
				level2:
					case(in)
						3'b000:	ns = 8'b11000011;
						3'b001:	ns = 8'b10100011;
						3'b010:	ns = 8'b10011001;
						3'b011:	ns = 8'b01101000;
						3'b100:	ns = 8'b00110100;
						3'b101:	ns = 8'b00001101;
						3'b110:	ns = 8'b00010101;
						3'b111:	ns = 8'b10100010; 
						default:	ns = 8'b00000000;
					endcase	
				level3:
					case(in)
						3'b000:	ns = 8'b11000111;
						3'b001:	ns = 8'b11100011;
						3'b010:	ns = 8'b10011011;
						3'b011:	ns = 8'b01101001;
						3'b100:	ns = 8'b00101101;
						3'b101:	ns = 8'b00011111;
						3'b110:	ns = 8'b01010101;
						3'b111:	ns = 8'b10101010; 
						default:	ns = 8'b00000000;
					endcase
				level4:
					case(in)
						3'b000:	ns = 8'b10100111;
						3'b001:	ns = 8'b01100111;
						3'b010:	ns = 8'b10010110;
						3'b011:	ns = 8'b01011011;
						3'b100:	ns = 8'b10111101;
						3'b101:	ns = 8'b01011111;
						3'b110:	ns = 8'b11010101;
						3'b111:	ns = 8'b10101011; 
						default:	ns = 8'b00000000;
					endcase
				level5:
					case(in)
						3'b000:	ns = 8'b10110111;
						3'b001:	ns = 8'b11101010;
						3'b010:	ns = 8'b10101001;
						3'b011:	ns = 8'b01101001;
						3'b100:	ns = 8'b10101011;
						3'b101:	ns = 8'b11010101;
						3'b110:	ns = 8'b10110110;
						3'b111:	ns = 8'b01101010; 
						default:	ns = 8'b00000000;
					endcase
				level6:
					case(in)
						3'b000:	ns = 8'b01111100;
						3'b001:	ns = 8'b01101110;
						3'b010:	ns = 8'b10101101;
						3'b011:	ns = 8'b01011101;
						3'b100:	ns = 8'b00111110;
						3'b101:	ns = 8'b11010101;
						3'b110:	ns = 8'b11110010;
						3'b111:	ns = 8'b10110110; 
						default:	ns = 8'b00000000;
					endcase
				level7:
					case(in)
						3'b000:	ns = 8'b01110110;
						3'b001:	ns = 8'b01111110;
						3'b010:	ns = 8'b10101111;
						3'b011:	ns = 8'b01101101;
						3'b100:	ns = 8'b00111110;
						3'b101:	ns = 8'b11011101;
						3'b110:	ns = 8'b11110011;
						3'b111:	ns = 8'b10110110; 
						default:	ns = 8'b00000000;
					endcase
				level8:
					case(in)
						3'b000:	ns = 8'b01111110;
						3'b001:	ns = 8'b11010111;
						3'b010:	ns = 8'b11101110;
						3'b011:	ns = 8'b01110111;
						3'b100:	ns = 8'b10111110;
						3'b101:	ns = 8'b11010111;
						3'b110:	ns = 8'b11110011;
						3'b111:	ns = 8'b10110110; 
						default:	ns = 8'b00000000;
					endcase
				level9:
					case(in)
						3'b000:	ns = 8'b11111110;
						3'b001:	ns = 8'b01111111;
						3'b010:	ns = 8'b11011111;
						3'b011:	ns = 8'b11110111;
						3'b100:	ns = 8'b11101111;
						3'b101:	ns = 8'b11111011;
						3'b110:	ns = 8'b11111101;
						3'b111:	ns = 8'b10111111; 
						default:	ns = 8'b00000000;
					endcase
				default:
					case(in)
						3'b000:	ns = 8'b10000001;
						3'b001:	ns = 8'b01000010;
						3'b010:	ns = 8'b00100100;
						3'b011:	ns = 8'b00011000;
						3'b100:	ns = 8'b10000010;
						3'b101:	ns = 8'b01000001;
						3'b110:	ns = 8'b00101000;
						3'b111:	ns = 8'b00010010; 
						default:	ns = 8'b00000000;	
					endcase
			endcase
		else  // if temp is not 0, then just create an empty barrier.
				// so that the game is more appealing and playable.
			ns = 8'b00000000;	
	end
		
				
	assign display = ps;
		
	always @(posedge clk) begin
		if (reset) begin
			incr <= 0;  // reset the sampling clock.
			temp <= 1'b0;  // change temp back to 0 at next clock edge.
			ps <= 8'b00000000;	
		end
		else begin
			// follows new pattern at every sampling period.
			if (incr == 0) begin 
			temp <= temp + 1'b1;  // flip the temp to generate blank or barrier.
			ps <= ns;
			end
			incr <= incr + 1;
		end
	end
	
endmodule

module r_testbench #(parameter WIDTH=2) ();  // testbench for the barrier generator
	logic clk, reset, gg;
	logic [8:0] levelSW;
	logic [2:0] in;
	logic [7:0] display;
	
	generator dut (.clk, .reset, .gg, .in, .display, .levelSW);
	
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;  // intially, the clock is 0
		forever #(CLOCK_PERIOD/2) clk <= ~clk;  // clock filps value every half period
	end
	
	initial begin
		reset <= 1;											@(posedge clk);
		reset <= 0;											@(posedge clk);
	   levelSW <= 9'b000000000; in <= 3'b000;		@(posedge clk);  // suppose current level is 0.
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
										 in <= 3'b001;		@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
										 in <= 3'b010;		@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
									    in <= 3'b011;		@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
										 in <= 3'b100;		@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
									    in <= 3'b101;		@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
						gg <= 1;		 in <= 3'b110;		@(posedge clk);   // game is over at this point.
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
																@(posedge clk);
		$stop;
	end
endmodule
