// Part 2 skeleton

module part3
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        SW,
		// The ports below are for the VGA output.  Do not change.
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
	input   [9:0]   SW;
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writeEn;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
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
			
			

	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.
    
    datapath d(
		.x_data(), 
		.y_data(), 
		.color_data(SW[7:9]), 
		.clock(CLOCK_50),
		.reset(resetn),
		.go(datapath_go),
		.x(x),
		.y(y), 
		.color(colour)
	);
	
    // Instansiate FSM control
    // control c0(...);
    
endmodule

module control(clock, reset, go, start_drawing, data_path_go, writeEn);
    input clock;
    input reset;
    input go;
	input start_drawing;
	
	output reg data_path_go;
	output reg writeEn;

    reg [2:0] current_state, next_state; 
    
    localparam  S_LOAD        = 2'b00,
				S_LOAD_WAIT        = 2'b01,
                S_DRAW       = 2'b10;
    
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
            case (current_state)
                S_LOAD: next_state = go ? S_LOAD_WAIT : S_LOAD; 
                S_LOAD_WAIT: next_state = start_drawing ? S_LOAD_WAIT : S_DRAW;  
                S_DRAW: next_state = S_DRAW;
            default: next_state = S_LOAD;
        endcase
    end // state_table
	
    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
		data_path_go = 1'b0;
		writeEn = 1'b0;
        case (current_state)
            S_LOAD: begin
				data_path_go = 1;
                end
            S_DRAW: begin
				data_path_go = 1'b0;
                writeEn = 1;
                end
        // default:    // don't need default since we already made sure all of our outputs were assigned a value at the start of the always block
        endcase
    end // enable_signals
   
    // current_state registers
    always@(posedge clock)
    begin
        if(!reset)
            current_state <= S_LOAD;
        else
            current_state <= next_state;
    end // state_FFS
endmodule



