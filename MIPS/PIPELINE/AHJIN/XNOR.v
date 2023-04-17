//32bit XNOR gate
//a == b then out == 32'hFFFFFFFF
//a != b then out != 32'hFFFFFFFF
module XNOR(a, b, out);

	input [31:0] a, b;
	output [31:0] out;

	assign out = ~(a^b);

endmodule
