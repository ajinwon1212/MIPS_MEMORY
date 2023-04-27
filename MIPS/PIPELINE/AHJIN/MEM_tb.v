module MEM_tb();

reg CLK;
reg RESET;
reg [10:0] WB_MEM_EX;
reg [5:0] EX_Opcode;
reg [31:0] EX_ALU_RESULT;
reg [31:0] EX_RT_DATA;
reg [4:0] EX_RD;
//reg [31:0] EX_PC_4;

wire [4:0] WB_MEM;
wire [5:0] MEM_Opcode;
wire [31:0] MEM_ALU_RESULT;
wire [31:0] MEM_RT_DATA;
wire [4:0] MEM_RD;
//wire [31:0] MEM_PC_4;
wire [31:0] Read_data;

EXMEM_Reg EXMEM_Reg_test(.CLK(CLK),.RESET(RESET),.WB_MEM_EX(WB_MEM_EX),.EX_Opcode(EX_Opcode),.EX_ALU_RESULT(EX_ALU_RESULT),.EX_RT_DATA(EX_RT_DATA),.EX_RD(EX_RD),
.EX_PC_4(EX_PC_4),.WB_MEM(WB_MEM),.MEM_Opcode(MEM_Opcode),.MEM_ALU_RESULT(MEM_ALU_RESULT),.MEM_RT_DATA(MEM_RT_DATA),.MEM_RD(MEM_RD),.MEM_PC_4(MEM_PC_4));

Data_memory Data_memory_test(.CLK(CLK),.RESET(RESET),.Address(MEM_ALU_RESULT),.Write_Data(MEM_RT_DATA),.MemWrite(WB_MEM[0]),.MemRead(WB_MEM[1]),
.Read_data(Read_data));

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
	RESET = 1'b1;	//10001111101100000000000000000000	lw
	WB_MEM_EX = 11'b01110000100;
	EX_Opcode = 6'b100011;
	EX_ALU_RESULT = 32'd4;
	EX_RT_DATA = 32'd30;
	EX_RD = 5'd0;
	//EX_PC_4 = 32'd0;

	#30
	RESET = 1'b0;	//10001111101100000000000000000000	lw
	WB_MEM_EX = 11'b01110000100;
	EX_Opcode = 6'b100011;
	EX_ALU_RESULT = 32'd4;
	EX_RT_DATA = 32'd40;
	EX_RD = 5'd0;
	//EX_PC_4 = 32'd0;

	#20		//10101111101100110000000000001100	sw
	WB_MEM_EX = 11'b00001000100;
	EX_Opcode = 6'b101011;
	EX_ALU_RESULT = 32'd8;
	EX_RT_DATA = 32'd50;
	EX_RD = 5'd0;
	//EX_PC_4 = 32'd4;

	#20		//00100000000100000000000000001000	addi
	WB_MEM_EX = 11'b00100000100;
	EX_Opcode = 6'b001000;
	EX_ALU_RESULT = 32'd20;
	EX_RT_DATA = 32'd60;
	EX_RD = 5'd0;
	//EX_PC_4 = 32'd8;

end

endmodule
