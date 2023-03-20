//32bit, 2 to 1 mux
module MUX (
	input [31:0] MUX_a, 
	input [31:0] MUX_b,
	input MUX_sig,	
	output [31:0] MUX_out
	);
	assign MUX_out = (MUX_sig == 1'b0) ? MUX_a : MUX_b;

endmodule

module FourOneMUX (
	input [31:0] MUX_a, 
	input [31:0] MUX_b,
	input [31:0] MUX_c,
	input [31:0] MUX_d,
	input [1:0] MUX_sig,	
	output [31:0] MUX_out
	);

	assign MUX_out = (MUX_sig[1] == 1'b0) ? ((MUX_sig[0] == 1'b0) ? MUX_a : MUX_b) : ((MUX_sig[0] == 1'b0) ? MUX_c : MUX_d);

endmodule
