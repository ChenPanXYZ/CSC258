module adder(SW, LEDR);
// I am not sure here whether we should use A, B, S, cout, cin instead of SW and LEDR.
    input [8:0] SW;
    output [4:0] LEDR;

    wire c1;
    wire c2;
	wire c3;
	
    full_adder fa1(
        .cin(SW[0]),
        .A(SW[1]),
        .B(SW[5]),
		.S(LEDR[0]),
        .cout(c1)
        );
		
    full_adder fa2(
        .cin(c1),
        .A(SW[2]),
        .B(SW[6]),
		.S(LEDR[1]),
        .cout(c2)
        );
		
    full_adder fa3(
        .cin(c2),
        .A(SW[3]),
        .B(SW[7]),
		.S(LEDR[2]),
        .cout(c3)
        );
		
    full_adder fa4(
        .cin(c3),
        .A(SW[4]),
        .B(SW[8]),
		.S(LEDR[3]),
        .cout(LEDR[4])
        );
endmodule

module full_adder(cin, A, B, cout, S);
    input cin; //selected when s is 0
    input A; //selected when s is 1
    input B; //select signal
	output S;
    output cout; //output
	
	assign S = A ^ B ^ cin;
	assign cout = (A & B) | (cin & (A^B));

endmodule
