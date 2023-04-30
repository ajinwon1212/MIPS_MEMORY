module IFID_Reg(
	input CLK, RESET,
	input IFIDWrite,
	input [31:0] IF_Instruction,
	input IF_Flush,
	input [31:0] IF_PC_4,
	output reg [31:0] ID_Instruction,
	output reg [31:0] ID_PC_4,
	output reg FLUSH
	);

always @(posedge CLK or posedge RESET)
begin
	if (RESET == 1'b1)
	begin
		ID_Instruction <= 32'b0;
		ID_PC_4 <= 32'b0;
		FLUSH <= 1'b0;
	end
	else
	begin
		if (IF_Flush == 1'b1)
		begin
			ID_Instruction <= 32'b0;
			ID_PC_4 <= 32'b0;
			FLUSH <= 1'b1;
		end
		else
		begin
			if (IFIDWrite == 1'b1)
			begin
				ID_Instruction <= IF_Instruction;
				ID_PC_4 <= IF_PC_4;
				FLUSH <= 1'b0;
			end
			else
			begin
				ID_Instruction <= ID_Instruction;
				ID_PC_4 <= ID_PC_4;
				FLUSH <= 1'b0;
			end
		end
	end
end

endmodule
