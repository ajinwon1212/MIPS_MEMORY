module Shift_left_2 (
	input [31:0] Sign_extend,
	output [31:0] Shift_left_2_OUT
	);

	assign Shift_left_2_OUT = Sign_extend << 2;

endmodule