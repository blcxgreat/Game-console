// Final Project
// This module displays the game level that the player is currently at.
// The corresponding level is shown on HEX0.

module levelDisplay (HEX, clk, reset, levelSW);
	// output is a seven segment display
	output logic [6:0] HEX;
	input logic [2:0] levelSW; // taken from SW8 to 0.
	input logic clk, reset; // SW9 is reset.
	
	logic [3:0] select; // the corresponding "code" for a given level.
	// level representation from the input SW
	localparam level0 = 3'b000;
	localparam level1 = 3'b001;
	localparam level2 = 3'b010;
	localparam level3 = 3'b011;
	localparam level4 = 3'b100;
	localparam level5 = 3'b101;
	localparam level6 = 3'b110;
	localparam level7 = 3'b111;
	
	always_comb begin
		case(levelSW)  // based on levelSW
			level0: select = 4'b0000; 
			level1: select = 4'b0001;
			level2: select = 4'b0010;
			level3: select = 4'b0011;
			level4: select = 4'b0100;
			level5: select = 4'b0101;
			level6: select = 4'b0110;
			level7: select = 4'b0111;
			default: select = 4'b0000;  // all other cases are displayed as 0.
		endcase
	end
	
	// select is then used as input to seg7 so proper level can be displayed.
	seg7 display (.bcd(select), .leds(HEX));

endmodule


module levelDisplay_testbench();  // simulation code for levelDisplay
	logic [2:0] levelSW;
	logic clk, reset;
	logic [6:0] HEX;

	levelDisplay dut (.HEX, .clk, .reset, .levelSW);

	initial begin
		levelSW = 9'b000000000; #10;
		levelSW = 9'b000000001; #10;
		levelSW = 9'b000000010; #10;
		levelSW = 9'b000000011; #10;
		levelSW = 9'b000000100; #10;
		levelSW = 9'b100000000; #10;
		levelSW = 9'b110000000; #10;
		levelSW = 9'b000111100; #10;		
	end
endmodule
