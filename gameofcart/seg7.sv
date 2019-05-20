// Final Project
// This module displays the proper 7-segement display for HEX based on the inputs given.

module seg7 (bcd, leds);
	input logic [3:0] bcd;  // 4 inputs are taken
	output logic [6:0] leds;  // output is 7 leds corresponding to 7 segments for one single HEX display
	always_comb begin
		case (bcd)  // try all different cases of bcd input
					   // Light: 6543210. also taken account of the ACTIVE LOW property of the HEX
			4'b0000: leds = ~7'b0111111; // 0
			4'b0001: leds = ~7'b0000110; // 1
			4'b0010: leds = ~7'b1011011; // 2
			4'b0011: leds = ~7'b1001111; // 3
			4'b0100: leds = ~7'b1100110; // 4
			4'b0101: leds = ~7'b1101101; // 5
			4'b0110: leds = ~7'b1111101; // 6
			4'b0111: leds = ~7'b0000111; // 7
			4'b1000: leds = ~7'b1111111; // 8
			4'b1001: leds = ~7'b1101111; // 9
			default: leds = 7'b0000000;  // other cases that have not been covered in the cases above
		endcase
	end
	
endmodule

module seg7_testbench();  // simulation code for seg7
	logic [3:0] bcd;
	logic [6:0] leds;

	seg7 dut (.bcd, .leds);

	integer i;
	initial begin
		for (i = 0; i < 2**4; i++) begin
			bcd = i; #10;  // try all combinations of inputs
		end
	end
endmodule
