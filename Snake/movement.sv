module movement (Clock, reset, count, LEFT, RIGHT, UP, DOWN, L, R, U, D, tracking, gameover);
	input logic Clock, reset;
	input logic LEFT, RIGHT, UP, DOWN;
	input logic gameover;
	output logic L, R, U, D;
	output logic tracking;
	input reg [2:0] count;
	logic [9:0] current_Move;
	logic track_num;
	
	always_ff @(posedge Clock) begin          
      if (~reset) begin
			tracking <= track_num;
			if (current_Move == 10'b1011111011)
				current_Move <= 10'b0000000000;
			else if (count == 3'b111)
				current_Move <= current_Move + 10'b0000000001;
			end
		else begin
		   tracking <= 0;
			current_Move <= 10'b0000000000;
		end
   end
	
	always_ff @(posedge Clock) begin          
      if (reset)
			ps <= None;
		else
			ps <= ns;      
   end  
	
	enum { None, Left, Right, Up, Down} ps, ns;
	
	always_comb begin
		case (ps)
			None:	if (LEFT & ~RIGHT & ~UP & ~DOWN) 			
			         ns = Left;
					else if (RIGHT & ~LEFT & ~UP & ~DOWN)	
					   ns = Right;
					else if (UP & ~LEFT & ~RIGHT & ~DOWN)
					   ns = Up;
					else if (DOWN & ~LEFT & ~RIGHT & ~UP)	
					   ns = Down;
					else			 															
					   ns = None;
			
			Up:	if (LEFT & ~RIGHT & ~UP & ~DOWN) 			
			         ns = Left;
					else if (RIGHT & ~LEFT & ~UP & ~DOWN)	
					   ns = Right;
					else			 															
					   ns = Up;
					
			Down:	if (LEFT & ~RIGHT & ~UP & ~DOWN) 			
			         ns = Left;
					else if (RIGHT & ~LEFT & ~UP & ~DOWN)	
					   ns = Right;
					else			 															
					   ns = Down;		
						
			Left:	if (UP & ~LEFT & ~RIGHT & ~DOWN)			
			         ns = Up;
					else if (DOWN & ~LEFT & ~RIGHT & ~UP)	
					   ns = Down;
					else			 															
					   ns = Left;
					
			Right:if (UP & ~LEFT & ~RIGHT & ~DOWN)			
			         ns = Up;
					else if (DOWN & ~LEFT & ~RIGHT & ~UP)	
					   ns = Down;
					else			 															
					   ns = Right;
		endcase
	end
	
	assign track_num = (current_Move == 10'b1011111011);
	assign U = (current_Move == 10'b1011111011 && ps == Up && ~gameover);
	assign D = (current_Move == 10'b1011111011 && ps == Down && ~gameover);
	assign L = (current_Move == 10'b1011111011 && ps == Left && ~gameover);
	assign R = (current_Move == 10'b1011111011 && ps == Right && ~gameover);
	
endmodule







//module movement_testbench();
//	logic Clock, reset;
//	logic LEFT, RIGHT, UP, DOWN;
//	logic L, R, U, D;
//	logic [2:0] count;
//	movement dut (.Clock, .reset, .count, .LEFT, .RIGHT, .UP, .DOWN, .L, .R, .U, .D);
//	
//	parameter CLOCK_PERIOD = 100;
//	initial begin
//		Clock <= 0;
//		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
//		
//	end
//	initial begin
//		count <= 3'b000;
//	end
//
//	initial begin
//														@(posedge Clock);
//					reset<=1;						@(posedge Clock); 
//					reset<=0; LEFT <= 0; RIGHT <= 0; UP <= 0; DOWN <= 0; 	@(posedge Clock);     
//					count <= count + 3'b001;									@(posedge Clock);     
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					LEFT <= 1; count <= count + 3'b001;					@(posedge Clock);
//					LEFT <= 0;	count <= count + 3'b001;				@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					count <= count + 3'b001;									@(posedge Clock);
//					
//					UP <= 1; DOWN <=1;	@(posedge Clock);
//					UP <= 0; DOWN <=0; @(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//					reset <= 1;						@(posedge Clock);
//					reset <= 0;						@(posedge Clock);
//														@(posedge Clock);
//					LEFT <= 1; RIGHT <=1; @(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//														@(posedge Clock);
//      $stop; // End the simulation.  
//   end      
//endmodule