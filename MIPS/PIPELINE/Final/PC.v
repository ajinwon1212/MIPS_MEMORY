module PC (
	input CLK, RESET, PCWrite,
	input [31:0] PC_next,
	output reg [31:0] PC
	);

always @(posedge RESET or posedge CLK)
begin
	if (RESET == 1'b1) begin
		PC <= 32'b0;
	end
	else
	begin 
		if (PCWrite == 1'b1)
		begin
			PC <= PC_next;
		end
		else
		begin
			PC <= PC;
		end
	end
end

endmodule
