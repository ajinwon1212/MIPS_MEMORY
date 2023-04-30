module IDEX_Reg (
	input CLK,					//IN
	input RESET,					//IN
	input [31:0] WB_MEM_EX_32,			//IN
	input [5:0] ID_Opcode,				//IN
	input [31:0] ID_RS_Data,			//IN
	input [31:0] ID_RT_Data,			//IN
	input [31:0] ID_Sign_extend,			//IN
	input [4:0] ID_Shmpt,				//IN
	input [5:0] ID_Funct,				//IN
	input [4:0] ID_RD,				//IN
	input [31:0] ID_PC_4,				//IN
	output reg [10:0] WB_MEM_EX,			//OUT
	output reg [5:0] EX_Opcode,			//OUT
	output reg [31:0] EX_RS_Data,			//OUT
	output reg [31:0] EX_RT_Data,			//OUT
	output reg [31:0] EX_Sign_extend,		//OUT
	output reg [4:0] EX_Shmpt,			//OUT
	output reg [5:0] EX_Funct,			//OUT
	output reg [4:0] EX_RD,				//OUT
	output reg [31:0] EX_PC_4			//OUT
);

always @(posedge CLK or posedge RESET)
begin
	if(RESET == 1'b0)
	begin
		WB_MEM_EX <= 11'b0;
		EX_Opcode <= 6'b0;
		EX_RS_Data <= 32'b0;
		EX_RT_Data <= 32'b0;
		EX_Sign_extend <= 32'b0;
		EX_Shmpt <= 5'b0;
		EX_Funct <= 6'b0;
		EX_RD <= 5'b0;
		EX_PC_4 <= 32'b0;
	end
	else
	begin
		WB_MEM_EX <= WB_MEM_EX_32[10:0];
		EX_Opcode <= ID_Opcode;
		EX_RS_Data <= ID_RS_Data;
		EX_RT_Data <= ID_RT_Data;
		EX_Sign_extend <= ID_Sign_extend;
		EX_Shmpt <= ID_Shmpt;
		EX_Funct <= ID_Funct;
		EX_RD <= ID_RD;
		EX_PC_4 <= ID_PC_4;
	end
end

endmodule
