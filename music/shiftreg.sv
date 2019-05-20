//seven DFF shift register
// datain - 0 - 1 - 2 - 3 - 4 - 5 - 6 - dataout

module shiftreg(CLOCK_50, reset, datain, dataout);

//————————————————————–
// signal definitions
//————————————————————–
input CLOCK_50, reset;
input logic signed [23:0] datain;
output logic [23:0] dataout;

//shift register signals
logic signed [23:0] shift [0:6];
logic [23:0] temp [0:7];

integer i;
always @(posedge CLOCK_50) begin
	if (reset) begin
		for (int i = 0; i <= 6; i++)
			shift[i] <= 0;
	end else begin
			shift[0] <= datain;
			for (int i = 1; i <= 6; i++) shift[i] <= shift[i-1];

			dataout <= temp[7];
	end
end

integer j;
always_comb begin
	temp[0] = datain / 8;
	for (int j = 1; j <= 7; j++) 
		temp[j] = (shift[j - 1] / 8);
	for (int j = 1; j <= 7; j++) begin
		temp[j] = temp[j] + temp[j-1];
	end
end

endmodule


//module shiftreg_testbench();
//
//	logic CLOCK_50, reset;
//	logic signed [23:0] datain, dataout;
//	
//shiftreg dut(.CLOCK_50, .reset, .datain, .dataout);
//	
//	parameter CLOCK_PERIOD = 100;
//	initial begin
//		CLOCK_50 <= 0;  // intially, the clock is 0
//		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;  // clock filps value every half period
//	end
//
//	// each line represents a clock cycle
//	initial begin
//		reset <= 1; 	@(posedge CLOCK_50);
//		reset <= 0; datain <= 24'b1000; read <= 1;	@(posedge CLOCK_50);  // intial reset
//							@(posedge CLOCK_50);
//							@(posedge CLOCK_50);
//							@(posedge CLOCK_50);
//						datain <= 24'b10000;	@(posedge CLOCK_50);
//							@(posedge CLOCK_50);
//						datain <= 24'b1000;	@(posedge CLOCK_50);
//							@(posedge CLOCK_50);
//							@(posedge CLOCK_50);
//							@(posedge CLOCK_50);
//							@(posedge CLOCK_50);
//							@(posedge CLOCK_50);
//							@(posedge CLOCK_50);
//							@(posedge CLOCK_50);	
//							@(posedge CLOCK_50);
//							@(posedge CLOCK_50);							
//		$stop();
//	end
//
//endmodule

