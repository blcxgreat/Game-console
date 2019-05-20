module userInput (Clock, reset, in, out); 
   input logic Clock, reset; 
	input logic in; 
   output logic out;
	logic	D1, Q1;
	
	always_ff @(posedge Clock) begin          
      if (reset) begin
				Q1 <= 0;
				out <= 0;                          
		end else begin                                             
				Q1 <= D1;
				out <= Q1;
		end
   end  
	
   always_ff @(posedge Clock) begin          
       if (reset)
			ps <= A;
		else
			ps <= ns;      
   end    
	
	enum {A, B} ps, ns;
	
	always_comb begin
		case (ps)
			A:	if(in) 
			      ns = B;
				else			 
				   ns = A;
					
			B:	if(in) 
			      ns = B;
				else			 
				   ns = A;
		endcase
	end
	
	assign D1 = (ps == A && in);

endmodule 






//module userInput_testbench();
//	logic Clock, reset;
//	logic in, out;
//	userInput dut (.Clock, .in, .out);
//	
//	parameter CLOCK_PERIOD = 100;
//	initial begin
//		Clock <= 0;
//		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
//	end
//	initial begin
//														@(posedge Clock);
//					reset<=1;						@(posedge Clock); 
//					reset<=0; in <= 0; 	@(posedge Clock);     
//														@(posedge Clock);     
//														@(posedge Clock);     
//					in <= 1;					@(posedge Clock);     
//														@(posedge Clock);     
//														@(posedge Clock);     
//														@(posedge Clock);     
//					in <= 0;					@(posedge Clock);     
//														@(posedge Clock);     
//														@(posedge Clock);     
//														@(posedge Clock);
//					in <=1;					@(posedge Clock);     
//					in <= 0;					@(posedge Clock);     
//					in <= 1;					@(posedge Clock);
//					in <= 0;					@(posedge Clock);     
//					in <= 1;					@(posedge Clock);
//					reset<=1;						@(posedge Clock);
//					in <= 0;					@(posedge Clock);     
//														@(posedge Clock);					
//														
//
//      $stop; // End the simulation.  
//   end      
//endmodule