module position (Clock, reset, gameover, L, R, U, D, hit_own_body, hit_score, head_position, green_array, score_array); 
   input logic Clock, reset, L, R, U, D;
	input logic [7:0] [7:0] green_array, score_array;
	output logic hit_own_body, hit_score, gameover;
	output logic [7:0] [7:0] head_position;
	integer r, c, i;

	always_ff @(posedge Clock) begin          
      if (reset) begin
			r <= 3;
			c <= 5;
			hit_own_body <=0;
			hit_score <= 0;
			gameover <=0;
			for (i=0; i<=7; i=i+1) 
			   head_position[i] <= 2'b00;
			head_position[3][5] <= 1;
		end else if (L) begin
            if (green_array[r][c+1]) begin
					hit_own_body <= 1;
					gameover <= 1;
				end else if ((score_array[r][c+1]) | (c == 7 && score_array[r][0])) begin
					hit_score <=1;
					head_position [r] [c] <= 0;
					c <= c + 1;
					if (c == 7) begin
					   head_position [r] [0] <= 1;
			         c <= 0;
			      end else 			
					   head_position [r] [c+1] <= 1;
				end else begin
					head_position [r] [c] <= 0;
					c <= c + 1;
					if (c == 7) begin
					   head_position [r] [0] <= 1;
			         c <= 0;
			      end else 			
					   head_position [r] [c+1] <= 1;
				end
		end else if (R) begin
            if (green_array[r][c-1]) begin
					hit_own_body <= 1;
					gameover <= 1;
				end else if ((score_array[r][c-1]) | (c == 0 && score_array[r][7])) begin
					hit_score <=1;
					head_position [r] [c] <= 0;
					c <= c - 1;
					if (c == 0) begin
					   head_position [r] [7] <= 1;
				      c <= 7;
				   end else 		
					   head_position [r] [c-1] <= 1;
				end else begin
					head_position [r] [c] <= 0;
					c <= c - 1; 
					if (c == 0) begin
					   head_position [r] [7] <= 1;
				      c <= 7;
				   end else 		
					   head_position [r] [c-1] <= 1;
				end
		end else if (U) begin
            if (green_array[r+1][c]) begin
					hit_own_body <= 1;
					gameover <=1;
				end else if ((score_array[r+1][c])| (r == 7 && score_array[0][c])) begin
					hit_score <=1;
					head_position [r] [c] <= 0;
					r <= r + 1;
					if (r == 7) begin
					   head_position [0] [c] <= 1;
					   r <= 0;
					end else 
					   head_position [r+1] [c] <= 1;
				end else begin
					head_position [r] [c] <= 0;
					r <= r + 1;
					if (r == 7) begin
					   head_position [0] [c] <= 1;
					   r <= 0;
					end else 
					   head_position [r+1] [c] <= 1;
				end
		end else if (D) begin
            if (green_array[r-1][c]) begin
					hit_own_body <= 1;
					gameover <= 1;
				end else if ((score_array[r-1][c]) | (r == 0 && score_array[7][c])) begin
					hit_score <=1;
					head_position [r] [c] <= 0;
					r <= r - 1;
					if (r == 0) begin
					   head_position [7] [c] <= 1;
						r <= 7;
					end else 
					   head_position [r-1] [c] <= 1;
				end else begin
					head_position [r] [c] <= 0;
					r <= r - 1;
					if (r == 0) begin
					   head_position [7] [c] <= 1;
						r <= 7;
					end else 
					   head_position [r-1] [c] <= 1;
				end
		end else
			hit_score <= 0;
   end      
endmodule





//module position_testbench();
//	logic Clock, reset; 
//	logic L, R, U, D;
//	logic hit_own_body, gameover;
//	logic [7:0] [7:0] head_position, green_array;
//	position dut (.Clock, .reset, .gameover, .L, .R, .U, .D, .hit_own_body, .head_position, .green_array);
//	integer i;
//	parameter CLOCK_PERIOD = 100;
//	initial begin
//		Clock <= 0;
//		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;	
//	end
//	initial begin
//		for (i=0; i<8; i=i+1)
//			green_array[i] <= 2'b00;
//		end
//
//	initial begin
//														@(posedge Clock);
//					reset<=1;						@(posedge Clock); 
//					reset<=0; L<=0; R<=0; U<=0; D<=0; green_array[3][4] <= 1; @(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//					R<=1;								@(posedge Clock);
//					R<=0;								@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//		$stop; // End the simulation.  
//   end      
//endmodule
//					
//					
