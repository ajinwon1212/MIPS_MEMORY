//32bit, 2 to 1 mux
module MUX2to1 (
	input [31:0] a, 
	input [31:0] b,
	input sig,	
	output [31:0] out
	);
	assign out = (sig == 1'b0) ? a : b;

endmodule

module MUX4to1 (
	input [31:0] a, 
	input [31:0] b,
	input [31:0] c,
	input [31:0] d,
	input [1:0] sig,	
	output [31:0] out
	);

	assign out = (sig[1] == 1'b0) ? ((sig[0] == 1'b0) ? a : b) : ((sig[0] == 1'b0) ? c : d);

endmodule
