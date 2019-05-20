module matrix_center (Clock, reset, tracking, gameover, L, R, U, D, NL, NR, NU, ND, snake_length, hit_score, lightOn); 
   input logic Clock, reset; 
	input logic L, R, U, D, NL, NR, NU, ND;
	input logic tracking, gameover, hit_score;
	input logic [5:0] snake_length;
	output logic lightOn;
	
	logic [5:0] counter;
	logic start;
	
	always_ff @(posedge Clock) begin
		if(reset)
			start <= 1;
		else if (start & (L|R|U|D)) begin
			start <= 0;
			counter <= 6'b000000;
			end			
		if(reset) 
			counter <= 6'b000001;
		else if((ps == Off) && (ns == On))
			counter <= snake_length;
		else if (hit_score) begin
		
		end
		else if ((counter != 6'b000000) & (~start & tracking & ~gameover))
			counter <= counter - 6'b000001;
	end
	
	always_ff @(posedge Clock) begin          
      if (reset)
			ps <= On;
		else
			ps <= ns;      
   end     	

	enum { On, Off} ps, ns;
	
	always_comb begin
		case (ps)
			Off:	if(NL&R | NR&L | NU&D | ND&U)		ns = On;
					else										ns = Off;
			
			On:	if(counter == 6'b000000) 			ns = Off;
					else			 							ns = On;	
		endcase
	end
	
	assign lightOn = (ps == On);
	 
endmodule 
	
	
	
	
	
	
	
	
	
	
//module matrix_center_testbench();
//	logic Clock, reset; 
//	logic L, R, U, D, NL, NR, NU, ND;
//	logic [5:0] snake_length;
//	logic lightOn;
//	logic tracking, hit_score;
//	matrix_center dut (.Clock, .reset, .tracking, .L, .R, .U, .D, .NL, .NR, .NU, .ND, .snake_length, .hit_score, .lightOn);
//	
//	parameter CLOCK_PERIOD = 100;
//	initial begin
//		snake_length <= 6'b000001;
//		Clock <= 0;
//		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
//	end
//	initial begin
//																@(posedge Clock);
//		reset <= 1; NL<=0; NR<=0; NU<=0; ND<=0; L<=0; R<= 0; U<=0; D<=0; tracking<=0; 	@(posedge Clock);									    
//																@(posedge Clock);
//		reset <= 0; 										@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//		R<=1; tracking<=1; 								@(posedge Clock);
//		R<=0; NR<=1; tracking<=0; 					@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//		L<=1;	tracking<=1; 								@(posedge Clock);
//		L<=0; NR<=0; tracking<=0; 					@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//		U<=1;													@(posedge Clock);
//		U<=0; NU<=1;										@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//		reset<=1;											@(posedge Clock);
//		reset<=0;											@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//      $stop; // End the simulation.  
//   end      
//endmodule
