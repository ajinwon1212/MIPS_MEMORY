module PC (
	input CLK, RESET, PCWrite,
	input [31:0] IF_PC_4,
	output reg [31:0] PC
	);

always @(posedge RESET or posedge CLK)
begin
	if (RESET == 1'b1) begin
		PC <= 32'b0;
	end
	else
	begin 
		if (PCWrite == 1'b0)
		begin
			PC <= IF_PC_4;
		end
		else
		begin
			PC <= PC;
		end
	end
end

endmodule
