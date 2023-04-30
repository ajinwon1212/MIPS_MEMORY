`timescale 1ps/1ps

module Top_pipe_TB();

	reg CLK, RESET;

	wire [31:0] PC;
	wire PCWrite;
	wire [31:0] PC_next;
	wire [31:0] IF_Instruction;
	wire IFIDWrite, IF_Flush;
	wire [31:0] IF_PC_4,JUMP_Addr,BTB_Addr;
	wire [31:0] ID_PC_4, ID_Instruction, ID_RS_data, ID_RT_data;
	wire CONT_1, CONT_2a, CONT_2b, DATA_1a, DATA_1b, DATA_2a, DATA_2b;
	wire [1:0] FW_sig_ID_1, FW_sig_ID_2;
	wire [31:0] ID_RS_DATA, ID_RT_DATA;
	wire Hazard_Ctrl, Branch;
	wire [1:0] Jump, RegDst;
	wire [31:0] EX_PC_4;
	wire [10:0] WB_MEM_EX;
	wire [5:0] EX_Opcode;
	wire [31:0] EX_RS_Data, EX_RT_Data, EX_Sign_extend;
	wire [1:0] FW_sig_EX_1, FW_sig_EX_2;
	wire [31:0] EX_RS_DATA, EX_RT_DATA, ALU_result, HI, LO, EX_ALU_RESULT;
	wire [31:0] MEM_PC_4;
	wire [4:0] MEM_RD;
	wire [4:0] WB_MEM;
	wire [5:0] MEM_Opcode;
	wire [31:0] MEM_ALU_RESULT;
	wire [31:0] MEM_RT_DATA, MEM_RD_DATA;
	wire [31:0] WB_PC_4;
	wire [4:0] WB_RD;
	wire [2:0] WB;
	wire [31:0] WB_ALU_RESULT, WB_RD_Data, WB_RD_DATA;

	Top_pipe TOP(
		.CLK(CLK), 
		.RESET(RESET),
		.PC(PC), 
		.PCWrite(PCWrite), 
		.PC_next(PC_next), 
		.IF_Instruction(IF_Instruction), 
		.IFIDWrite(IFIDWrite), 
		.IF_Flush(IF_Flush), 
		.IF_PC_4(IF_PC_4),
		.JUMP_Addr(JUMP_Addr), 
		.BTB_Addr(BTB_Addr),
		.ID_PC_4(ID_PC_4), 
		.ID_Instruction(ID_Instruction), 
		.ID_RS_data(ID_RS_data), 
		.ID_RT_data(ID_RT_data), 
		.FW_sig_ID_1(FW_sig_ID_1), 
		.FW_sig_ID_2(FW_sig_ID_2), 
		.ID_RS_DATA(ID_RS_DATA), 
		.ID_RT_DATA(ID_RT_DATA), 
		.Hazard_Ctrl(Hazard_Ctrl), 
		.Branch(Branch), 
		.Jump(Jump), 
		.RegDst(RegDst),
		.CONT_1(CONT_1), 
		.CONT_2a(CONT_2a), 
		.CONT_2b(CONT_2b), 
		.DATA_1a(DATA_1a), 
		.DATA_1b(DATA_1b), 
		.DATA_2a(DATA_2a), 
		.DATA_2b(DATA_2b),
		.EX_PC_4(EX_PC_4), 
		.WB_MEM_EX(WB_MEM_EX), 
		.EX_Opcode(EX_Opcode), 
		.EX_RS_Data(EX_RS_Data), 
		.EX_RT_Data(EX_RT_Data), 
		.EX_Sign_extend(EX_Sign_extend), 
		.FW_sig_EX_1(FW_sig_EX_1), 
		.FW_sig_EX_2(FW_sig_EX_2), 
		.EX_RS_DATA(EX_RS_DATA), 
		.EX_RT_DATA(EX_RT_DATA),
		.ALU_result(ALU_result), 
		.HI(HI), 
		.LO(LO), 
		.EX_ALU_RESULT(EX_ALU_RESULT),
		.MEM_PC_4(MEM_PC_4),
		.MEM_RD(MEM_RD), 
		.WB_MEM(WB_MEM), 
		.MEM_Opcode(MEM_Opcode),
		.MEM_ALU_RESULT(MEM_ALU_RESULT), 
		.MEM_RD_DATA(MEM_RD_DATA), 
		.MEM_RT_DATA(MEM_RT_DATA),
		.WB_PC_4(WB_PC_4),
		.WB_RD(WB_RD), 
		.WB(WB), 
		.WB_ALU_RESULT(WB_ALU_RESULT), 
		.WB_RD_Data(WB_RD_Data), 
		.WB_RD_DATA(WB_RD_DATA)
	);

	initial
	begin
		CLK = 1'b1;
		forever
		begin
			#100 CLK = !CLK;
		end
	end

	initial
	begin
		RESET = 1'b1; 

		#800 RESET = 1'b0; 


	end

endmodule
