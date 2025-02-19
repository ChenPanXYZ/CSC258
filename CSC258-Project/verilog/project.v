module project(
	input CLOCK_50,
	input [3:0] KEY, 
	input [0:0] SW,
	output [6:0] LEDR,
	output [6:0] HEX0,
	output [6:0] HEX1,
	
	output VGA_CLK,   						//	VGA Clock
	output VGA_HS,							//	VGA H_SYNC
	output VGA_VS,							//	VGA V_SYNC
	output VGA_BLANK_N,						//	VGA BLANK
	output VGA_SYNC_N,						//	VGA SYNC
	output [9:0] VGA_R,   						//	VGA Red[9:0]
	output [9:0] VGA_G,	 						//	VGA Green[9:0]
	output [9:0] VGA_B,   						//	VGA Blue[9:0]
	output  [8:0]  LEDG,  //  LED Green[8:0]
	input    PS2_DAT,
	input    PS2_CLK,
	inout  [35:0] GPIO_0, 
	inout  [35:0] GPIO_1
	
	

);
	
	wire turnoffWire;
	wire [7:0] score;
	wire mole1, mole2, mole3;
	wire button1, button2, button3;
	
	reg draw;
	reg [1:0] coord;
	wire [29:0] speed;
	reg [2:0] colour;
	
	
   always @(*)
   begin
		if(mole1 == 1) begin
			coord = 10;
			draw = 1;
		end
		else if(mole2 == 1) begin
			coord = 01;
			draw = 1;
		end
		else if (mole3 == 1) begin
			coord = 00;
			draw = 1;
		end
		else begin
			draw = 0;
		end
   end
	
	wire scan_ready;
	
	wire [29:0] waitTime;
	
	levelController l(
		.clock(CLOCK_50),
		.game(SW[0]),
		.score(score),
		.speed(speed),
		.waitTime(waitTime)
	);
	
	
	key k(
		.CLOCK_50(CLOCK_50),
		.KEY(KEY[3:0]),
		.LEDG(LEDG),
		.PS2_DAT(PS2_DAT),
		.PS2_CLK(PS2_CLK),
		.GPIO_0(GPIO_0),
		.GPIO_1(GPIO_1),
		.button1(button1),
		.button2(button2),
		.button3(button3),
		.scan_ready(scan_ready)
	);
	//assign LEDR[4] = button1;
	//assign LEDR[5] = button3;
	//assign LEDR[3] = scan_ready;
	
	
	paint myPaint1(
		.CLOCK_50(CLOCK_50),		//	On Board 50 MHz
		.coord(coord),
		.mole(draw),
		.reset(~game),
		.VGA_CLK(VGA_CLK),   						//	VGA Clock
		.VGA_HS(VGA_HS),							//	VGA H_SYNC
		.VGA_VS(VGA_VS),							//	VGA V_SYNC
		.VGA_BLANK_N(VGA_BLANK_N),						//	VGA BLANK
		.VGA_SYNC_N(VGA_SYNC_N),						//	VGA SYNC
		.VGA_R(VGA_R),   						//	VGA Red[9:0]
		.VGA_G(VGA_G),	 						//	VGA Green[9:0]
		.VGA_B(VGA_B)   						//	VGA Blue[9:0]
	);
	
	assign LEDR[0] = draw;
	
	
	
	player p(
		.clock(CLOCK_50),
		.button1(button1),
		.button2(button2),
		.button3(button3),
		.mole1(mole1),
		.mole2(mole2),
		.mole3(mole3),
		.game(SW[0]),
		.turnoff(turnoffWire),
		.score(score)
	);
	
	

	display_controller d(
		.clock(CLOCK_50),
		.game(SW[0]),
		.turnoff(turnoffWire),
		.speed(speed),
		.waitTime(waitTime),
		.mole1(mole1),
		.mole2(mole2),
		.mole3(mole3)
	);
	
	seven_segment_decoder H0(
		.HEX(HEX0),
		.SW(score[3:0])
	);
	seven_segment_decoder H1(
		.HEX(HEX1),
		.SW(score[7:4])
	);
