`timescale 1ns / 1ns  

module Sign_extend_TB;

	reg [15:0] IN;
	wire [31:0] Sign_extend;

	Sign_extend Sign_extend_top(
		.Sign_extend_in(IN),	//IN
		.Sign_extend(Sign_extend)		//OUT
	);

	initial
	begin
		IN = 16'h0000;
		#20 IN = 16'hffff; 
		#20 IN = 16'h000f;
	end

	always@(*)
	begin
	$display($time);
	$display("IN : %h, Sign_extend : %h", IN, Sign_extend);
	$display(" ");
	end

endmodule
