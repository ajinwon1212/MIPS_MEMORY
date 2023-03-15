module PC (
	input CLK, RESET,
	input [31:0] PC_next,
	output reg [31:0] PC
	);

always @(posedge RESET or posedge CLK) begin
	if (RESET == 1'b1) begin
		PC <= 32'b0;
	end
	else begin
		PC <= PC_next;
	end
end

endmodule
