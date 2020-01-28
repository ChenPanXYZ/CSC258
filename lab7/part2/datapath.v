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