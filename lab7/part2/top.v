module datapath(ld_x, ld_y, ld_color, clock, position_data, color_data, reset, go, x, y, color);
		input ld_x, ld_y, ld_color;
		input clock;
		input [6:0] position_data;
		input [9:7] color_data;
		input reset;
		input go;
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
			counter1 <= 2'b00;
			counter2 <= 2'b00;
        end
        else begin
            if (ld_x)
                x_orgin <= {1'b0, position_data}; // load alu_out if load_alu_out signal is high, otherwise load from data_in
            if (ld_y)
                y_orgin <= position_data; // load alu_out if load_alu_out signal is high, otherwise load from data_in
            if (ld_color)
                color <= color_data;
        end
    end
	
	// draw 4 * 4
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

module control(clock, reset, go, start_drawing, data_path_go, writeEn, ld_x, ld_y, ld_color);
    input clock;
    input reset;
    input go;
	input start_drawing;
	
	output reg data_path_go;
	output reg writeEn;
	output reg ld_x, ld_y, ld_color;

    reg [2:0] current_state, next_state; 
    
    localparam  S_LOAD_X        = 3'b000,
                S_LOAD_X_WAIT   = 3'b001,
                S_LOAD_Y        = 3'b010,
                S_LOAD_Y_WAIT   = 3'b011,
                S_DRAW       = 3'b100;
    
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
            case (current_state)
                S_LOAD_X: next_state = go ? S_LOAD_X_WAIT : S_LOAD_X; // Loop in current state until value is input
                S_LOAD_X_WAIT: next_state = go ? S_LOAD_X_WAIT : S_LOAD_Y; // Loop in current state until go signal goes low
                S_LOAD_Y: next_state = go ? S_LOAD_Y_WAIT : S_LOAD_Y; // Loop in current state until value is input
                S_LOAD_Y_WAIT: next_state = start_drawing ? S_LOAD_Y_WAIT : S_DRAW; // Loop in current state until go signal goes low
				S_DRAW: next_state = go ? S_LOAD_X : S_DRAW;
            default: next_state = S_LOAD_X;
        endcase
    end // state_table
	
    // Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
		ld_x = 1'b0;
		ld_y = 1'b0;
		ld_color = 1'b0;
		data_path_go = 1'b0;
		writeEn = 1'b0;
        case (current_state)
            S_LOAD_X: begin
				ld_x = 1'b1;
				ld_color = 1'b1;
				data_path_go = 1;
                end
            S_LOAD_Y: begin
				ld_y = 1'b1;
				ld_color = 1'b1;
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
            current_state <= S_LOAD_X;
        else
            current_state <= next_state;
    end // state_FFS
endmodule



module top(clock, reset, go, start_drawing, color_data, x, y, color);

	input clock;
	input reset;
	input go;
	input start_drawing;
	input [2:0] color_data;
	
	output [7:0] x;
	output [6:0] y;
	output [2:0] color;
	
	
	wire ld_x, ld_y, ld_color, writeEn, data_path_go;
	
	
	control c(
		.clock(clock),
		.reset(reset),
		.go(go),
		.start_drawing(start_drawing),
		.data_path_go(data_path_go),
		.writeEn(writeEn),
		.ld_x(ld_x),
		.ld_y(ld_y),
		.ld_color(ld_color)
	);

	datapath d(
		.ld_x(ld_x),
		.ld_y(ld_y),
		.ld_color(ld_color),
		.clock(clock),
		.position_data(position_data),
		.color_data(color_data),
		.reset(reset),
		.go(data_path_go),
		.x(x),
		.y(y),
		.color(color)
	);
endmodule