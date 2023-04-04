/*
<YUN SUNG>
1. MUX2to1, MUX4to1
2. PC
3. ADD
4. Instruction_memory
5. Branch_Target_Buffer
6. IF/ID_Reg

<AH JIN>
7. Hazard_detection_unit
8. Control 
9. Shift_left_2
10. Sign_extend
11. Registers
12. XNOR
13. Branch_calc
14. Forwarding_unit_ID
15. ID/EX_Reg

<SEUNG WON>
16. ALU
17. Forwarding_unit_EX
18. MEM/WB_Reg

19. Data_memory
20. EX/MEM_Reg
*/

module Top_pipe(CLK, RESET);

	input CLK, RESET;

	wire [31:0] IF_PC_4;		//PC+4
	wire [31:0] Jump_Addr;		//Jump Address
	wire [31:0] BTB_Addr;		//Branch Address
	wire [31:0] PC;
	wire Branch;			// Beq, Bne Result
	wire Jump;			//Select next PC address, 0:PC+4, 1:Jump
	wire [31:0] IF_Instruction;	//IF/ID_Reg input Instruction
	wire [31:0] ID_Instruction;	//IF/ID_Reg output Instruction
	wire IF_Flush;
	wire IDIFWrite;
	wire PCWrite;
	wire [31:0] ID_PC_4;

	wire [4:0] EX_RS, EX_RT;
	wire Hazard_Ctrl;
	wire [31:0] ID_Sign_extend;
	wire [31:0] Branch_WO_PC, Jump_WO_PC;
	wire [31:0] ID_RD_32;
	wire [4:0] ID_RD;
	wire [1:0] RegDst;
	wire [2:0] WB;
	wire [2:0] MEM;
	wire [5:0] EX;
	wire [31:0] WB_MEM_EX_32;
	wire [10:0] WB_MEM_EX;
	wire [31:0] ID_RS_data, ID_RT_data; //Before forwarding RS, RD
	wire [31:0] WB_RD_DATA;
	wire [4:0] MEM_RD, WB_RD; 
	wire [31:0] MEM_RD_DATA_1, WB_RD_DATA_1;
	wire [31:0] ID_RS_DATA, ID_RT_DATA; //After forwarding RS, RD
	wire [1:0] FW_sig_ID_1, FW_sig_ID_2;
	wire Zero;
	wire [5:0] EX_Opcode;
	wire [31:0] EX_RS_Data, EX_RT_Data;
	wire [31:0] EX_Sign_extend;
	wire [4:0] EX_Shmpt;
	wire [5:0] EX_Funct;
	wire [4:0] EX_RD;
	wire [31:0] EX_PC_4;

	wire [31:0] EX_RS_DATA, EX_RT_DATA; //After Forwarding RS, RT Data
	wire [1:0] FW_sig_EX_1, FW_sig_EX_2;
	wire [3:0] ALU_control;
	wire [31:0] ALU_result;
	wire [31:0] Hi, Lo, HI, LO;
	wire [31:0] EX_ALU_RESULT;
	wire [2:0] WB_MEM;
	wire [31:0] MEM_RD_DATA_2, WB_RD_DATA_2;
	wire [5:0] MEM_Opcode;
	wire [31:0] MEM_RT_DATA;
	//wire [31:0] MEM_ALU_RESULT;
	//wire [5:0] MEM_RD;

	//wire [31:0] MEM_ALU_RESULT;
	//
	wire [5:0] WB_Opcode;
	wire [31:0] WB_ALU_RESULT;
	wire [31:0] WB_RD_Data;
	//wire [5:0] WB_RD;

	//Yunsung--------------------------------------------

	MUX4to1 MUX1(
		.a(ADD_O_1),		//IN (00)
		.b(Jump_Addr),		//IN (01)
		.c(BTB_Addr),		//IN (10)
		.d(32'd0),
		.sig({Branch, Jump}),	//IN
		.out(PC_next)		//OUT
	);

	PC PC_top(
		.CLK(CLK),		//IN
		.RESET(RESET),		//IN
		.PCWrite(PCWrite),	//IN
		.IF_PC_4(IF_PC_4),	//IN
		.PC(PC)			//OUT
	);

	ADD ADD1(
		.a(PC),		//IN
		.b(32'd4),	//IN
		.out(IF_PC_4)	//OUT
	);

	Instruction_memory Inst_Mem(
		.CLK(CLK),			//IN
		.RESET(RESET),			//IN
		.PC(PC),			//IN
		.IF_Instruction(IF_Instruction)	//OUT
	);

	//Branch Taken Case
	Branch_Target_Buffer BTB(
		.CLK(CLK),				//IN
		.RESET(RESET),				//IN
		.PC_4(IF_PC_4),				//IN
		.IF_Instruction(IF_Instruction),	//IN
		.Branch_Addr(BTB_Addr)			//OUT
	);

	IFID_Reg IFID(
		.CLK(CLK),				//IN
		.RESET(RESET),				//IN
		.IDIFWrite(IDIFWrite),			//IN
		.IF_Instruction(IF_Instruction),	//IN
		.IF_Flush(IF_Flush),			//IN
		.IF_PC_4(IF_PC_4),			//IN
		.ID_Instruction(ID_Instruction),	//OUT
		.ID_PC_4(ID_PC_4)			//OUT
	);
	

	//Ahjin--------------------------------------------
	



	Hazard_detection_unit Hazard(
		.CLK(CLK),			//IN
		.opcode(ID_Instruction[31:26]),	//IN
		.ID_RS(ID_Instruction[20:16]),	//IN
		.ID_RT(ID_Instruction[15:11]),	//IN
		.EX_RS(EX_RS),			//IN
		.EX_RT(EX_RT),			//IN
		.PCWrite(PCWrite),		//OUT
		.IDIFWrite(IDIFWrite),		//OUT
		.IF_Flush(IF_Flush),		//OUT
		.Hazard_Ctrl(Hazard_Ctrl)	//OUT
	);
	
	
	Sign_extend Sign_extend_top(
		.Sign_extend_in(ID_Instruction[15:0]),	//IN
		.Sign_extend(ID_Sign_extend)		//OUT
	);


	Shift_left_2 Shift_left_2_Branch(
		.Shift_left_2_IN(ID_Sign_extend),		//IN
		.Shift_left_2_OUT(Branch_WO_PC)	//OUT
	);

	Shift_left_2 Shift_left_2_Jump(
		.Shift_left_2_IN({6'd0, ID_Instruction[25:0]}),		//IN
		.Shift_left_2_OUT(Jump_WO_PC)	//OUT
	);


	ADD ADD2(
		.a{ID_PC_4}),	//IN
		.b(Branch_WO_PC),	//IN
		.out(BTB_Addr)		//OUT
	);

	ADD ADD3(
		.a({ID_PC_4[31:28],28'd0}),	//IN
		.b(Jump_WO_PC),		//IN
		.out(Jump_Addr)		//OUT
	);

	MUX4to1 MUX2(
		.MUX_a({27'd0, ID_Instruction[20:16]}),	//IN
		.MUX_b({27'd0, ID_Instruction[15:11]}),	//IN
		.MUX_c(32'd31),				//IN
		.MUX_d(32'd0),				
		.MUX_sig(Reg_Dst),			//IN
		.MUX_out(ID_RD_32)			//OUT
	);


	Registers Registers_top(
		.CLK(CLK),					//IN
		.RESET(RESET),					//IN
		.RegWrite(WB[0]),				//IN
		.Read_register_1(ID_Instruction[25:21]),		//IN
		.Read_register_2(ID_Instruction[20:16]),		//IN
		.Write_register(WB_RD),				//IN
		.Write_Data(WB_RD_DATA),			//IN
		.Read_data_1(ID_RS_data),			//OUT
		.Read_data_2(ID_RT_data)			//OUT
	);


	Control Control_top(
		.CLK(CLK),			//IN
		.RESET(RESET),			//IN
		.opcode(ID_Instruction[31:26]), //IN
		.funct(ID_Instruction[5:0]),	//IN
		.RegDst(RegDst),		//OUT
		.Jump(Jump),			//OUT @@TIming Issue
		//.Branch(Branch),		//OUT
		.WB(WB),			//OUT 2bit
		.MEM(MEM),			//OUT 3bit
		.EX(EX)				//OUT 6bit
		//.MemWrite(MemWrite),		//OUT @MEM 1bit
		//.MemRead(MemRead),		//OUT @MEM 1bit
		//.RegWrite(RegWrite),		//OUT @WB 1bit
		//.MemtoReg(MemtoReg),		//OUT @WB 2bit
		//.ALUOp(ALUOp),		//OUT @EX 3bit
		//.ALUSrc(ALUSrc),		//OUT @EX 1bit
		//.HiLo(HiLo)			//OUT @EX 2bit
	);


	//	21	/   2    /   1    /   1   /   1    /  3  /  1   /  2 /
	//	0	/MemtoReg/RegWrite/MemRead/MemWrite/ALUOP/ALUSrc/HiLo/

	MUX2to1 MUX3(
		.a({21'd0,WB,MEM,EX}),	//IN
		.b(32'd0),		//IN
		.sig(Hazard_Ctrl),	//IN
		.out(WB_MEM_EX_32)	//OUT
	);

	MUX4to1 MUX4(
		.a(ID_RS_data),		//IN
		.b(MEM_RD_DATA),	//IN
		.c(EX_RD_DATA),		//IN
		.d(32'd0),
		.sig(FW_sig_ID_1),	//IN
		.out(ID_RS_DATA)	//OUT
	);

	MUX4to1 MUX5(
		.a(ID_RT_data),		//IN
		.b(MEM_RD_DATA),	//IN
		.c(EX_RD_DATA),		//IN
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
		.out(Branch)			//OUT
	);

	Forwarding_Unit_ID FWU_ID(		//Use only Branch INST
		.opcode(ID_Instruction[31:26]),	//IN
		.ID_RS(ID_Instruction[25:21]),	//IN
		.ID_RT(ID_Instruction[20:16]),	//IN
		.MEM_RD(MEM_RD),		//IN
		.WB_RD(WB_RD),			//IN
		.MEM_RD_DATA_I(MEM_ALU_RESULT),	//IN
		.WB_RD_DATA_I(WB_RD_DATA),	//IN
		.MEM_RD_DATA_O(MEM_RD_DATA_1),	//OUT
		.WB_RD_DATA_O(WB_RD_DATA_1),	//OUT
		.FW_sig1(FW_sig_ID_1),		//OUT
		.FW_sig2(FW_sig_ID_2)		//OUT
	);


	IDEX_Reg IDEX(
		.CLK(CLK),				//IN
		.RESET(RESET),				//IN
		.WB_MEM_EX_32(WB_MEM_EX_32),		//IN
		.ID_Opcode(ID_Instruction[31:26]),	//IN
		.ID_RS_Data(ID_RS_DATA),		//IN
		.ID_RT_Data(ID_RT_DATA),		//IN
		.ID_Sign_extend(ID_Sign_extend),	//IN
		.ID_Shmpt(ID_Instruction[10:6]),	//IN
		.ID_Funct(ID_Instruction[5:0]),		//IN
		.ID_RD(ID_RD_32[4:0]),			//IN
		.ID_PC_4(ID_PC_4),			//IN
		.WB_MEM_EX(WB_MEM_EX),			//OUT
		.EX_Opcode(EX_Opcode),			//OUT
		.EX_RS_Data(EX_RS_Data),		//OUT
		.EX_RT_Data(EX_RT_Data),		//OUT
		.EX_Sign_extend(EX_Sign_extend),	//OUT
		.EX_Shmpt(EX_Shmpt),			//OUT
		.EX_Funct(EX_Funct),			//OUT
		.EX_RD(EX_RD),				//OUT
		.EX_PC_4(EX_PC_4)			//OUT
	);

	//Seung Won--------------------------------------------



	MUX4to1 MUX6(
		.a(EX_RS_data),		//IN 00
		.b(MEM_RD_DATA_2),	//IN 01
		.c(WB_RD_DATA_2),	//IN 10
		.d(32'd0),
		.sig(FW_sig_EX_1),	//IN
		.out(EX_RS_DATA)	//OUT
	);

	MUX4to1 MUX7(
		.a(EX_RT_data),		//IN 00
		.b(EX_Sign_extend),	//IN 01
		.c(WB_RD_DATA_2),	//IN 10
		.d(MEM_RD_DATA_2),	//IN 11
		.sig(FW_sig_EX_2),	//IN
		.out(EX_RT_DATA)	//OUT
	);

	//   2    /   1    /   1   /   1    /  3  /  1   /  2 /
	//MemtoReg/RegWrite/MemRead/MemWrite/ALUOP/ALUSrc/HiLo/

	ALU_control ALU_control_top(
		.ALU_control_IN(EX_Funct),	//IN
		.ALUOp(WB_MEM_EX[5:3]),		//IN
		.ALU_control(ALU_control)	//OUT
	);

	ALU ALU_top(
		.CLK(CLK),
		.ALU_IN_1(EX_RS_DATA),		//IN
		.ALU_IN_2(EX_RT_DATA),		//IN
		.ALU_control(ALU_control),	//IN
		.Shampt(EX_Shmpt),		//IN
		//.ALU_zero(ALU_zero),		//OUT, Dont need to calculate Branch!
		.ALU_result(ALU_result),	//OUT
		.Hi(Hi),			//OUT
		.Lo(Lo)				//OUT
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
		.MUX_a(ALU_result),		//IN
		.MUX_b(LO),			//IN
		.MUX_c(HI),			//IN
		.MUX_d(32'b0),			//IN
		.MUX_sig(WB_MEM_EX[1:0]),	//IN
		.MUX_out(EX_ALU_RESULT)		//OUT	
	);


	Forwarding_Unit_EX FWU_EX(	
		.opcode(EX_Opcode),		//IN
		.EX_RS(EX_RS),			//IN
		.EX_RT(EX_RT),			//IN
		.MEM_RD(MEM_RD),		//IN
		.WB_RD(WB_RD),			//IN
		.MEM_RD_DATA_I(MEM_ALU_RESULT),	//IN
		.WB_RD_DATA_I(WB_RD_DATA),	//IN
		.ALUSrc(WB_MEM_EX[2]),		//IN	
		.MEM_RD_DATA_O(MEM_RD_DATA_2),	//OUT
		.WB_RD_DATA_O(WB_RD_DATA_2),	//OUT
		.FW_sig1(FW_sig_EX_1),		//OUT
		.FW_sig2(FW_sig_EX_2)		//OUT
	);


	//   2    /   1    /   1   /   1    /
	//MemtoReg/RegWrite/MemRead/MemWrite/

	EXMEM_Reg EXMEM(
		.CLK(CLK),					//IN
		.RESET(RESET),					//IN
		.WB_MEM_EX(WB_MEM_EX),				//IN
		.EX_Opcode(EX_Opcode),				//IN
		.EX_ALU_RESULT(EX_ALU_RESULT),			//IN
		.EX_RT_DATA(EX_RT_DATA),			//IN
		.EX_RD(EX_RD),					//IN
		.EX_PC_4(EX_PC_4),				//IN
		.WB_MEM(WB_MEM),				//OUT
		.MEM_Opcode(MEM_Opcode),			//OUT
		.MEM_ALU_RESULT(MEM_ALU_RESULT),		//OUT
		.MEM_RT_DATA(MEM_RT_DATA),			//OUT
		.MEM_RD(MEM_RD),				//OUT
		.MEM_PC_4(MEM_PC_4)				//OUT
	);

	Data_memory Data_memory_top(
		.CLK(CLK),
		.RESET(RESET),
		.Address(MEM_RT_DATA),		//IN
		.Write_Data(MEM_ALU_RESULT),	//IN
		.MemWrite(WB_MEM[0]),		//IN
		.MemRead(WB_MEM[1]),		//IN
		.Read_data(MEM_RD_DATA)		//OUT
	);

	//   2    /   1    /
	//MemtoReg/RegWrite/


	WBMEM_Reg WBMEM(
		.CLK(CLK),					//IN
		.RESET(RESET),					//IN
		.WB_MEM(WB_MEM),				//IN
		.MEM_Opcode(MEM_Opcode),			//IN
		.MEM_ALU_RESULT(MEM_ALU_RESULT),		//IN
		.MEM_RD_DATA(MEM_RD_DATA),			//IN
		.MEM_RD(MEM_RD),				//IN
		.MEM_PC_4(MEM_PC_4),				//IN
		.WB(WB),					//OUT
		.WB_Opcode(WB_Opcode),				//OUT
		.WB_ALU_RESULT(WB_ALU_RESULT),			//OUT
		.WB_RD_Data(WB_RD_Data),			//OUT
		.WB_RD(WB_RD),					//OUT
		.WB_PC_4(WB_PC_4)				//OUT
	);

	MUX4to1 MUX9(
		.MUX_a(WB_RD_Data),		//IN
		.MUX_b(WB_ALU_RESULT),		//IN
		.MUX_c(WB_PC_4),		//IN
		.MUX_d(32'b0),			//IN
		.MUX_sig(WB[2:1]),		//IN
		.MUX_out(WB_RD_DATA)		//OUT	
	);

endmodule
