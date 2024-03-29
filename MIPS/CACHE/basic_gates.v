module and_gate (
	input a, b,
	output out
	);
	assign out = a & b;

endmodule

module or_gate (
	input a, b,
	output out
	);
	assign out = a || b;	

endmodule

module not_gate (
	input a,
	output out
	);
	assign out = !a;

endmodule

module AND (
	input AND_a, AND_b,
	output AND_out
	);

	assign AND_out = AND_a & AND_b;

endmodule

module xor_gate (a, b, out);

	input a, b;

	output out;

	assign out = ((!a) && b) || (a && (!b));

endmodule
