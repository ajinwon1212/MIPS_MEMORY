module ADD (

	input [31:0] a, b,
	output [31:0] out

	);

	wire [30:0] cw; //for carry 
	full_adder_behavioral_module FA0(.a(a[0]), .b(b[0]), .cin(1'b0), .sum(out[0]), .cout(cw[0]));
	full_adder_behavioral_module FA1(.a(a[1]), .b(b[1]), .cin(cw[0]), .sum(out[1]), .cout(cw[1]));
	full_adder_behavioral_module FA2(.a(a[2]), .b(b[2]), .cin(cw[1]), .sum(out[2]), .cout(cw[2]));
	full_adder_behavioral_module FA3(.a(a[3]), .b(b[3]), .cin(cw[2]), .sum(out[3]), .cout(cw[3]));
	full_adder_behavioral_module FA4(.a(a[4]), .b(b[4]), .cin(cw[3]), .sum(out[4]), .cout(cw[4]));
	full_adder_behavioral_module FA5(.a(a[5]), .b(b[5]), .cin(cw[4]), .sum(out[5]), .cout(cw[5]));
	full_adder_behavioral_module FA6(.a(a[6]), .b(b[6]), .cin(cw[5]), .sum(out[6]), .cout(cw[6]));
	full_adder_behavioral_module FA7(.a(a[7]), .b(b[7]), .cin(cw[6]), .sum(out[7]), .cout(cw[7]));
	full_adder_behavioral_module FA8(.a(a[8]), .b(b[8]), .cin(cw[7]), .sum(out[8]), .cout(cw[8]));
	full_adder_behavioral_module FA9(.a(a[9]), .b(b[9]), .cin(cw[8]), .sum(out[9]), .cout(cw[9]));
	full_adder_behavioral_module FA10(.a(a[10]), .b(b[10]), .cin(cw[9]), .sum(out[10]), .cout(cw[10]));
	full_adder_behavioral_module FA11(.a(a[11]), .b(b[11]), .cin(cw[10]), .sum(out[11]), .cout(cw[11]));
	full_adder_behavioral_module FA12(.a(a[12]), .b(b[12]), .cin(cw[11]), .sum(out[12]), .cout(cw[12]));
	full_adder_behavioral_module FA13(.a(a[13]), .b(b[13]), .cin(cw[12]), .sum(out[13]), .cout(cw[13]));
	full_adder_behavioral_module FA14(.a(a[14]), .b(b[14]), .cin(cw[13]), .sum(out[14]), .cout(cw[14]));
	full_adder_behavioral_module FA15(.a(a[15]), .b(b[15]), .cin(cw[14]), .sum(out[15]), .cout(cw[15]));
	full_adder_behavioral_module FA16(.a(a[16]), .b(b[16]), .cin(cw[15]), .sum(out[16]), .cout(cw[16]));
	full_adder_behavioral_module FA17(.a(a[17]), .b(b[17]), .cin(cw[16]), .sum(out[17]), .cout(cw[17]));
	full_adder_behavioral_module FA18(.a(a[18]), .b(b[18]), .cin(cw[17]), .sum(out[18]), .cout(cw[18]));
	full_adder_behavioral_module FA19(.a(a[19]), .b(b[19]), .cin(cw[18]), .sum(out[19]), .cout(cw[19]));
	full_adder_behavioral_module FA20(.a(a[20]), .b(b[20]), .cin(cw[19]), .sum(out[20]), .cout(cw[20]));
	full_adder_behavioral_module FA21(.a(a[21]), .b(b[21]), .cin(cw[20]), .sum(out[21]), .cout(cw[21]));
	full_adder_behavioral_module FA22(.a(a[22]), .b(b[22]), .cin(cw[21]), .sum(out[22]), .cout(cw[22]));
	full_adder_behavioral_module FA23(.a(a[23]), .b(b[23]), .cin(cw[22]), .sum(out[23]), .cout(cw[23]));
	full_adder_behavioral_module FA24(.a(a[24]), .b(b[24]), .cin(cw[23]), .sum(out[24]), .cout(cw[24]));
	full_adder_behavioral_module FA25(.a(a[25]), .b(b[25]), .cin(cw[24]), .sum(out[25]), .cout(cw[25]));
	full_adder_behavioral_module FA26(.a(a[26]), .b(b[26]), .cin(cw[25]), .sum(out[26]), .cout(cw[26]));
	full_adder_behavioral_module FA27(.a(a[27]), .b(b[27]), .cin(cw[26]), .sum(out[27]), .cout(cw[27]));
	full_adder_behavioral_module FA28(.a(a[28]), .b(b[28]), .cin(cw[27]), .sum(out[28]), .cout(cw[28]));
	full_adder_behavioral_module FA29(.a(a[29]), .b(b[29]), .cin(cw[28]), .sum(out[29]), .cout(cw[29]));
	full_adder_behavioral_module FA30(.a(a[30]), .b(b[30]), .cin(cw[29]), .sum(out[30]), .cout(cw[30]));
	full_adder_behavioral_module FA31(.a(a[31]), .b(b[31]), .cin(cw[30]), .sum(out[31]), .cout(cout));

endmodule

module full_adder_behavioral_module (
	input a, b, cin,
	output reg sum, cout
	);

	always@(a or b or cin)
	begin
		{cout, sum} <= a + b + cin;
	end

endmodule
