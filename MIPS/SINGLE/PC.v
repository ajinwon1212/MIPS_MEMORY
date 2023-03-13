module PC (
	input CLK, RESET,
	input [31:0] PC_next,
	output [31:0] PC
	);

always @(posedge rst or posedge clk) begin
	if (rst == 1'b1) begin
		PC <= 8'b0;
	end
	else begin
		PC <= PC_NEXT;
	end

endmodule
