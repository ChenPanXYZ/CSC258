module part2(SW, CLOCK_50, HEX0);
	input[3:0] SW;
	input CLOCK_50;
	output [6:0] HEX0;
	
	reg [27:0] rateValue;
	wire [27:0] rateCounterOutput;
	wire incrementOrNot;
	wire [3:0] out;
	
	always@(*)
	begin
		case (SW[1:0])
			2'b00: rateValue = 28'd000000000;
			2'b01: rateValue = 28'd049999999;
			2'b10: rateValue = 28'd099999999;
			2'b11: rateValue = 28'd199999999;
			default: rateValue = 28'd000000000;
		endcase
	end
	
	rateCounter myRateCounter(
		.d(rateValue),
		.clock(CLOCK_50),
		.par_load(SW[2]),
		.q(rateCounterOutput)
	);
	
	assign incrementOrNot = ( rateCounterOutput == 28'd000000000 ) ? 1 : 0 ;
	displayCounter myDisplayCounter(
		.clock(CLOCK_50),
		.reset_n(SW[3]),
		.enable(incrementOrNot),
		.q(out)
	);
	
	seven_segment_decoder H0(
		.HEX(HEX0),
		.SW(out[3:0])
	);
endmodule

module rateCounter(d, clock, par_load, q);
	input [27:0] d;
	input clock;
	input par_load;
	output q;
	reg [27:0] q;
	
	always @(posedge clock)
	begin
		if(par_load == 1'b1)
			q <= d;
		else if (q == 28'd000000000)
			q <= d;
		else
			q <= q - 28'd000000001;
	end
endmodule

module displayCounter(clock, reset_n, enable, q);
	input clock;
	input reset_n;
	input enable;
	
	output q;
	reg [3:0] q;
	
	always @(posedge clock)
	begin
		if (reset_n == 1'b0)
			q <= 0;
		else if(enable == 1)
			begin
				if (q == 4'b1111)
					q <= 0;
				else
					q <= q + 1'b1;
			end
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