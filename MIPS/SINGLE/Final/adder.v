module Add (
	input RESET,
	input [31:0] ADD_a, ADD_b,
	output [31:0] ADD_out

	);

	wire [30:0] cw; //for carry 
	full_adder_behavioral_module FA0(.RESET(RESET), .a(ADD_a[0]), .b(ADD_b[0]), .cin(1'b0), .sum(ADD_out[0]), .cout(cw[0]));
	full_adder_behavioral_module FA1(.RESET(RESET), .a(ADD_a[1]), .b(ADD_b[1]), .cin(cw[0]), .sum(ADD_out[1]), .cout(cw[1]));
	full_adder_behavioral_module FA2(.RESET(RESET), .a(ADD_a[2]), .b(ADD_b[2]), .cin(cw[1]), .sum(ADD_out[2]), .cout(cw[2]));
	full_adder_behavioral_module FA3(.RESET(RESET), .a(ADD_a[3]), .b(ADD_b[3]), .cin(cw[2]), .sum(ADD_out[3]), .cout(cw[3]));
	full_adder_behavioral_module FA4(.RESET(RESET), .a(ADD_a[4]), .b(ADD_b[4]), .cin(cw[3]), .sum(ADD_out[4]), .cout(cw[4]));
	full_adder_behavioral_module FA5(.RESET(RESET), .a(ADD_a[5]), .b(ADD_b[5]), .cin(cw[4]), .sum(ADD_out[5]), .cout(cw[5]));
	full_adder_behavioral_module FA6(.RESET(RESET), .a(ADD_a[6]), .b(ADD_b[6]), .cin(cw[5]), .sum(ADD_out[6]), .cout(cw[6]));
	full_adder_behavioral_module FA7(.RESET(RESET), .a(ADD_a[7]), .b(ADD_b[7]), .cin(cw[6]), .sum(ADD_out[7]), .cout(cw[7]));
	full_adder_behavioral_module FA8(.RESET(RESET), .a(ADD_a[8]), .b(ADD_b[8]), .cin(cw[7]), .sum(ADD_out[8]), .cout(cw[8]));
	full_adder_behavioral_module FA9(.RESET(RESET), .a(ADD_a[9]), .b(ADD_b[9]), .cin(cw[8]), .sum(ADD_out[9]), .cout(cw[9]));
	full_adder_behavioral_module FA10(.RESET(RESET), .a(ADD_a[10]), .b(ADD_b[10]), .cin(cw[9]), .sum(ADD_out[10]), .cout(cw[10]));
	full_adder_behavioral_module FA11(.RESET(RESET), .a(ADD_a[11]), .b(ADD_b[11]), .cin(cw[10]), .sum(ADD_out[11]), .cout(cw[11]));
	full_adder_behavioral_module FA12(.RESET(RESET), .a(ADD_a[12]), .b(ADD_b[12]), .cin(cw[11]), .sum(ADD_out[12]), .cout(cw[12]));
	full_adder_behavioral_module FA13(.RESET(RESET), .a(ADD_a[13]), .b(ADD_b[13]), .cin(cw[12]), .sum(ADD_out[13]), .cout(cw[13]));
	full_adder_behavioral_module FA14(.RESET(RESET), .a(ADD_a[14]), .b(ADD_b[14]), .cin(cw[13]), .sum(ADD_out[14]), .cout(cw[14]));
	full_adder_behavioral_module FA15(.RESET(RESET), .a(ADD_a[15]), .b(ADD_b[15]), .cin(cw[14]), .sum(ADD_out[15]), .cout(cw[15]));
	full_adder_behavioral_module FA16(.RESET(RESET), .a(ADD_a[16]), .b(ADD_b[16]), .cin(cw[15]), .sum(ADD_out[16]), .cout(cw[16]));
	full_adder_behavioral_module FA17(.RESET(RESET), .a(ADD_a[17]), .b(ADD_b[17]), .cin(cw[16]), .sum(ADD_out[17]), .cout(cw[17]));
	full_adder_behavioral_module FA18(.RESET(RESET), .a(ADD_a[18]), .b(ADD_b[18]), .cin(cw[17]), .sum(ADD_out[18]), .cout(cw[18]));
	full_adder_behavioral_module FA19(.RESET(RESET), .a(ADD_a[19]), .b(ADD_b[19]), .cin(cw[18]), .sum(ADD_out[19]), .cout(cw[19]));
	full_adder_behavioral_module FA20(.RESET(RESET), .a(ADD_a[20]), .b(ADD_b[20]), .cin(cw[19]), .sum(ADD_out[20]), .cout(cw[20]));
	full_adder_behavioral_module FA21(.RESET(RESET), .a(ADD_a[21]), .b(ADD_b[21]), .cin(cw[20]), .sum(ADD_out[21]), .cout(cw[21]));
	full_adder_behavioral_module FA22(.RESET(RESET), .a(ADD_a[22]), .b(ADD_b[22]), .cin(cw[21]), .sum(ADD_out[22]), .cout(cw[22]));
	full_adder_behavioral_module FA23(.RESET(RESET), .a(ADD_a[23]), .b(ADD_b[23]), .cin(cw[22]), .sum(ADD_out[23]), .cout(cw[23]));
	full_adder_behavioral_module FA24(.RESET(RESET), .a(ADD_a[24]), .b(ADD_b[24]), .cin(cw[23]), .sum(ADD_out[24]), .cout(cw[24]));
	full_adder_behavioral_module FA25(.RESET(RESET), .a(ADD_a[25]), .b(ADD_b[25]), .cin(cw[24]), .sum(ADD_out[25]), .cout(cw[25]));
	full_adder_behavioral_module FA26(.RESET(RESET), .a(ADD_a[26]), .b(ADD_b[26]), .cin(cw[25]), .sum(ADD_out[26]), .cout(cw[26]));
	full_adder_behavioral_module FA27(.RESET(RESET), .a(ADD_a[27]), .b(ADD_b[27]), .cin(cw[26]), .sum(ADD_out[27]), .cout(cw[27]));
	full_adder_behavioral_module FA28(.RESET(RESET), .a(ADD_a[28]), .b(ADD_b[28]), .cin(cw[27]), .sum(ADD_out[28]), .cout(cw[28]));
	full_adder_behavioral_module FA29(.RESET(RESET), .a(ADD_a[29]), .b(ADD_b[29]), .cin(cw[28]), .sum(ADD_out[29]), .cout(cw[29]));
	full_adder_behavioral_module FA30(.RESET(RESET), .a(ADD_a[30]), .b(ADD_b[30]), .cin(cw[29]), .sum(ADD_out[30]), .cout(cw[30]));
	full_adder_behavioral_module FA31(.RESET(RESET), .a(ADD_a[31]), .b(ADD_b[31]), .cin(cw[30]), .sum(ADD_out[31]), .cout(cout));

endmodule

module full_adder_behavioral_module (
	input RESET, a, b, cin,
	output reg sum, cout
	);
/*
	always@(a or b or cin)
	begin
		{cout, sum} <= a + b + cin;
	end

	always@(RESET)
	begin
		if (RESET) begin
		sum <= 1'b0; cout <=1'b0;
		end
	end
*/

	always@(*)
	begin
		if (RESET) begin sum <= 1'b0; cout <=1'b0; end
		else {cout, sum} <= a + b + cin;
	end


endmodule
