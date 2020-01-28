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