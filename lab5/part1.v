module part1(KEY, SW, HEX0, HEX1);
	input [0:0] KEY;
	input [1:0] SW;
	output [6:0] HEX0;
	output [6:0] HEX1;
	wire [7:0] CounterOut;
	
	counter MyCounter(
		.enable(SW[1]),
		.clear_b(SW[0]),
		.clock(KEY[0]),
		.q(CounterOut)
	);
	

	seven_segment_decoder H0(
		.HEX(HEX0),
		.SW(CounterOut[3:0])
	);
	seven_segment_decoder H1(
		.HEX(HEX1),
		.SW(CounterOut[7:4])
	);	
	
	
endmodule

module counter(enable, clock, clear_b, q);
	input enable, clock, clear_b;
	output [7:0] q;
	
	wire and1, and2, and3, and4, and5, and6, and7;
	
	assign and1 = q[0] & enable;
	assign and2 = q[1] & and1;
	assign and3 = q[2] & and2;
	assign and4 = q[3] & and3;
	assign and5 = q[4] & and4;
	assign and6 = q[5] & and5;
	assign and7 = q[6] & and6;
	
	MyTFF t0(
		.t(enable),
		.clk(clock),
		.reset(clear_b),
		.q(q[0])
	);
	
	MyTFF t1(
		.t(and1),
		.clk(clock),
		.reset(clear_b),
		.q(q[1])
	);
	
	MyTFF t2(
		.t(and2),
		.clk(clock),
		.reset(clear_b),
		.q(q[2])
	);
	
	MyTFF t3(
		.t(and3),
		.clk(clock),
		.reset(clear_b),
		.q(q[3])
	);
	
	MyTFF t4(
		.t(and4),
		.clk(clock),
		.reset(clear_b),
		.q(q[4])
	);
	
	MyTFF t5(
		.t(and5),
		.clk(clock),
		.reset(clear_b),
		.q(q[5])
	);
	
	MyTFF t6(
		.t(and6),
		.clk(clock),
		.reset(clear_b),
		.q(q[6])
	);
	
	MyTFF t7(
		.t(and7),
		.clk(clock),
		.reset(clear_b),
		.q(q[7])
	);
	
endmodule

module MyTFF(t, clk, reset, q);
	input t, clk, reset;
	output q;
	reg q;
	always @(posedge clk, negedge reset)
	begin
		if(reset == 1'b0)
			q <= 1'b0;
		else if(t == 1'b1)
			q <= ~q;
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