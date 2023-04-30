module BTB_tb();

reg CLK, RESET;
reg [31:0] PC_4, IF_Instruction;

wire [31:0] Branch_Addr;

Branch_Target_Buffer BTB(.CLK(CLK), .RESET(RESET), .PC_4(PC_4), .IF_Instruction(IF_Instruction), .Branch_Addr(Branch_Addr));

initial
begin
	CLK = 1'b0;
	forever
	begin
		#10 CLK = !CLK;
	end
end

initial
begin
	PC_4 = 32'b11100000000000000000000000001100;
	IF_Instruction = 32'b00000000000000011111111111111010;

	#70
	PC_4 = 32'b11100000000000000000000000000000;
	IF_Instruction = 32'b00000000000000011111111111111000;
	
	#40
	PC_4 = 32'b00100010101000000000000000000000;
	IF_Instruction = 32'b10100000000000000100000000000110;
end

endmodule
