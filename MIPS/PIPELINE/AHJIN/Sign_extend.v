module Sign_extend(Sign_extend_in, Sign_extend);
	input [15:0] Sign_extend_in;
	output [31:0] Sign_extend;

	assign Sign_extend = (Sign_extend_in[15]) ? {16'hffff, Sign_extend_in} : {16'h0000,Sign_extend_in} ;

endmodule
