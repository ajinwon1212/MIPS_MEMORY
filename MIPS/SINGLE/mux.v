//32bit, 2 to 1 mux
module MUX (
	input [31:0] MUX_a, 
	input [31:0] MUX_b,
	input MUX_sig,	
	output [31:0] MUX_out
	);
	assign MUX_out = (MUX_sig == 1'b0) ? MUX_a : MUX_b;

endmodule

