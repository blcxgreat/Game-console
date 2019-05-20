module matrix_single (Clock, reset, tracking, gameover, L, R, U, D, NL, NR, NU, ND, snake_length, hit_score, lightOn); 
   input logic Clock, reset; 
	input logic L, R, U, D, NL, NR, NU, ND;
	input logic tracking, gameover, hit_score;
	input logic [5:0] snake_length;
	output logic lightOn;
	
	logic [5:0] counter;
  
   always_ff @(posedge Clock) begin
		if(~reset) begin
			if((ps == Off) && (ns == On))
			   counter <= snake_length;
		   else if ((counter != 6'b000000) & tracking & ~gameover)
			counter <= counter - 6'b000001;
			else if (hit_score) begin
            counter <= counter;
			end
		end else 
		   counter <= 6'b000000;
   end
  
	enum {Off, On} ps, ns;

	always_ff @(posedge Clock) begin          
       if (reset)
			ps <= Off;
		else
			ps <= ns;      
   end 
	
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
	
	
	
	
	
	
	
	
	
//module matrix_single_testbench();
//	logic Clock, reset; 
//	logic L, R, U, D, NL, NR, NU, ND;
//	logic [5:0] snake_length;
//	logic lightOn, hit_score, gameover, tracking;
//	matrix_single dut (.Clock, .reset, .tracking, .gameover, .L, .R, .U, .D, .NL, .NR, .NU, .ND, .snake_length, .hit_score, .lightOn);
//	
//	parameter CLOCK_PERIOD = 100;
//	initial begin
//		snake_length <= 6'b000010;
//		Clock <= 0;
//		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
//	end
//	initial begin
//																@(posedge Clock);
//		reset <= 1; 										@(posedge Clock);     
//		reset <= 0; NL<=0; NR<=0; NU<=0; ND<=0; L<=0; R<= 0; U<=0; D<=0;		@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//		R<=1;													@(posedge Clock);
//		R<=0; NL<=1;										@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//																@(posedge Clock);
//		R<=1;													@(posedge Clock);
//		R<=0; NL<=0;										@(posedge Clock);
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
