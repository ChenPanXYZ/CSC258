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