module datapath(x_data, y_data, color_data, clock, reset, go, x, y, color);
	//Datapath is for updating the Point where VGA draws.
	//So output x,y, color should be connected to VGA.
	input clock;
	input [2:0] color_data;
	input reset;
	input go;
	input [7:0] x_data;
	input [6:0] y_data;
	output [7:0] x;
	output [6:0] y;
	output reg [2:0] color;
	
	output [7:0] x_out;
	output [6:0] y_out;
	output [2:0] color_out;
	
	reg [7:0] x_orgin;
	reg [6:0] y_orgin;
	
	reg [7:0] counter1;
	reg [6:0] counter2;
	
	wire x_direction;
	wire y_direction;
	
	wire delay_time;
	wire frame_number;
		
	h_register h(
		.clock(clock),
		.reset(reset),
		.x(x),
		.direction(x_direction)
	);
	
	v_register v(
		.clock(clock),
		.reset(reset),
		.y(y),
		.direction(y_direction)
	);
	//Above tells the circuit the direction, both horizentally and vertically.
    always @ (posedge clock) begin
        if (!reset) begin
            x_orgin <= 8'b00000000; 
            y_orgin <= 7'b0000000; 
            color <= 3'b000;
        end
        else begin
			x_orgin <= x_data; // load alu_out if load_alu_out signal is high, otherwise load from data_in
			y_orgin <= y_data;
			color <= color_data;
        end
    end
	
	delay_counter d(
		.clock(clock),
		.reset(reset),
		.enable(go),
		.q(delay_time)
	);
	
	
	frame_counter f(
		.clock(clock),
		.reset(reset),
		.enable(delay_time == 20'd0),
		.q(frame_number)
	);
	
	//Now 15 frames are counted. So we start moving the box.
	
	assign new_color = (frame_number == 4'b0000) ? 3'b000 : color_data;
	
	//So if the frame is counted 15 times, the 4*4 box will be redrawn with 000 color.
	//The name is not correct.dataPathErase is actually for drawing a 4*4 box.
	datapathErase toErase (
		.x_data(x),
		.y_data(y),
		.color_data(new_color),
		.clock(clock),
		.reset(reset),
		.go(go),
		.x(x),
		.y(y),
		.color(color_out)
	);
	
	x_counter forX(
		.clock(clock),
		.enable(frame_number == 4'b0000),
		.reset(reset),
		.direction(x_direction),
		.q(temp1)
	);
	
	y_counter forY(
		.clock(clock),
		.enable(frame_number == 4'b0000),
		.reset(reset),
		.direction(y_direction),
		.q(temp2)
	);
	
	//we update temp1 and temp2, so now we can redraw a 4 *4 box with the color we want.
	datapathErase toErase (
		.x_data(temp1),
		.y_data(temp2),
		.color_data(color_data),
		.clock(clock),
		.reset(reset),
		.go(go),
		.x(x),
		.y(y),
		.color(color_out)
	);
	
		
endmodule

module datapathErase(x_data, y_data, color_data, clock, reset, go, x, y, color);
	input clock;
	input [9:7] color_data;
	input reset;
	input go;
	input [7:0] x_data;
	input [6:0] y_data;
	output [7:0] x;
	output [6:0] y;
	output reg [2:0] color;
	
	reg [7:0] x_orgin;
	reg [6:0] y_orgin;
	
	reg [1:0] counter1;
	reg [1:0] counter2;
		
    always @ (posedge clock) begin
        if (!reset) begin
            x_orgin <= 8'b00000000; 
            y_orgin <= 7'b0000000; 
            color <= 3'b000;
        end
        else begin
			x_orgin <= x_data; // load alu_out if load_alu_out signal is high, otherwise load from data_in
			y_orgin <= y_data;
			color <= color_data;
        end
    end
	
	always @(posedge clock) begin
		if (!reset) begin
			counter1 <= 2'b00;
		end
		else if (go == 1'b1) begin
			if (counter1 == 2'b11) begin
				counter1 <= 2'b00;
			end
			else begin
				counter1 <= counter1 + 2'b1;
			end
		end
	end
	
	always @(posedge clock) begin
		if (!reset) begin
			counter2 <= 2'b00;
		end
		else if (go && counter1 == 2'b11) begin
			if (counter2 == 2'b11) begin
				counter2 <= 2'b00;
			end
			else begin
				counter2 <= counter2 + 2'b1;
			end
		end
	end
	
	assign x = x_orgin + counter1;
	assign y = y_orgin + counter2;
		
		
endmodule

module h_register(clock, reset, x, direction);
	input clock;
	input reset;
	input [7:0] x;
	output reg direction;
	
	always@(posedge clock)
	begin
		if(!reset)
			direction <= 1'b1;
		else
		begin
			if(direction)
			begin
				if(x == 8'b10011110)
					direction <= 1'b0;
				else
					direction <= 1'b1;
			   end
			else
			begin
				if(x == 8'b00000000)
					direction <= 1'b1;
				else
					direction <= 1'b0;
			end
		end
		end
endmodule

module v_register(clock,reset, y,direction);
	input clock;
	input reset;
	input [6:0] y;
	output reg direction;
	
	always@(posedge clock)
	begin
		if(!reset)
			direction <= 1'b0;
		else
		begin
			if(direction)
			begin
				if(y == 7'b1110110)
					direction <= 1'b0;
				else
					direction <= 1'b1;
			   end
			else
			begin
				if(y == 7'b0000000)
					direction <= 1'b1;
				else
					direction <= 1'b0;
			end
		end
		end
endmodule

module x_counter(clock,enable, reset, direction, q);
	input clock;
	input enable;
	input reset;
	input direction;
	output reg [7:0] q;
	
	
	always@(posedge clock)
	begin
		if(!reset)
			q <= 8'b00000000;
		else if(direction == 1'b1 && enable) begin
			q <= q + 1'b1;
		end
		
		else if(direction == 1'b0 && enable) begin
			q <= q - 1'b1;
		end
	end
endmodule

module y_counter(clock,enable, reset, direction, q);
	input clock;
	input enable;
	input reset;
	input direction;
	output reg [6:0] q;
	
	
	always@(posedge clock)
	begin
		if(!reset)
			q <= 8'd60;
		else if(direction == 1'b1 && enable) begin
			q <= q + 1'b1;
		end
		
		else if(direction == 1'b0 && enable) begin
			q <= q - 1'b1;
		end
	end
endmodule

module delay_counter(clock, reset, enable, q);
		input clock;
		input reset;
		input enable;
		output reg [19:0] q;
		
		always @(posedge clock)
		begin
			if(!reset) begin
				q <= 20'b11001110111001100001;
			end
			else if(enable ==1'b1) begin
			   if ( q == 20'd0 ) begin
					q <= 20'b11001110111001100001;
				end
				else begin
					q <= q - 1'b1;
				end
			end
		end
endmodule

module frame_counter(clock, reset, enable, q);
	input clock;
	input reset;
	input enable;
	output reg [3:0] q;
	
	always @(posedge clock)
	begin
		if(!reset) begin
			q <= 4'b1111;
		end
		else if(enable == 1'b1) begin
			if(q == 4'b0000) begin
			  q <= 4'b1111;
			end
			else begin
			  q <= q - 1'b1;
			end
		end
   end
endmodule