endmodule


module paint
	(
		CLOCK_50,						//	On Board 50 MHz
		coord,
		mole,
		reset,
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input [1:0] coord;
	input mole;
	input reset;
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	
	// height of 33 pixels down from top left
	wire [6:0] y = 6'b100001;
	wire writeEn;
	wire [5:0] y_out, x_out;
	
	reg [2:0] colour;
	
	
	reg [5:0] x;
   always @(*)
   begin
       case(coord)
           2'b00: x = 6'b000001;//x set to 1
           2'b01: x = 6'b010000;//x set to 3
           2'b10: x = 6'b100000;//x set to 5
           default: x = 6'b000001;
       endcase
   end
	 
   always @(*)
   begin
       case(mole)
           1'b0: colour = 3'b000;//set colour of block to black
           default: colour = 3'b100;
       endcase
   end
	
	reg [3:0] count;
	wire enable;
	
	
	
	
//	assign enable = (count == 4) ? 1 : 0;
	always@(posedge CLOCK_50) begin
//		if(reset == 1) begin
//			count <= 0;
//		end
//		else if(enable == 1) begin
		if(writeEn == 1) begin
			count <= count + 1;
		end
		else
			count <= 0;
	end
	
	
	assign x_out = x + count[1:0];
	assign y_out = y + count[3:2];
	
	

	
    reg [5:0] current_state, next_state; 

    
    localparam  WAIT        = 0,

                DRAW   =1,
					 
					 WAIT_ERASE = 2,
					 ERASE = 3,

                DONE        = 4;
					 
					 
	
    always@(*)

    begin: state_table 

            case (current_state)
				
					WAIT: next_state = (mole == 1) ? DRAW : WAIT;
					DRAW: next_state = (count == 15) ? WAIT_ERASE : DRAW;
					WAIT_ERASE: next_state = (mole == 0) ? ERASE : WAIT_ERASE;
					ERASE: next_state = (count == 15) ? DONE : ERASE;
					
					DONE: next_state = (mole == 0) ? WAIT : DONE;


            default:     next_state = WAIT;

        endcase

    end // state_table
	 
	assign writeEn = (current_state == DRAW || current_state == ERASE);
	 
	always@(posedge CLOCK_50)

		 begin: state_FFs

			  if(reset == 0)

					current_state <= WAIT;

			  else

					current_state <= next_state;

		 end // state_FFS
		 

		 
		 
	 
	 
	 

	vga_adapter VGA(
			.resetn(reset),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x_out),
			.y(y_out),
			.plot(writeEn),
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";
		
		 wire stop_out;
		 
//		datapath d0(	
//						.clk(CLOCK_50),
//						.enable(writeEn),
//						.ld_x(1),
//						.ld_y(1),
//						.ld_color(1),
//						.reset_n(~resetn),
//						.color_in(3'b101),
//						.coord(x),
//						.x_out(x_out),
//						.y_out(y_out),
//						);	

						
		 // Instansiate FSM control
//		control c0(.clk(CLOCK_50),
//		 .resetn(~resetn),
//		 .xstuff(1),
//		 .plot(1),
//		 .stop(stop_out),
//		 .load_x(load_x),
//		 .load_y(load_y), 
//		 .count(count), 
//		 .load_col(load_col),
//		 .enable(writeEn)
//		 );
		
endmodule


module datapath(	
		input clk,
		input ld_x, ld_y, ld_color,
		input reset_n, enable,
		input [2:0] color_in,
		input [6:0] coord,
		output [7:0] x_out,
		output [6:0] y_out
	);

	reg [2:0] count_x, count_y;
	reg [7:0] x;
	reg [6:0] y;
	reg [2:0] color;
	wire y_enable;
	wire [1:0] rate_count_down;

	// registors for x, y and color
	always @(posedge clk) begin
		if (reset_n) begin
			x <= 8'b0;
			y <= 7'b0;
			color <= 3'b0;
		end
		else begin
			if (ld_x)
				x <= {1'b0, coord};
			if (ld_y)
				y <= coord;
			if (ld_color)
				color <= color_in;
		end
	end

	// counter for x
	always @(posedge clk) begin
		if (reset_n) begin
			count_x <= 2'b00;
			end
		else if (enable) begin
			if (count_x == 2'b11) begin
				count_x <= 2'b00;
			end
			else begin
				count_x <= count_x + 1'b1;
			end
		end
	end
	
	// when x gets to 4, you let y increase by 1 (To draw square)
	assign y_enable = (count_x == 2'b11) ? 1 : 0;

	// counter for y
	always @(posedge clk) begin
		if (reset_n) begin
			count_y <= 2'b00;
		end
		else if (enable && y_enable) begin
			if (count_y != 2'b11) begin
				count_y <= count_y + 1'b1;
			end
			else begin
				count_y <= 2'b00;
			end
		end
	end
	
	// output coordinates
	assign x_out = x + count_x;
	assign y_out = y + count_y;
endmodule



module randomNumber(  
    input clock,      
    input load,
	input enable, // enable to change the randomNumber
    output reg [2:0] randomNumber // We have three moles, so need 2-bit randomNumber.
);
	wire feedback;
	assign feedback = ~(randomNumber[2] ^ randomNumber[1]);
	
	always@(posedge load or posedge enable)
	begin
		if(load)
			randomNumber = 000;
		else if(enable)
			begin
			randomNumber = {randomNumber[1:0], feedback};
			end
	end
endmodule

module rateCounter(
	input clock,
	input [29:0] d,
	input par_load,
	output reg [29:0] q
);
	always @(posedge clock or posedge par_load)
	begin
		if(par_load == 1'b1)
			q <= d;
		else if (q == 30'd000000000)
			q <= d;
		else
			q <= q - 30'd000000001;
	end
endmodule


module display_controller(
	input clock,
	input game,
	input turnoff,
	input [29:0] speed,
	input [29:0] waitTime,
	output reg mole1,
	output reg mole2,
	output reg mole3
);
	reg waitFinish;
	wire [2:0] RanNumber;
	wire [29:0] myRateCounterOut;
	reg refresh;
	
	always@(posedge clock or posedge turnoff)
	begin
		if(turnoff) begin
			refresh = 1;
			mole1 = 0;
			mole2 = 0;
			mole3 = 0;
		end
		
		else if (!game) begin
			refresh = 1;
			mole1 = 0;
			mole2 = 0;
			mole3 = 0;
		end
		
		else begin
			refresh = (myRateCounterOut == 30'b0000000000000000000000000000) ? 1 : 0;
			waitFinish = (myRateCounterOut < (speed)) ? 1:0;
			mole1 = ((RanNumber == 1  || RanNumber == 5) && !refresh && !(myRateCounterOut == 30'b0000000000000000000000000000) && game && waitFinish) ? 1 : 0;
			mole2 = ((RanNumber == 0 || RanNumber == 2 || RanNumber == 7)  && !refresh && !(myRateCounterOut == 30'b0000000000000000000000000000) && game && waitFinish) ? 1 : 0;
			mole3 = ((RanNumber == 3 || RanNumber == 4 || RanNumber == 6) && !refresh && !(myRateCounterOut == 30'b0000000000000000000000000000) && game && waitFinish) ? 1 : 0;
		end
		
	end
	
	rateCounter myRateCounter(
		.clock(clock),
		.d(speed + waitTime), //3 Seconds between the two rounds.
		.par_load(refresh),
		.q(myRateCounterOut)
	);
	
	randomNumber myRandomNumber(
		.clock(clock),
		.load(!game),
		.enable(refresh),
		.randomNumber(RanNumber)
	);

endmodule


module player(
	input clock,
	input button1, 
	input button2, 
	input button3,
	input mole1, 
	input mole2, 
	input mole3,
	input game,
	output reg turnoff,
	output reg [7:0] score
);
	reg [7:0] scoreWire;
	reg turnoffWire;
	
	reg oldButton1, oldButton2, oldButton3;
	
	always@(posedge clock) // when click the button, changed turnoff immediately
	begin
		if (button1) 
			begin
				turnoff = (game && mole1 && !oldButton1) ? 1 : 0;
				
				if(turnoff) begin
					score = score + 1;
				end
				else begin
					score = (game && !mole1 && (mole2 || mole3) && (score !=0)) ? score -1: score;
				end
				/*
				score = (turnoff) ? score + 1 : score;
				
				//Try to punish player for clicking the wrong button.
				score = (game && !mole1 && (mole2 || mole3) && !oldButton1 && (score !=0)) ? score - 1 : score;
				*/
			end
		else if (button2)
			begin
				turnoff = (game && mole2 && button2 && !oldButton2) ? 1 : 0;
				
				if(turnoff) begin
					score = score + 1;
				end
				else begin
					score = (game && !mole1 && (mole1 || mole3) && (score !=0)) ? score - 1: score;
				end
				/*
				score = (turnoff) ? score + 1 : score;
				score = (game && !mole2 && (mole1 || mole3) && !oldButton2 && (score !=0)) ? score - 1 : score;
				*/
			end
		else if (button3)
			begin
				turnoff = (game && mole3 && button3 && !oldButton3) ? 1 : 0;
				if(turnoff) begin
					score = score + 1;
				end
				else begin
					score = (game && !mole1 && (mole1 || mole2) && (score !=0)) ? score - 1: score;
				end
				/*
				score = (turnoff) ? score + 1 : score;
				score = (game && !mole3 && (mole1 || mole2) && !oldButton3 && (score !=0)) ? score - 1 : score;
				*/
			end
		else if(!game)
			begin
				turnoff = 0;
				score = 0;
			end
			oldButton1 <= button1;
			oldButton2 <= button2;
			oldButton3 <= button3;
	end
	
endmodule


module levelController(
	input clock,
	input game,
	input [7:0] score,
	output reg [29:0] speed,
	output reg [29:0] waitTime
);
//A finite state machine that controls the difficulty of the game.
	always@(negedge clock) //I don't know why it is negedge but it seems correct in the simulation...
	begin
		if(!game)
			begin
				speed <= 30'd199999999; //4 Seconds
				waitTime <= 30'd199999999; //4 Seconds
			end
		else if(8'd0 <= score && score <= 8'd2)
			begin
				speed <= 30'd199999999; // 4 Seconds
				waitTime <= 30'd099999999; //4 Seconds
			end
		else if(8'd2 < score && score <= 8'd5)
			begin
				speed <= 30'd099999999; // 2 Seconds
				waitTime <= 30'd049999999; //4 Seconds
			end
		else if(8'd5 < score && score <= 8'd10)
			begin
				speed <= 30'd049999999; // 1 Second
				waitTime <= 30'd029999999; //4 Seconds
			end
		else
			begin
				speed <= 30'd024999999; // 0.5 Second
				waitTime <= 30'd019999999; //4 Seconds
			end
	end

endmodule


module key(
	  // Clock Input (50 MHz)
	  input  CLOCK_50,
	  //  Push Buttons
	  input  [3:0]  KEY,
	  //  DPDT Switches 
	  output  [8:0]  LEDG,  //  LED Green[8:0]
	  //  PS2 data and clock lines        
	  input    PS2_DAT,
	  input    PS2_CLK,
	  //  GPIO Connections
	  inout  [35:0] GPIO_0, 
	  inout  [35:0] GPIO_1,
	  output reg button1,
	  output reg button2,
	  output reg button3,
	  output scan_ready
	);

	//  set all inout ports to tri-state
	assign  GPIO_0    =  36'hzzzzzzzzz;
	assign  GPIO_1    =  36'hzzzzzzzzz;

	wire RST;
	assign RST = KEY[0];

	// turn off green LEDs
	assign LEDG = 0;

	wire reset = 1'b0;
	wire [7:0] scan_code;

	reg [7:0] history[1:4];
	//wire read;

	oneshot pulser(
		.pulse_out(read),
		.trigger_in(scan_ready),
		.clk(CLOCK_50)
	);

	keyboard kbd(
	  .keyboard_clk(PS2_CLK),
	  .keyboard_data(PS2_DAT),
	  .clock50(CLOCK_50),
	  .reset(reset),
	  .read(read),
	  .scan_ready(scan_ready),
	  .scan_code(scan_code)
	);
	
	
//   assign button1 = ((history[1][3:0] == 4'h4) && (history[1][7:4] == 4'h7));
//
	// assign button2 = ((history[1][3:0] == 4'h2) && (history[1][7:4] == 4'h7));
//
	//assign button3 = ((history[1][3:0] == 4'hb) && (history[1][7:4] == 4'h6));

	
	always @(posedge scan_ready)
	begin
		 history[4] <= history[3];
		 history[3] <= history[2];
		 history[2] <= history[1];
		 history[1] <= scan_code;
	end

//	always @(posedge scan_ready)
//	begin
//		 if (scan_code == 8'h74)
//		 
//				button1 = 1;
//				
//		  else 
//				button1 = 0;
//				
//	end

	always @(posedge CLOCK_50)
	begin
		 if (scan_ready && (scan_code == 8'h74))
		 
				button1 = 1;
				
		  else 
				button1 = 0;
				
		 if (scan_ready && (scan_code == 8'h72))
		 
				button2 = 1;
				
		  else 
				button2 = 0;
				
		 if (scan_ready && (scan_code == 8'h6b))
		 
				button3 = 1;
				
		  else 
				button3 = 0;
				
	end

	
endmodule


module keyboard(keyboard_clk, keyboard_data, clock50, reset, read, scan_ready, scan_code);

	input keyboard_clk;
	input keyboard_data;
	input clock50; // 50 Mhz system clock
	input reset;
	input read;
	output scan_ready;
	output [7:0] scan_code;
	reg ready_set;
	reg [7:0] scan_code;
	reg scan_ready;
	reg read_char;
	reg clock; // 25 Mhz internal clock

	reg [3:0] incnt;
	reg [8:0] shiftin;

	reg [7:0] filter;
	reg keyboard_clk_filtered;

	// scan_ready is set to 1 when scan_code is available.
	// user should set read to 1 and then to 0 to clear scan_ready

	always @ (posedge ready_set or posedge read)
	if (read == 1) scan_ready <= 0;
	else scan_ready <= 1;

	// divide-by-two 50MHz to 25MHz
	always @(posedge clock50)
		 clock <= ~clock;



	// This process filters the raw clock signal coming from the keyboard 
	// using an eight-bit shift register and two AND gates

	always @(posedge clock)
	begin
		filter <= {keyboard_clk, filter[7:1]};
		if (filter==8'b1111_1111) keyboard_clk_filtered <= 1;
		else if (filter==8'b0000_0000) keyboard_clk_filtered <= 0;
	end


	// This process reads in serial data coming from the terminal

	always @(posedge keyboard_clk_filtered)
	begin
		if (reset==1)
		begin
			incnt <= 4'b0000;
			read_char <= 0;
		end
		else if (keyboard_data==0 && read_char==0)
		begin
		 read_char <= 1;
		 ready_set <= 0;
		end
		else
		begin
			 // shift in next 8 data bits to assemble a scan code    
			 if (read_char == 1)
				  begin
					  if (incnt < 9) 
					  begin
						 incnt <= incnt + 1'b1;
						 shiftin = { keyboard_data, shiftin[8:1]};
						 ready_set <= 0;
					end
			  else
					begin
						 incnt <= 0;
						 scan_code <= shiftin[7:0];
						 read_char <= 0;
						 ready_set <= 1;
					end
			  end
		 end
	end

endmodule

module oneshot(output reg pulse_out, input trigger_in, input clk);
	reg delay;

	always @ (posedge clk)
	begin
		 if (trigger_in && !delay) pulse_out <= 1'b1;
		 else pulse_out <= 1'b0;
		 delay <= trigger_in;
	end 
endmodule


module seven_segment_decoder(HEX, SW);
    input [3:0] SW;
    output [6:0] HEX;
	
	hex0 s0(
		.c0(SW[0]),
		.c1(SW[1]),
		.c2(SW[2]),
		.c3(SW[3]),
		.m(HEX[0])
		);	
	hex1 s1(
		.c0(SW[0]),
		.c1(SW[1]),
		.c2(SW[2]),
		.c3(SW[3]),
		.m(HEX[1])
		);	
	hex2 s2(
		.c0(SW[0]),
		.c1(SW[1]),
		.c2(SW[2]),
		.c3(SW[3]),
		.m(HEX[2])
		);	
	hex3 s3(
		.c0(SW[0]),
		.c1(SW[1]),
		.c2(SW[2]),
		.c3(SW[3]),
		.m(HEX[3])
		);
	hex4 s4(
		.c0(SW[0]),
		.c1(SW[1]),
		.c2(SW[2]),
		.c3(SW[3]),
		.m(HEX[4])
		);	
	hex5 s5(
		.c0(SW[0]),
		.c1(SW[1]),
		.c2(SW[2]),
		.c3(SW[3]),
		.m(HEX[5])
		);
	hex6 s6(
		.c0(SW[0]),
		.c1(SW[1]),
		.c2(SW[2]),
		.c3(SW[3]),
		.m(HEX[6])
		);	
endmodule

module hex0(c0, c1, c2, c3, m);
    input c0;
    input c1;
    input c2;
	input c3;
    output m;
	
	assign m = (~c3 & ~c2 & ~c1 & c0) | (~c3 & c2 & ~c1 & ~c0) | (c3 & c2 & ~c1 & c0) | (c3 & ~c2 & c1 & c0);

endmodule


module hex1(c0, c1, c2, c3, m);
    input c0;
    input c1;
    input c2;
	input c3;
    output m;
	
	assign m = (c3 & c2 & c1) | (c3 & c2 & ~c1 & ~c0) | (~c3 & c2 & ~c1 & c0) | (c3 & ~c2 & c1 & c0) | (~c3 & c2 & c1 & ~c0);

endmodule

module hex2(c0, c1, c2, c3, m);
    input c0;
    input c1;
    input c2;
	input c3;
    output m;
	
	assign m = (c3 & c2 & c1) | (c3 & c2 & ~c1 & ~c0) | (~c3 & ~c2 & c1 & ~c0);

endmodule

module hex3(c0, c1, c2, c3, m);
    input c0;
    input c1;
    input c2;
	input c3;
    output m;
	
	assign m = (~c2 & ~c1 & c0) | (c2 & c1 & c0) | (~c3 & c2 & ~c1 & ~c0) | (c3 & ~c2 & c1 & ~c0);

endmodule

module hex4(c0, c1, c2, c3, m);
    input c0;
    input c1;
    input c2;
	input c3;
    output m;
	
	assign m = (~c3 & c0) | (~c3 & c2 & ~c1 & ~c0) | (c3 & ~c2 & ~c1 & c0);

endmodule

module hex5(c0, c1, c2, c3, m);
    input c0;
    input c1;
    input c2;
	input c3;
    output m;
	
	assign m = (~c3 & c1 & c0) | (~c3 & ~c2 & ~c1 & c0) | (c3 & c2 & ~c1 & c0) | (~c3 & ~c2 & c1 & ~c0);

endmodule

module hex6(c0, c1, c2, c3, m);
    input c0;
    input c1;
    input c2;
	input c3;
    output m;
	
	assign m = (~c3 & ~c2 & ~c1) | (c3 & c2 & ~c1 & ~c0) | (~c3 & c2 & c1 & c0);

endmodule

