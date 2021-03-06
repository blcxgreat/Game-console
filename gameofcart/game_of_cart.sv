module game_of_cart (clk, reset, levelS, p1L, p1R, p2L, p2R, red_arrayl, green_arrayc, red_arrayr, LED, stage, level, num, pscorel, pscorem, pscorer, bom);

	output logic [7:0][7:0] red_arrayl, green_arrayc, red_arrayr;  // red and green lights of the entire matrix for two players.
	output logic LED;
	output logic [6:0] stage, level, num, pscorel, pscorem, pscorer;
	input logic bom;
	logic die1, die2; // indicates game is over.
	logic [9:0] random; // output from 10 bit LFSR.
	logic incrScore1, incrscore2;  // this is 1 for a clock period everytime bird passes the barrier.
	input logic clk, reset, p1L, p1R, p2L, p2R;
	input logic [2:0] levelS;
	
	// all other red columns off, bird only moves at the buttom row for both players.
	assign red_arrayl[7][7:0] = 8'b00000000;
	assign red_arrayl[6][7:0] = 8'b00000000;
	assign red_arrayl[5][7:0] = 8'b00000000;
	assign red_arrayl[4][7:0] = 8'b00000000;
	assign red_arrayl[3][7:0] = 8'b00000000;
	assign red_arrayl[2][7:0] = 8'b00000000;
	assign red_arrayl[1][7:0] = 8'b00000000;
	
	assign red_arrayr[7][7:0] = 8'b00000000;
	assign red_arrayr[6][7:0] = 8'b00000000;
	assign red_arrayr[5][7:0] = 8'b00000000;
	assign red_arrayr[4][7:0] = 8'b00000000;
	assign red_arrayr[3][7:0] = 8'b00000000;
	assign red_arrayr[2][7:0] = 8'b00000000;
	assign red_arrayr[1][7:0] = 8'b00000000;


	// in charge of displaying the race car pattern on matrix based on user input.
	cart #(.WIDTH(8)) pl (.out(red_arrayl[0][7:0]), .clk, .reset, .inL(p1L), .inR(p1R), .gg(die1));	
	cart #(.WIDTH(8)) pr (.out(red_arrayr[0][7:0]), .clk, .reset, .inL(p2L), .inR(p2R), .gg(die2));
	
	// generates random 10 bit number.
	random_generator lfsr (.out(random), .clk, .reset);
	
	logic clear;  // wiping the barriers
	bomb boom (.in(bom), .clk, .reset, .out(LED), .swipe(clear));
	
	// using the random number from LFSR and the level selected by user, create barriers of that difficulty.
	generator #(.WIDTH(10)) bar7 (.clk, .reset(reset | clear), .gg(die1 | die2), .in(random[2:0]), .display(green_arrayc[7][7:0]), .levelSW(levelS));
	// shifts the barrier pattern above the row to itself.
	shifter #(.WIDTH(9)) bar6 (.clk, .reset(reset | clear), .gg(die1 | die2), .in(green_arrayc[7][7:0]), .out(green_arrayc[6][7:0]));
	shifter #(.WIDTH(9)) bar5 (.clk, .reset(reset | clear), .gg(die1 | die2), .in(green_arrayc[6][7:0]), .out(green_arrayc[5][7:0]));
	shifter #(.WIDTH(9)) bar4 (.clk, .reset(reset | clear), .gg(die1 | die2), .in(green_arrayc[5][7:0]), .out(green_arrayc[4][7:0]));
	shifter #(.WIDTH(9)) bar3 (.clk, .reset(reset | clear), .gg(die1 | die2), .in(green_arrayc[4][7:0]), .out(green_arrayc[3][7:0]));
	shifter #(.WIDTH(9)) bar2 (.clk, .reset(reset | clear), .gg(die1 | die2), .in(green_arrayc[3][7:0]), .out(green_arrayc[2][7:0]));
	shifter #(.WIDTH(9)) bar1 (.clk, .reset(reset | clear), .gg(die1 | die2), .in(green_arrayc[2][7:0]), .out(green_arrayc[1][7:0]));
	shifter #(.WIDTH(9)) bar0 (.clk, .reset(reset | clear), .gg(die1 | die2), .in(green_arrayc[1][7:0]), .out(green_arrayc[0][7:0]));	
	
	assign stage = ~7'b0111000;  //L
	assign level = ~7'b0011100;  //V
	levelDisplay lv (.HEX(num), .clk, .reset, .levelSW(levelS)); // displays which level player is at

	// determines when to add points and when to end the game
	gamelogic gl (.clk, .reset, .user(red_arrayl[0]), .barrier(green_arrayc[0]), .add(incrScore1), .crash(die1));
	gamelogic gr (.clk, .reset, .user(red_arrayr[0]), .barrier(green_arrayc[0]), .add(incrScore2), .crash(die2));
	
	logic d0;
	logic d1;
	// counts the current score and shows on HEX.
	counter #(.WIDTH(4)) pscr (.HEX(pscorer), .cycle(d0), .in(incrScore1), .clk, .reset); 
	counter #(.WIDTH(4)) pscm (.HEX(pscorem), .cycle(d1), .in(d0), .clk, .reset); 	
	counter #(.WIDTH(4)) pscl (.HEX(pscorel), .cycle(/*do not need this output*/), .in(d1), .clk, .reset);

endmodule 