module Top_pipe_CACHE_6(CLK, RESET,
PC, PCWrite, PC_next, IF_Instruction, IFIDWrite, IF_Flush, IF_PC_4, JUMP_Addr, BTB_Addr,
ID_PC_4, ID_Instruction, ID_RS_data, ID_RT_data, FW_sig_ID_1, FW_sig_ID_2, ID_RS_DATA, ID_RT_DATA, 
Hazard_Ctrl, Branch, Jump, RegDst,
CONT_1, CONT_2a, CONT_2b, DATA_1a, DATA_2a,
EX_PC_4, WB_MEM_EX, EX_Opcode, EX_RS_Data, EX_RT_Data, EX_Sign_extend, FW_sig_EX_1, FW_sig_EX_2, FW_sig_EX_3, EX_RS_DATA, EX_RT_DATA, EX_RT_Data_FW,
ALU_result, HI, LO, EX_ALU_RESULT,
MEM_PC_4, MEM_RD, WB_MEM, MEM_Opcode, MEM_ALU_RESULT, MEM_RD_DATA, MEM_RT_DATA,
WB_PC_4, WB_RD, WB, WB_ALU_RESULT, WB_RD_Data, WB_RD_DATA,
HitWrite, Access_MM, Data_MM, CNT_HIT, CNT_MISS, CONT, TYPE, PCLK, CCLK 
);
 

	input CLK, RESET;

	output wire [31:0] JUMP_Addr, BTB_Addr;
	output wire Branch; 
	wire JUMP;
	output wire [31:0] PC_next;
	output wire [31:0] IF_PC_4;

	output wire PCWrite;
	output wire [31:0] PC;

	output wire [31:0] IF_Instruction;
	//output wire [2:0] TYPE;

	output wire IFIDWrite, IF_Flush;
	output wire [31:0] ID_Instruction;
	output wire [31:0] ID_PC_4;
	wire FLUSH;
	
	output wire [5:0] MEM_Opcode;
	wire [4:0] EX_RS, EX_RD;
	output wire [1:0] Jump;
	output wire Hazard_Ctrl;
	
	output wire CONT_1, CONT_2a, CONT_2b, DATA_1a, DATA_2a;

	wire [31:0] ID_Sign_extend;
	wire [31:0] Branch_WO_PC;
	wire [31:0] Jump_WO_PC;
	wire [31:0] Jump_Addr;
	wire [31:0] ID_RD_32;

	output wire [4:0] WB_MEM; //[2]
	output wire [4:0] WB_RD;
	output wire [31:0] WB_RD_DATA;
	output wire [2:0] WB; //[0]
	output wire [31:0] ID_RS_data, ID_RT_data;

	output wire [1:0] RegDst;
	wire [2:0] WB_CONT;
	wire [1:0] MEM_CONT;
	wire [5:0] EX_CONT;

	wire [31:0] WB_MEM_EX_32;

	output wire [31:0] MEM_ALU_RESULT;
	output wire [31:0] ID_RS_DATA;

	output wire [31:0] ID_RT_DATA;

	wire [31:0] Zero;

	output wire [4:0] MEM_RD;
	output wire [1:0] FW_sig_ID_1, FW_sig_ID_2;
	

	output wire [10:0] WB_MEM_EX;
	output wire [5:0] EX_Opcode;
	output wire [31:0] EX_RS_Data, EX_RT_Data, EX_Sign_extend;
	wire [4:0] EX_Shmpt;
	wire [5:0] EX_Funct;
	wire [4:0] EX_RT;
	output wire [31:0] EX_PC_4;

	output wire [31:0] ALU_result;
	output wire [1:0] FW_sig_EX_1, FW_sig_EX_2;
	output wire [1:0] FW_sig_EX_3;
                 
	output wire [31:0] EX_RS_DATA, EX_RT_DATA;  
	output wire [31:0] EX_RT_Data_FW;
	wire [31:0] Hi, Lo;
	output wire [31:0] HI, LO;               

	wire [3:0] ALU_control;
	output wire [31:0] EX_ALU_RESULT;

	output wire [31:0] MEM_PC_4;

	output wire [31:0] MEM_RT_DATA, MEM_RD_DATA;
	wire [31:0] Read_data;

	output wire [31:0] WB_ALU_RESULT;
	output wire [31:0] WB_RD_Data;
	output wire [31:0] WB_PC_4;

	wire PCWRITE; //PCWrite || HitWrite
	wire PCWRITE_JUMP; //PCWRITE || IF_Flush
	//wire IFIDWRITE; //IFIDWrite || HitWrite

	output wire HitWrite;
        output wire Access_MM;
        output wire [31:0] Data_MM;
        output wire [19:0] CNT_HIT, CNT_MISS;
	output wire [1:0] CONT;
	output wire [2:0] TYPE;
	output wire PCLK, CCLK;

	//IF__________________________________________________

		MUX4to1 MUX1(
		.a(IF_PC_4),		//IN (00)
		.b(JUMP_Addr),		//IN (01)
		.c(BTB_Addr),		//IN (10)
		.d(32'd0),		//IN
		.sig({Branch, JUMP}),	//IN 
		.out(PC_next)		//OUT
	);
	
	and_gate AND1(
		.a(PCWrite),
		.b(HitWrite),
		.out(PCWRITE)	
	);
	or_gate OR0(
		.a(PCWRITE),
		.b(IF_Flush),
		.out(PCWRITE_JUMP)
	);


	PC PC_top(
		.CLK(CLK),		//IN
		.RESET(RESET),		//IN
		.PCWrite(PCWRITE_JUMP),	//IN @@@@
		.PC_next(PC_next),	//IN
		.PC(PC),		//OUT
		.PCLK(PCLK)		//OUT @@@
	);

	ADD ADD1(
		.a(PC),		//IN
		.b(32'd4),	//IN
		.out(IF_PC_4)	//OUT
	);


	Cache__Fully_Random Fully_random(
		.CLK(PCLK), 			//IN
		.RESET(RESET),			//IN 
		.PC(PC),			//IN 
		.Access_MM(Access_MM), 		//IN
		.Data_MM(Data_MM), 		//IN
		.HitWrite(HitWrite), 		//OUT
		.Data_Cache(IF_Instruction), 	//OUT
		.CNT_HIT(CNT_HIT), 		//OUT
		.CNT_MISS(CNT_MISS),		//OUT
		.CCLK(CCLK),			//OUT
		.rand_num()
	);

        MainMemory MM(
                .CLK(CLK),                      //IN
                .RESET(RESET),                  //IN
                .PC(PC),                        //IN
                .Access_MM(Access_MM),          //IN
                .Data_MM(Data_MM)               //IN
        );

        cache_controller Cache_CONT(
                .CLK(CLK),                      //IN
		.RESET(RESET),			//IN
                .HitWrite(HitWrite),            //IN
                .Access_MM(Access_MM)           //OUT
        ); 

//	Instruction_memory Inst_Mem(
//		.CLK(CLK),			//IN
//		.RESET(RESET),			//IN
//		.PC(PC),			//IN
//		.IF_Instruction(IF_Instruction)	//OUT
//	);

	//and_gate AND2(
	//	.a(IFIDWrite),
		//.b(HitWrite),
		//.out(IFIDWRITE)	
	//);

	IFID_Reg IFID(
		.CLK(CLK),				//IN @@@
		.RESET(RESET),				//IN
		.CCLK(CCLK),				//IN @@@@@
		.IFIDWrite(IFIDWrite),			//IN @@@@
		.IF_Instruction(IF_Instruction),	//IN
		.IF_Flush(IF_Flush),			//IN
		.IF_PC_4(IF_PC_4),			//IN
		.ID_INSTRUCTION(ID_Instruction),	//OUT
		.ID_PC_4(ID_PC_4),			//OUT
		.FLUSH(FLUSH),				//OUT
		.TYPE(TYPE)
	);
	//ID__________________________________________________

	Hazard_detection_unit Hazard(
		.CLK(CLK),				//IN
		.RESET(RESET),				//IN
		.IF_PC_4(IF_PC_4),			//IN
		.opcode_ID(ID_Instruction[31:26]),	//IN
		.opcode_EX(EX_Opcode),			//IN
		.opcode_MEM(MEM_Opcode),		//IN
		.EX_RegWrite(WB_MEM_EX[8]),		//IN
		.MEM_RegWrite(WB_MEM[2]),		//IN
		.ID_RS(ID_Instruction[25:21]), 		//IN
		.ID_RT(ID_Instruction[20:16]),		//IN
		.EX_RS(EX_RS),				//IN
		.EX_RD(EX_RD),				//IN
		.MEM_RD(MEM_RD),			//IN
		.Branch(Branch),			//IN
		.Jump(Jump),				//IN
		.PCWrite(PCWrite),			//OUT
		.IFIDWrite(IFIDWrite),			//OUT
		.IF_Flush(IF_Flush),			//OUT
		.Hazard_Ctrl(Hazard_Ctrl),		//OUT
		.CONT_1(CONT_1), 
		.CONT_2a(CONT_2a), 
		.CONT_2b(CONT_2b), 
		.DATA_1a(DATA_1a), 
		//.DATA_1b(DATA_1b), 
		.DATA_2a(DATA_2a)
		//.DATA_2b(DATA_2b)
	);
	
	Sign_extend Sign_extend_top(
		.Sign_extend_in(ID_Instruction[15:0]),	//IN
		.Sign_extend(ID_Sign_extend)		//OUT
	);

	Shift_left_2 Shift_left_2_Branch(
		.Shift_left_2_IN(ID_Sign_extend),	//IN
		.Shift_left_2_OUT(Branch_WO_PC)		//OUT
	);

	Shift_left_2 Shift_left_2_Jump(
		.Shift_left_2_IN({6'd0, ID_Instruction[25:0]}),	//IN
		.Shift_left_2_OUT(Jump_WO_PC)			//OUT
	);

	ADD ADD2(
		.a(ID_PC_4),		//IN
		.b(Branch_WO_PC),	//IN
		.out(BTB_Addr)		//OUT
	);

	ADD ADD3(
		.a({ID_PC_4[31:28],28'd0}),	//IN
		.b(Jump_WO_PC),			//IN
		.out(Jump_Addr)			//OUT **************
	);

	MUX4to1 MUX2(
		.a({27'd0, ID_Instruction[20:16]}),	//IN
		.b({27'd0, ID_Instruction[15:11]}),	//IN
		.c(32'd31),				//IN
		.d(32'd0),				
		.sig(RegDst),				//IN
		.out(ID_RD_32)				//OUT
	);

	Registers Registers_top(
		.CLK(CLK),					//IN
		.RESET(RESET),					//IN
		.RegWrite(WB[0]),				//IN
		.Read_register_1(ID_Instruction[25:21]),	//IN
		.Read_register_2(ID_Instruction[20:16]),	//IN
		.Write_register(WB_RD),				//IN
		.Write_Data(WB_RD_DATA),			//IN
		.Read_data_1(ID_RS_data),			//OUT
		.Read_data_2(ID_RT_data)			//OUT
	);

	MUX2to1 MUX10(
		.a(Jump_Addr), //j, jal
		.b(ID_RS_DATA), //jr
		.sig(Jump[1]),
		.out(JUMP_Addr)
	);

	or_gate OR1(
		.a(Jump[0]),
		.b(Jump[1]),
		.out(JUMP)
	);

	Control Control_top(
		.CLK(CLK),			//IN
		.RESET(RESET),			//IN
		.opcode(ID_Instruction[31:26]), //IN
		.funct(ID_Instruction[5:0]),	//IN
		.FLUSH(FLUSH),
		.RegDst(RegDst),		//OUT
		.Jump(Jump),			//OUT @@TIming Issue
		.WB_CONT(WB_CONT),		//OUT 3bit
		.MEM_CONT(MEM_CONT),		//OUT 2bit
		.EX_CONT(EX_CONT)		//OUT 6bit
	);


	//	21	/   2    /   1    /   1   /   1    /  3  /  1   /  2 /
	//	0	/MemtoReg/RegWrite/MemRead/MemWrite/ALUOP/ALUSrc/HiLo/

	MUX2to1 MUX3(
		.a({21'd0,WB_CONT,MEM_CONT,EX_CONT}),	//IN
		.b(32'd0),				//IN 
		.sig(Hazard_Ctrl),			//IN
		.out(WB_MEM_EX_32)			//OUT
	);

	MUX4to1 MUX4(
		.a(ID_RS_data),		//IN 00
		.b(MEM_ALU_RESULT),	//IN 01
		.c(WB_RD_DATA),		//IN 10 @@@@
		.d(32'd0),
		.sig(FW_sig_ID_1),	//IN
		.out(ID_RS_DATA)	//OUT
	);

	MUX4to1 MUX5(
		.a(ID_RT_data),		//IN 00
		.b(MEM_ALU_RESULT),	//IN 01
		.c(WB_RD_DATA),		//IN 10
		.d(32'd0),
		.sig(FW_sig_ID_2),	//IN
		.out(ID_RT_DATA)	//OUT
	);

	XNOR XNOR_ID(
		.a(ID_RS_DATA),		//IN
		.b(ID_RT_DATA),		//IN
		.out(Zero)		//OUT
	);
	
	Branch_calc Branch_top(
		.opcode(ID_Instruction[31:26]),	//IN
		.Zero(Zero),			//IN
		.Branch(Branch)			//OUT
	);

	Forwarding_Unit_ID FWU_ID(			//Use only Branch INST
		.opcode_ID(ID_Instruction[31:26]),	//IN
		.ID_RS(ID_Instruction[25:21]),		//IN
		.ID_RT(ID_Instruction[20:16]),		//IN
		.MEM_RD(MEM_RD),			//IN
		.WB_RD(WB_RD),				//IN
		.MEM_FW(WB_MEM[2]),			//IN
		.WB_FW(WB[0]),				//IN
		.FW_sig1(FW_sig_ID_1),			//OUT
		.FW_sig2(FW_sig_ID_2)			//OUT
	);

	IDEX_Reg IDEX(
		.CLK(CLK),				//IN
		.RESET(RESET),				//IN
		.WB_MEM_EX_32(WB_MEM_EX_32),		//IN
		.ID_Opcode(ID_Instruction[31:26]),	//IN
		.ID_RS(ID_Instruction[25:21]),	
		.ID_RT(ID_Instruction[20:16]),
		.ID_RS_Data(ID_RS_DATA),		//IN
		.ID_RT_Data(ID_RT_DATA),		//IN
		.ID_Sign_extend(ID_Sign_extend),	//IN
		.ID_Shmpt(ID_Instruction[10:6]),	//IN
		.ID_Funct(ID_Instruction[5:0]),		//IN
		.ID_RD(ID_RD_32[4:0]),			//IN
		.ID_PC_4(ID_PC_4),			//IN
		.WB_MEM_EX(WB_MEM_EX),			//OUT
		.EX_Opcode(EX_Opcode),			//OUT @@@
		.EX_RS(EX_RS),				//OUT
		.EX_RT(EX_RT),
		.EX_RS_Data(EX_RS_Data),		//OUT
		.EX_RT_Data(EX_RT_Data),		//OUT
		.EX_Sign_extend(EX_Sign_extend),	//OUT
		.EX_Shmpt(EX_Shmpt),			//OUT
		.EX_Funct(EX_Funct),			//OUT
		.EX_RD(EX_RD),				//OUT
		.EX_PC_4(EX_PC_4)			//OUT
	);
	//EX__________________________________________________

	MUX4to1 MUX6(
		.a(EX_RS_Data),
		.b(MEM_ALU_RESULT),
		.c(WB_RD_DATA),
		.d(32'd0),
		.sig(FW_sig_EX_1),
		.out(EX_RS_DATA)
	);

	MUX4to1 MUX7(
		.a(EX_RT_Data),
		.b(EX_Sign_extend),
		.c(MEM_ALU_RESULT),
		.d(WB_RD_DATA),
		.sig(FW_sig_EX_2),
		.out(EX_RT_DATA)
	);

	MUX4to1 MUX11(
		.a(EX_RT_Data),
		.b(MEM_ALU_RESULT),
		.c(WB_RD_DATA),
		.d(32'd0),
		.sig(FW_sig_EX_3),
		.out(EX_RT_Data_FW)
	);


	ALU_control ALU_control_top(
		.ALU_control_IN(EX_Funct),
		.ALUOp(WB_MEM_EX[5:3]),
		.ALU_control(ALU_control)
	);

	ALU ALU_top(
		.CLK(CLK),
		.ALU_IN_1(EX_RS_DATA),
		.ALU_IN_2(EX_RT_DATA),
		.ALU_control(ALU_control),
		.Shampt(EX_Shmpt),
		.ALU_result(ALU_result),
		.Hi(Hi),
		.Lo(Lo)
	);

	Special_Registers SR(
		.CLK(CLK),
		.RESET(RESET),
		.Hi(Hi),
		.Lo(Lo),
		.ALU_control(ALU_control),
		.HI(HI),
		.LO(LO)
	);

	MUX4to1 MUX8(
		.a(ALU_result),
		.b(LO),
		.c(HI),
		.d(32'b0),
		.sig(WB_MEM_EX[1:0]),
		.out(EX_ALU_RESULT)
	);


	Forwarding_Unit_EX FWU_EX(
		.opcode_EX(EX_Opcode),
		.EX_RS(EX_RS),
		.EX_RT(EX_RT),
		.MEM_RD(MEM_RD),
		.WB_RD(WB_RD),
		.ALUSrc(WB_MEM_EX[2]),
		.MEM_FW(WB_MEM[2]),
		.WB_FW(WB[0]),
		.FW_sig1(FW_sig_EX_1),
		.FW_sig2(FW_sig_EX_2),
		.FW_sig3(FW_sig_EX_3)
	);

	EXMEM_Reg EXMEM(
		.CLK(CLK),
		.RESET(RESET),
		.WB_MEM_EX(WB_MEM_EX),
		.EX_Opcode(EX_Opcode),
		.EX_ALU_RESULT(EX_ALU_RESULT),
		.EX_RT_DATA(EX_RT_Data_FW),
		.EX_RD(EX_RD),
		.EX_PC_4(EX_PC_4),
		.WB_MEM(WB_MEM),
		.MEM_Opcode(MEM_Opcode),
		.MEM_ALU_RESULT(MEM_ALU_RESULT),
		.MEM_RT_DATA(MEM_RT_DATA),
		.MEM_RD(MEM_RD),
		.MEM_PC_4(MEM_PC_4)
	);

	//MEM_________________________________________________

	Data_memory Data_memory_test(
		.CLK(CLK),
		.RESET(RESET),
		.Address(MEM_ALU_RESULT),
		.Write_Data(MEM_RT_DATA),
		.MemWrite(WB_MEM[0]),
		.MemRead(WB_MEM[1]),
		.Read_data(MEM_RD_DATA)
	);

	MEMWB_Reg MEMWB(
		.CLK(CLK),					//IN
		.RESET(RESET),					//IN
		.WB_MEM(WB_MEM),				//IN
		.MEM_ALU_RESULT(MEM_ALU_RESULT),		//IN
		.MEM_RD_DATA(MEM_RD_DATA),			//IN
		.MEM_RD(MEM_RD),				//IN
		.MEM_PC_4(MEM_PC_4),				//IN
		.WB(WB),					//OUT
		.WB_ALU_RESULT(WB_ALU_RESULT),			//OUT
		.WB_RD_Data(WB_RD_Data),			//OUT
		.WB_RD(WB_RD),					//OUT
		.WB_PC_4(WB_PC_4)				//OUT
	);

	//WB_________________________________________________

	//WB_EX
	//   2    /   1    /
	//MemtoReg/RegWrite/

	MUX4to1 MUX9(
		.a(WB_ALU_RESULT),	//IN
		.b(WB_RD_Data),		//IN
		.c(WB_PC_4),		//IN
		.d(32'b0),		//IN
		.sig(WB[2:1]),		//IN
		.out(WB_RD_DATA)	//OUT	
	);

endmodule
