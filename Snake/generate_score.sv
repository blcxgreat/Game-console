module generate_score (Clock, reset, hit_score, score_array, green_array, snake_length, winGame);
	input logic Clock, reset, hit_score;
	input logic [7:0] [7:0] green_array;
	output logic [5:0] snake_length;
	output logic winGame;
	output logic [7:0] [7:0] score_array;
	logic [4:0] Count;
	logic avalible, close_Score, new_score;
	
	integer r, c, i;
	
	always_ff @(posedge Clock)
		if(reset)
			snake_length <= 6'b0000010;
		else if(hit_score)
         snake_length <= snake_length + 6'b0000001;
	
	always_ff @(posedge Clock) begin          
      if (reset) begin
			for (i=0; i<=7; i=i+1) 
			   score_array[i] <= 2'b00;
			score_array[3][2] <= 1;
			Count <= 5'b00000;
			avalible <= 0;
			r <= 3;
			c <= 2;
			winGame <=0;
			new_score <=0;
			close_Score <= 1;
		end else if (snake_length == 6'b111111 && hit_score)
			winGame <= 1;
		else if ((green_array[r][c] && new_score) | avalible) begin
			if (r == 7 && c == 7) begin
				c <= 0;
				r <= 0;
			end else if (c == 7) begin
				c <= 0;
				r <= r + 1;
			end else
				c <= c + 1;
		end else if (~green_array[r][c] && new_score) begin
			avalible <=1;
			Count <= Count + 5'b00001;
			if ((Count == 5'b01100 && close_Score) | Count == 5'b11100) begin
			   Count <= Count;
			end else if (r == 7 && c == 7) begin
				c <= 0;
				r <= 0;
			end else if (c == 7) begin
				c <= 0;
				r <= r + 1;
			end else
				c <= c + 1;
		end else if ((Count == 5'b01101 && close_Score) | Count == 5'b11101) begin
			score_array[r][c] <= 1;
			Count <= 5'b00000;			
			new_score <= 0;
			avalible <= 0;
			close_Score <= ~close_Score;
		end else if (hit_score) begin
			new_score <= 1;
			for (i=0; i<=7; i=i+1) 
			   score_array[i] <= 2'b00;
			Count <= 5'b00000;
			avalible <= 0;
		end
	end

endmodule




module display_score (Clock, reset, hit_score, digit_1, digit_10);
   input logic Clock, reset;
   input logic hit_score;
	output logic [3:0] digit_1, digit_10;
	
	always_ff @(posedge Clock) begin          
      if (reset) begin
			digit_1 <= 4'b0000;
			digit_10 <= 4'b0000;
		end
		else if (hit_score) begin
			if (digit_1 == 4'b1001) begin
				digit_10 <= digit_10 + 4'b0001;
				digit_1 <= 4'b0000;
			end
			else
				digit_1 <= digit_1 + 4'b0001;
		end
   end

endmodule 








//module generate_score_testbench();
//	logic Clock, reset;
//	logic hit_score;
//	logic [7:0] [7:0] green_array;
//	logic [5:0] snake_length;
//	logic winGame;
//	logic [7:0] [7:0] score_array;
//	generate_score dut (.Clock, .reset, .hit_score, .score_array, .green_array, .snake_length, .winGame);
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
//					reset<=0; green_array[3][4] <= 1; @(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//					hit_score<=1;					@(posedge Clock);
//					hit_score<=0;					@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//								
//		$stop; // End the simulation.  
//   end      
//endmodule