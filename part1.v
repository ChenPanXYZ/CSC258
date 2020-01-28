module part1(q, s, x, y, a, b, c, d);
	input [31:0] x, y;
	input s;
	output reg [31:0] q;
	output reg a, b, c, d;
	
	always @(*)
		begin
			{a, q} <= x + y;
		end
endmodule