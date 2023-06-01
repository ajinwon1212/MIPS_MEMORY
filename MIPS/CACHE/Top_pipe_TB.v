`timescale 1ps/1ps

module Top_pipe_TB();

	reg CLK, RESET;

	wire [31:0] PC_1, PC_2, PC_3, PC_4, PC_5, PC_6,PC_7,PC_8;
	//wire PCWrite;
	wire [31:0] PC_next_1, PC_next_2, JUMP_Addr_1, JUMP_Addr_2, BTB_Addr_1, BTB_Addr_2;
	wire PCWRITE_JUMP_1, PCWRITE_JUMP_2;
	wire [31:0] ID_PC_4_1, ID_PC_4_2;
	//wire PCLK;

	wire HitWrite_1, HitWrite_2, HitWrite_3, HitWrite_4, HitWrite_5, HitWrite_6, HitWrite_7, HitWrite_8;
        wire Access_MM_1, Access_MM_2, Access_MM_3, Access_MM_4, Access_MM_5, Access_MM_6, Access_MM_7, Access_MM_8;
        wire [31:0] Data_MM_1, Data_MM_3, Data_MM_4, Data_MM_5, Data_MM_6;
	wire [63:0] Data_MM_2,Data_MM_7,Data_MM_8;
        wire [19:0] CNT_HIT_1, CNT_HIT_2, CNT_HIT_3, CNT_HIT_4, CNT_HIT_5, CNT_HIT_6,CNT_HIT_7,CNT_HIT_8; 
	wire [19:0] CNT_MISS_1, CNT_MISS_2, CNT_MISS_3, CNT_MISS_4, CNT_MISS_5, CNT_MISS_6, CNT_MISS_7, CNT_MISS_8;
	//wire [1:0] CONT;
	//wire CCLK;
	wire [31:0] IF_Instruction_1, IF_Instruction_2, IF_Instruction_3, IF_Instruction_4, IF_Instruction_5, IF_Instruction_6, IF_Instruction_7, IF_Instruction_8;
	//wire [2:0] TYPE;
	//wire IFIDWrite, IF_Flush;
	//wire [31:0] IF_PC_4,JUMP_Addr,BTB_Addr;
	
	//wire [31:0]  ID_Instruction, ID_RS_data, ID_RT_data;
	////wire CONT_1, CONT_2a, CONT_2b, DATA_1a, DATA_1b, DATA_2a, DATA_2b;
	//wire CONT_1, CONT_2a, CONT_2b, DATA_1a, DATA_2a;
	//wire [1:0] FW_sig_ID_1, FW_sig_ID_2;
	//wire [31:0] ID_RS_DATA, ID_RT_DATA;
	///wire Hazard_Ctrl, Branch;
	//wire [1:0] Jump, RegDst;
	wire [31:0] EX_PC_4_1, EX_PC_4_2, EX_PC_4_3, EX_PC_4_4, EX_PC_4_5, EX_PC_4_6, EX_PC_4_7, EX_PC_4_8;
	//wire [10:0] WB_MEM_EX;
	//wire [5:0] EX_Opcode;
	//wire [31:0] EX_RS_Data, EX_RT_Data, EX_Sign_extend, EX_RT_Data_FW;
	//wire [1:0] FW_sig_EX_1, FW_sig_EX_2, FW_sig_EX_3;
	//wire [31:0] EX_RS_DATA, EX_RT_DATA, ALU_result; 
	wire [31:0] HI_1, HI_2, HI_3, HI_4, HI_5, HI_6, HI_7, HI_8;
	wire [31:0] LO_1, LO_2, LO_3, LO_4, LO_5, LO_6, LO_7, LO_8;
	wire [31:0] EX_ALU_RESULT_1, EX_ALU_RESULT_2, EX_ALU_RESULT_3, EX_ALU_RESULT_4, EX_ALU_RESULT_5, EX_ALU_RESULT_6, EX_ALU_RESULT_7, EX_ALU_RESULT_8;
	//wire [31:0] MEM_PC_4;
	//wire [4:0] MEM_RD;
	//wire [4:0] WB_MEM;
	//wire [5:0] MEM_Opcode;
	//wire [31:0] MEM_ALU_RESULT;
	//wire [31:0] MEM_RT_DATA, MEM_RD_DATA;
	//wire [31:0] WB_PC_4;
	//wire [4:0] WB_RD;
	//wire [2:0] WB;
	//wire [31:0] WB_ALU_RESULT, WB_RD_Data, WB_RD_DATA;

	Top_pipe_CACHE_1 Direct_1word(
		.CLK(CLK), 
		.RESET(RESET),
		.PC(PC_1), 
		.PCWrite(),.PC_next(PC_next_1), 
		.IF_Instruction(IF_Instruction_1), 
		.IFIDWrite(), .IF_Flush(), .IF_PC_4(),.JUMP_Addr(JUMP_Addr_1), .BTB_Addr(BTB_Addr_1),.ID_PC_4(ID_PC_4_1), .ID_Instruction(), .ID_RS_data(), .ID_RT_data(), .FW_sig_ID_1(), .FW_sig_ID_2(), .ID_RS_DATA(), .ID_RT_DATA(), .Hazard_Ctrl(), .Branch(), .Jump(), .RegDst(),.CONT_1(),.CONT_2a(), .CONT_2b(), .DATA_1a(), .DATA_2a(), 
		.EX_PC_4(EX_PC_4_1), 
		.WB_MEM_EX(), .EX_Opcode(), .EX_RS_Data(), .EX_RT_Data(), .EX_Sign_extend(), .FW_sig_EX_1(), .FW_sig_EX_2(), .FW_sig_EX_3(), .EX_RS_DATA(), .EX_RT_DATA(),.EX_RT_Data_FW(),.ALU_result(), 
		.HI(HI_1), 
		.LO(LO_1), 
		.EX_ALU_RESULT(EX_ALU_RESULT_1),
		.MEM_PC_4(),.MEM_RD(),.WB_MEM(),.MEM_Opcode(), .MEM_ALU_RESULT(),.MEM_RD_DATA(),.MEM_RT_DATA(), .WB_PC_4(), .WB_RD(), .WB(), .WB_ALU_RESULT(), .WB_RD_Data(), .WB_RD_DATA(),
		.PCWRITE_JUMP(PCWRITE_JUMP_1),
		.HitWrite(HitWrite_1), 
		.Access_MM(Access_MM_1), 
		.Data_MM(Data_MM_1), 
		.CNT_HIT(CNT_HIT_1), 
		.CNT_MISS(CNT_MISS_1), 
		.CONT(), .TYPE(), .PCLK(), .CCLK()
	);

	Top_pipe_CACHE_2 Direct_2word(
		.CLK(CLK), 
		.RESET(RESET),
		.PC(PC_2), 
		.PCWrite(),.PC_next(PC_next_2), 
		.IF_Instruction(IF_Instruction_2), 
		.IFIDWrite(), .IF_Flush(), .IF_PC_4(),.JUMP_Addr(JUMP_Addr_2), .BTB_Addr(BTB_Addr_2),.ID_PC_4(ID_PC_4_2), .ID_Instruction(), .ID_RS_data(), .ID_RT_data(), .FW_sig_ID_1(), .FW_sig_ID_2(), .ID_RS_DATA(), .ID_RT_DATA(), .Hazard_Ctrl(), .Branch(), .Jump(), .RegDst(),.CONT_1(),.CONT_2a(), .CONT_2b(), .DATA_1a(), .DATA_2a(), 
		.EX_PC_4(EX_PC_4_2), 
		.WB_MEM_EX(), .EX_Opcode(), .EX_RS_Data(), .EX_RT_Data(), .EX_Sign_extend(), .FW_sig_EX_1(), .FW_sig_EX_2(), .FW_sig_EX_3(), .EX_RS_DATA(), .EX_RT_DATA(),.EX_RT_Data_FW(),.ALU_result(), 
		.HI(HI_2), 
		.LO(LO_2), 
		.EX_ALU_RESULT(EX_ALU_RESULT_2),
		.MEM_PC_4(),.MEM_RD(),.WB_MEM(),.MEM_Opcode(), .MEM_ALU_RESULT(),.MEM_RD_DATA(),.MEM_RT_DATA(), .WB_PC_4(), .WB_RD(), .WB(), .WB_ALU_RESULT(), .WB_RD_Data(), .WB_RD_DATA(),
		.PCWRITE_JUMP(PCWRITE_JUMP_2),
		.HitWrite(HitWrite_2), 
		.Access_MM(Access_MM_2), 
		.Data_MM(Data_MM_2), 
		.CNT_HIT(CNT_HIT_2), 
		.CNT_MISS(CNT_MISS_2), 
		.CONT(), .TYPE(), .PCLK(), .CCLK()
	);

	Top_pipe_CACHE_3 Two_way_LRU(
		.CLK(CLK), 
		.RESET(RESET),
		.PC(PC_3), 
		.PCWrite(),.PC_next(), 
		.IF_Instruction(IF_Instruction_3), 
		.IFIDWrite(), .IF_Flush(), .IF_PC_4(),.JUMP_Addr(), .BTB_Addr(),.ID_PC_4(), .ID_Instruction(), .ID_RS_data(), .ID_RT_data(), .FW_sig_ID_1(), .FW_sig_ID_2(), .ID_RS_DATA(), .ID_RT_DATA(), .Hazard_Ctrl(), .Branch(), .Jump(), .RegDst(),.CONT_1(),.CONT_2a(), .CONT_2b(), .DATA_1a(), .DATA_2a(), 
		.EX_PC_4(EX_PC_4_3), 
		.WB_MEM_EX(), .EX_Opcode(), .EX_RS_Data(), .EX_RT_Data(), .EX_Sign_extend(), .FW_sig_EX_1(), .FW_sig_EX_2(), .FW_sig_EX_3(), .EX_RS_DATA(), .EX_RT_DATA(),.EX_RT_Data_FW(),.ALU_result(), 
		.HI(HI_3), 
		.LO(LO_3), 
		.EX_ALU_RESULT(EX_ALU_RESULT_3),
		.MEM_PC_4(),.MEM_RD(),.WB_MEM(),.MEM_Opcode(), .MEM_ALU_RESULT(),.MEM_RD_DATA(),.MEM_RT_DATA(), .WB_PC_4(), .WB_RD(), .WB(), .WB_ALU_RESULT(), .WB_RD_Data(), .WB_RD_DATA(),
		.HitWrite(HitWrite_3), 
		.Access_MM(Access_MM_3), 
		.Data_MM(Data_MM_3), 
		.CNT_HIT(CNT_HIT_3), 
		.CNT_MISS(CNT_MISS_3), 
		.CONT(), .TYPE(), .PCLK(), .CCLK()
	);

	Top_pipe_CACHE_4 Two_way_RANDOM(
		.CLK(CLK), 
		.RESET(RESET),
		.PC(PC_4), 
		.PCWrite(),.PC_next(), 
		.IF_Instruction(IF_Instruction_4), 
		.IFIDWrite(), .IF_Flush(), .IF_PC_4(),.JUMP_Addr(), .BTB_Addr(),.ID_PC_4(), .ID_Instruction(), .ID_RS_data(), .ID_RT_data(), .FW_sig_ID_1(), .FW_sig_ID_2(), .ID_RS_DATA(), .ID_RT_DATA(), .Hazard_Ctrl(), .Branch(), .Jump(), .RegDst(),.CONT_1(),.CONT_2a(), .CONT_2b(), .DATA_1a(), .DATA_2a(), 
		.EX_PC_4(EX_PC_4_4), 
		.WB_MEM_EX(), .EX_Opcode(), .EX_RS_Data(), .EX_RT_Data(), .EX_Sign_extend(), .FW_sig_EX_1(), .FW_sig_EX_2(), .FW_sig_EX_3(), .EX_RS_DATA(), .EX_RT_DATA(),.EX_RT_Data_FW(),.ALU_result(), 
		.HI(HI_4), 
		.LO(LO_4), 
		.EX_ALU_RESULT(EX_ALU_RESULT_4),
		.MEM_PC_4(),.MEM_RD(),.WB_MEM(),.MEM_Opcode(), .MEM_ALU_RESULT(),.MEM_RD_DATA(),.MEM_RT_DATA(), .WB_PC_4(), .WB_RD(), .WB(), .WB_ALU_RESULT(), .WB_RD_Data(), .WB_RD_DATA(),
		.HitWrite(HitWrite_4), 
		.Access_MM(Access_MM_4), 
		.Data_MM(Data_MM_4), 
		.CNT_HIT(CNT_HIT_4), 
		.CNT_MISS(CNT_MISS_4), 
		.CONT(), .TYPE(), .PCLK(), .CCLK()
	);

	Top_pipe_CACHE_5 Fully_FIFO(
		.CLK(CLK), 
		.RESET(RESET),
		.PC(PC_5), 
		.PCWrite(),.PC_next(), 
		.IF_Instruction(IF_Instruction_5), 
		.IFIDWrite(), .IF_Flush(), .IF_PC_4(),.JUMP_Addr(), .BTB_Addr(),.ID_PC_4(), .ID_Instruction(), .ID_RS_data(), .ID_RT_data(), .FW_sig_ID_1(), .FW_sig_ID_2(), .ID_RS_DATA(), .ID_RT_DATA(), .Hazard_Ctrl(), .Branch(), .Jump(), .RegDst(),.CONT_1(),.CONT_2a(), .CONT_2b(), .DATA_1a(), .DATA_2a(), 
		.EX_PC_4(EX_PC_4_5), 
		.WB_MEM_EX(), .EX_Opcode(), .EX_RS_Data(), .EX_RT_Data(), .EX_Sign_extend(), .FW_sig_EX_1(), .FW_sig_EX_2(), .FW_sig_EX_3(), .EX_RS_DATA(), .EX_RT_DATA(),.EX_RT_Data_FW(),.ALU_result(), 
		.HI(HI_5), 
		.LO(LO_5), 
		.EX_ALU_RESULT(EX_ALU_RESULT_5),
		.MEM_PC_4(),.MEM_RD(),.WB_MEM(),.MEM_Opcode(), .MEM_ALU_RESULT(),.MEM_RD_DATA(),.MEM_RT_DATA(), .WB_PC_4(), .WB_RD(), .WB(), .WB_ALU_RESULT(), .WB_RD_Data(), .WB_RD_DATA(),
		.HitWrite(HitWrite_5), 
		.Access_MM(Access_MM_5), 
		.Data_MM(Data_MM_5), 
		.CNT_HIT(CNT_HIT_5), 
		.CNT_MISS(CNT_MISS_5), 
		.CONT(), .TYPE(), .PCLK(), .CCLK()
	);

	Top_pipe_CACHE_6 Fully_RANDOM(
		.CLK(CLK), 
		.RESET(RESET),
		.PC(PC_6), 
		.PCWrite(),.PC_next(), 
		.IF_Instruction(IF_Instruction_6), 
		.IFIDWrite(), .IF_Flush(), .IF_PC_4(),.JUMP_Addr(), .BTB_Addr(),.ID_PC_4(), .ID_Instruction(), .ID_RS_data(), .ID_RT_data(), .FW_sig_ID_1(), .FW_sig_ID_2(), .ID_RS_DATA(), .ID_RT_DATA(), .Hazard_Ctrl(), .Branch(), .Jump(), .RegDst(),.CONT_1(),.CONT_2a(), .CONT_2b(), .DATA_1a(), .DATA_2a(), 
		.EX_PC_4(EX_PC_4_6), 
		.WB_MEM_EX(), .EX_Opcode(), .EX_RS_Data(), .EX_RT_Data(), .EX_Sign_extend(), .FW_sig_EX_1(), .FW_sig_EX_2(), .FW_sig_EX_3(), .EX_RS_DATA(), .EX_RT_DATA(),.EX_RT_Data_FW(),.ALU_result(), 
		.HI(HI_6), 
		.LO(LO_6), 
		.EX_ALU_RESULT(EX_ALU_RESULT_6),
		.MEM_PC_4(),.MEM_RD(),.WB_MEM(),.MEM_Opcode(), .MEM_ALU_RESULT(),.MEM_RD_DATA(),.MEM_RT_DATA(), .WB_PC_4(), .WB_RD(), .WB(), .WB_ALU_RESULT(), .WB_RD_Data(), .WB_RD_DATA(),
		.HitWrite(HitWrite_6), 
		.Access_MM(Access_MM_6), 
		.Data_MM(Data_MM_6), 
		.CNT_HIT(CNT_HIT_6), 
		.CNT_MISS(CNT_MISS_6), 
		.CONT(), .TYPE(), .PCLK(), .CCLK()
	);

	Top_pipe_CACHE_7 Two_way_2word(
		.CLK(CLK), 
		.RESET(RESET),
		.PC(PC_7), 
		.PCWrite(),.PC_next(), 
		.IF_Instruction(IF_Instruction_7), 
		.IFIDWrite(), .IF_Flush(), .IF_PC_4(),.JUMP_Addr(), .BTB_Addr(),.ID_PC_4(), .ID_Instruction(), .ID_RS_data(), .ID_RT_data(), .FW_sig_ID_1(), .FW_sig_ID_2(), .ID_RS_DATA(), .ID_RT_DATA(), .Hazard_Ctrl(), .Branch(), .Jump(), .RegDst(),.CONT_1(),.CONT_2a(), .CONT_2b(), .DATA_1a(), .DATA_2a(), 
		.EX_PC_4(EX_PC_4_7), 
		.WB_MEM_EX(), .EX_Opcode(), .EX_RS_Data(), .EX_RT_Data(), .EX_Sign_extend(), .FW_sig_EX_1(), .FW_sig_EX_2(), .FW_sig_EX_3(), .EX_RS_DATA(), .EX_RT_DATA(),.EX_RT_Data_FW(),.ALU_result(), 
		.HI(HI_7), 
		.LO(LO_7), 
		.EX_ALU_RESULT(EX_ALU_RESULT_7),
		.MEM_PC_4(),.MEM_RD(),.WB_MEM(),.MEM_Opcode(), .MEM_ALU_RESULT(),.MEM_RD_DATA(),.MEM_RT_DATA(), .WB_PC_4(), .WB_RD(), .WB(), .WB_ALU_RESULT(), .WB_RD_Data(), .WB_RD_DATA(),
		.HitWrite(HitWrite_7), 
		.Access_MM(Access_MM_7), 
		.Data_MM(Data_MM_7), 
		.CNT_HIT(CNT_HIT_7), 
		.CNT_MISS(CNT_MISS_7), 
		.CONT(), .TYPE(), .PCLK(), .CCLK()
	);

	Top_pipe_CACHE_8 Fully_2word(
		.CLK(CLK), 
		.RESET(RESET),
		.PC(PC_8), 
		.PCWrite(),.PC_next(), 
		.IF_Instruction(IF_Instruction_8), 
		.IFIDWrite(), .IF_Flush(), .IF_PC_4(),.JUMP_Addr(), .BTB_Addr(),.ID_PC_4(), .ID_Instruction(), .ID_RS_data(), .ID_RT_data(), .FW_sig_ID_1(), .FW_sig_ID_2(), .ID_RS_DATA(), .ID_RT_DATA(), .Hazard_Ctrl(), .Branch(), .Jump(), .RegDst(),.CONT_1(),.CONT_2a(), .CONT_2b(), .DATA_1a(), .DATA_2a(), 
		.EX_PC_4(EX_PC_4_8), 
		.WB_MEM_EX(), .EX_Opcode(), .EX_RS_Data(), .EX_RT_Data(), .EX_Sign_extend(), .FW_sig_EX_1(), .FW_sig_EX_2(), .FW_sig_EX_3(), .EX_RS_DATA(), .EX_RT_DATA(),.EX_RT_Data_FW(),.ALU_result(), 
		.HI(HI_8), 
		.LO(LO_8), 
		.EX_ALU_RESULT(EX_ALU_RESULT_8),
		.MEM_PC_4(),.MEM_RD(),.WB_MEM(),.MEM_Opcode(), .MEM_ALU_RESULT(),.MEM_RD_DATA(),.MEM_RT_DATA(), .WB_PC_4(), .WB_RD(), .WB(), .WB_ALU_RESULT(), .WB_RD_Data(), .WB_RD_DATA(),
		.HitWrite(HitWrite_8), 
		.Access_MM(Access_MM_8), 
		.Data_MM(Data_MM_8), 
		.CNT_HIT(CNT_HIT_8), 
		.CNT_MISS(CNT_MISS_8), 
		.CONT(), .TYPE(), .PCLK(), .CCLK()
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
