module ALU(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input[7:0] SW;
	input [2:0] KEY;
	output [7:0] LEDR;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	output [6:0] HEX4;
	output [6:0] HEX5;
	reg [7:0] ALUout;
	
	wire [7:0] case1, case2, case3, case4, case5, case6;
	
	assign case1 = {SW[7:4], SW[3:0]};
	assign case2 = {SW[7:4] | SW[3:0], SW[7:4] ^ SW[3:0]};
	adder for_case3 (
		.AA(SW[7:4]),
		.BB(SW[3:0]),
		.SS(case3)
	);
	assign case4 = SW[7:4] + SW[3:0];
	assign case5 = SW[7:4] + 4'b0001;
	assign case6 = {7'b0000000, SW[7:4] || SW[3:0]};
	
	always @(*)
	begin
		case (KEY[2:0])
			3'b000: ALUout = case1;
			3'b001: ALUout = case2;
			3'b010: ALUout = case3;
			3'b011: ALUout = case4;
			3'b100: ALUout = case5;
			3'b101: ALUout = case6;
			default: ALUout = case1;
		endcase
	end
	assign LEDR = ALUout;
	
	//Have HEX0 and HEX2 display the valuts of B(SW[3:0]) and A(SW[7:4]).
	seven_segment_decoder H0(
		.HEX(HEX0),
		.SW(SW[3:0])
	);
	seven_segment_decoder H2(
		.HEX(HEX2),
		.SW(SW[7:4])
	);

	//set HEX1 and HEX3 to 0
	seven_segment_decoder H1(
		.HEX(HEX1),
		.SW(4'b0000)
	);
	seven_segment_decoder H3(
		.HEX(HEX3),
		.SW(4'b0000)
	);
	seven_segment_decoder H4(
		.HEX(HEX4[6:0]),
		.SW(ALUout[3:0])
	);
	seven_segment_decoder H5(
		.HEX(HEX5[6:0]),
		.SW(ALUout[7:4])
	);
endmodule


module adder(AA, BB, SS);
    input [3:0] AA;
	input [3:0] BB;
    output [7:0] SS;

    wire c1;
    wire c2;
	wire c3;
	
    full_adder fa1(
        .cin(1'b0),
        .A(AA[0]),
        .B(BB[0]),
		.S(SS[0]),
        .cout(c1)
        );
		
    full_adder fa2(
        .cin(c1),
        .A(AA[1]),
        .B(BB[1]),
		.S(SS[1]),
        .cout(c2)
        );
		
    full_adder fa3(
        .cin(c2),
        .A(AA[2]),
        .B(BB[2]),
		.S(SS[2]),
        .cout(c3)
        );
		
    full_adder fa4(
        .cin(c3),
        .A(AA[3]),
        .B(BB[3]),
		.S(SS[3]),
        .cout(SS[4])
        );
	
	assign SS[7:5] = 3'b000;
endmodule

module full_adder(cin, A, B, S, cout);
    input cin; //selected when s is 0
    input A; //selected when s is 1
    input B; //select signal
	output S;
    output cout; //output
	
	assign S = A ^ B ^ cin;
	assign cout = (A & B) | (cin & (A^B));

endmodule


//seven_segment_decoder module
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