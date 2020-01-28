module part3(SW, KEY, CLOCK_50, LEDR);
	input [2:0] SW;
	input [1:0] KEY;
	input CLOCK_50;
	output [0:0] LEDR;
	wire [11:0] LUTOut;
	wire enable;
	wire [24:0] myRateCounterOut;
	wire [11:0] out;
	
	LUT myLUT(
		.charId(SW),
		.binaryExpression(LUTOut)
	);
	
	rateCounter myRateCounter(
		.d(25'd24999999),
		.clock(CLOCK_50),
		.par_load(KEY[0]),
		.q(myRateCounterOut)
	);
	
	assign enable = ( myRateCounterOut == 25'd00000000 ) ? 1 : 0 ;
	
	
	shifter myShifter(
		.value(LUTOut),
		.enable(enable),
		.load(KEY[1]),
		.reset(KEY[0]),
		.CLOCK_50(CLOCK_50),
		.q(out)
	);
	
	assign LEDR[0] = out[0];
endmodule

module LUT(charId, binaryExpression);
	input [2:0] charId;
	output [11:0] binaryExpression;
	
	reg [11:0] binaryExpression;
	
	always @(*)
	begin
		case (charId[2:0])
			3'b000: binaryExpression = 12'b101110000000;//A
			3'b001: binaryExpression = 12'b111010101000;//B
			3'b010: binaryExpression = 12'b111010111010;//C
			3'b011: binaryExpression = 12'b111010100000;//D
			3'b100: binaryExpression = 12'b100000000000;//E
			3'b101: binaryExpression = 12'b101011101000;//F
			3'b110: binaryExpression = 12'b111011101000;//G
			3'b111: binaryExpression = 12'b101010100000;//H
			default: binaryExpression = 12'b101110000000;//A
		endcase
	end
endmodule

module rateCounter(d, clock, par_load, q);
	input [24:0] d;
	input clock;
	input par_load;
	output q;
	reg [24:0] q;
	
	always @(posedge clock)
	begin
		if(par_load == 1'b1)
			q <= d;
		else if (q == 25'd00000000)
			q <= d;
		else
			q <= q - 25'd00000001;
	end
endmodule

module shifter(value, enable, load, reset, CLOCK_50, q);
	input [11:0] value;
	input enable;
	input load;
	input reset;
	input CLOCK_50;
	output [11:0] q;
	
	reg [11:0] q;
	
	always @(posedge CLOCK_50, posedge reset)
	begin
		if (reset == 1'b1)
			q <= 12'b000000000000;
		else if (load == 1'b1)
			q <= value;
		else if (enable == 1'b1)
			q <= q << 1'b1;
	end	
endmodule