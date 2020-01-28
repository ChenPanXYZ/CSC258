module part3(SW, KEY, LEDR);
	input [9:0] SW;
	input [3:0] KEY;
	output [7:0] LEDR;
	
	wire [7:0] LoadVal;
	wire reset;
	wire Load_n;
	wire ShiftRight;
	wire ASR;
	wire clock;
	wire [7:0] q;
	
	assign LoadVal[7:0] = SW[7:0];
	assign reset = SW[9];
	assign Load_n = KEY[1];
	assign ShiftRight = KEY[2];
	assign ASR = KEY[3];
	assign clock = KEY[0];
	
	wire temp;
	
	asr a1(
		.a(ASR),
		.val(LoadVal[7]),
		.m(temp)
	);
	
	shifter s7(
		.in(temp),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clock),
		.load_val(LoadVal[7]),
		.reset_n(reset),
		.out(q[7])
	);
	
	shifter s6(
		.in(q[7]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clock),
		.load_val(LoadVal[6]),
		.reset_n(reset),
		.out(q[6])
	);
	
	shifter s5(
		.in(q[6]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clock),
		.load_val(LoadVal[5]),
		.reset_n(reset),
		.out(q[5])
	);
	
	shifter s4(
		.in(q[5]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clock),
		.load_val(LoadVal[4]),
		.reset_n(reset),
		.out(q[4])
	);
	
	shifter s3(
		.in(q[4]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clock),
		.load_val(LoadVal[3]),
		.reset_n(reset),
		.out(q[3])
	);
	
	shifter s2(
		.in(q[3]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clock),
		.load_val(LoadVal[2]),
		.reset_n(reset),
		.out(q[2])
	);
	
	shifter s1(
		.in(q[2]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clock),
		.load_val(LoadVal[1]),
		.reset_n(reset),
		.out(q[1])
	);
	
	shifter s0(
		.in(q[1]),
		.shift(ShiftRight),
		.load_n(Load_n),
		.clk(clock),
		.load_val(LoadVal[0]),
		.reset_n(reset),
		.out(q[0])
	);
	
	assign LEDR = q;
	
	
endmodule


module asr(a, val, m);
	input a;
	input val;
	output m;
	reg m;
	always @(*)
	begin
		if (a == 1'b1)
			assign m = val;
		else
			assign m = 1'b0;
	end
	
endmodule

module shifter(in, shift, load_n, clk, load_val, reset_n, out);
	input in;
	input shift;
	input load_n;
	input clk;
	input load_val;
	input reset_n;
	output out;
	
	wire d1, d2;
	
	mux2to1 m2(
		.x(out),
		.y(in),
		.s(shift),
		.m(d2)
	);
	
	mux2to1 m1(
		.x(load_val),
		.y(d2),
		.s(load_n),
		.m(d1)
	);

	flip_flop f(
		.clock(clk),
		.resetN(reset_n),
		.d(d1),
		.q(out)
	);
	
endmodule

module flip_flop(clock, resetN, d, q);
	input clock;
	input resetN;
	input d;
	output q;
	reg q;
	always @(posedge clock)
	begin
		if (resetN == 1'b0)
			q <= 1'b0;
		else
			q <= d; 
	end
endmodule

module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;

endmodule