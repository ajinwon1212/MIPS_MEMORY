module IFID_Reg(
	input CLK, RESET, CCLK,
	input IFIDWrite,
	input [31:0] IF_Instruction,
	input IF_Flush,
	input [31:0] IF_PC_4,
	output reg [31:0] ID_INSTRUCTION,
	output reg [31:0] ID_PC_4,
	output reg FLUSH,
	output reg [2:0] TYPE
	);

	reg [31:0] ID_Instruction;
	reg [31:0] id_pc_4;
	reg flush;


always @(posedge CCLK or posedge RESET or posedge IF_Flush)
begin
	if (RESET == 1'b1)
	begin
		ID_Instruction <= 32'b0;
		id_pc_4 <= 32'b0;
		flush <= 1'b0;
		TYPE <= 3'd1;
	end
	else
	begin
		if (IF_Flush == 1'b1)
		begin
			ID_Instruction <= 32'b0;
			id_pc_4 <= 32'b0;
			flush <= 1'b1;
			TYPE <= 3'd2;
		end
		//else
		//begin
			else if (IFIDWrite == 1'b1)
			begin
				ID_Instruction <= IF_Instruction;
				id_pc_4 <= IF_PC_4;
				flush <= 1'b0;
				TYPE <= 3'd3;
			end
			else
			begin
				ID_Instruction <= ID_Instruction;
				id_pc_4 <= id_pc_4;
				flush <= 1'b0;
				TYPE <= 3'd4;
			end
		//end
	end
end

always@(posedge CLK or posedge RESET) begin
		if (RESET == 1'b1)
		begin
			ID_INSTRUCTION <= 32'b0;
			ID_PC_4 <= 32'b0;
			FLUSH <= 1'b0;
			//TYPE <= 3'd1;
		end
		else if (IF_Flush == 1'b1)
		begin
			ID_INSTRUCTION <= 32'b0;
			ID_PC_4 <= 32'b0;
			FLUSH <= 1'b1;
		end
		else begin
			ID_INSTRUCTION <= ID_Instruction;
			ID_PC_4 <= id_pc_4;
			FLUSH <= 1'b0;
		end
end


endmodule
