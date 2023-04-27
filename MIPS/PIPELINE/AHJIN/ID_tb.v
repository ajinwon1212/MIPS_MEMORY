`timescale 1ns / 1ns
module ID_tb;

	reg [3:0] CASE, CYCLE;
	reg CLK, RESET;
	reg [31:0] IF_Instruction, IF_PC_4;
	wire IFIDWrite;
	wire IF_Flush;
	wire [31:0] ID_Instruction, ID_PC_4;
	
	reg [5:0] MEM_Opcode;
	wire [4:0] EX_RS, EX_RD;
	wire Branch, JUMP;
	wire [1:0] Jump;
	wire PCWrite;
	wire Hazard_Ctrl;
	//
	wire CONT_1, CONT_2a, CONT_2b, DATA_1a, DATA_1b, DATA_2a, DATA_2b;

	wire [31:0] ID_Sign_extend;
	wire [31:0] Branch_WO_PC;
	wire [31:0] Jump_WO_PC;
	wire [31:0] BTB_Addr;
	wire [31:0] Jump_Addr, JUMP_Addr;
	wire [31:0] ID_RD_32;

	reg [4:0] WB_MEM; //[2]
	reg [4:0] WB_RD;
	reg [31:0] WB_RD_DATA;
	reg [2:0] WB; //[0]
	wire [31:0] ID_RS_data, ID_RT_data;

	wire [1:0] RegDst;
	wire [2:0] WB_CONT;
	wire [1:0] MEM_CONT;
	wire [5:0] EX_CONT;

	wire [31:0] WB_MEM_EX_32;

	reg [31:0] MEM_ALU_RESULT;
	wire [31:0] ID_RS_DATA;

	wire [31:0] ID_RT_DATA;

	wire [31:0] Zero;

	reg [4:0] MEM_RD;
	wire [1:0] FW_sig_ID_1, FW_sig_ID_2;

	wire [10:0] WB_MEM_EX;
	wire [5:0] EX_Opcode;
	wire [31:0] EX_RS_Data, EX_RT_Data, EX_Sign_extend;
	wire [4:0] EX_Shmpt;
	wire [5:0] EX_Funct;
	wire [4:0] EX_RT;
	wire [31:0] EX_PC_4;

	IFID_Reg IFID(
		.CLK(CLK),				//IN
		.RESET(RESET),				//IN
		.IFIDWrite(IFIDWrite),			//IN @@
		.IF_Instruction(IF_Instruction),	//IN
		.IF_Flush(IF_Flush),			//IN
		.IF_PC_4(IF_PC_4),			//IN
		.ID_Instruction(ID_Instruction),	//OUT
		.ID_PC_4(ID_PC_4)			//OUT
	);

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
		.DATA_1b(DATA_1b), 
		.DATA_2a(DATA_2a),
		.DATA_2b(DATA_2b)
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
		.b(ID_RS_data), //jr
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
		//.opcode_ID(ID_Instruction[31:26]),	//IN
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
		RESET = 1'b1; IF_PC_4 = 32'd0; IF_Instruction  = 32'b00000000000000000000000000000000;
		#10 RESET = 1'b0; 
		//--------------------
		/*
		[ID_tb]
		0. Normal operate
		1. Data Hazard (lw-R, i)
		2. Data Hazard* (lw-lw,sw-R)
		XXX 3. Data Hazard (sw-lw) XXX
		4. Control Hazard (R-Branch)
		5. Control Hazard (lw-Branch)
		6. Branch taken
		7. Jump
		8. Forwarding (MEM)
		9. Forwarding (WB)
		10. Double Data Hazard(MEM, WB)
		XXX 11. Register Saving Test (ID & WB) >> Solved using Foewarding ID
		12. Branch taken with Forwarding (MEM)
		*/
		//--------------------
		#20 CASE = 4'd0; CYCLE = 4'd1;
		IF_Instruction  = 32'b10001111101010000000000000000000;
		IF_PC_4 = 32'd0;
		WB_RD = 5'd0; WB_RD_DATA = 32'd0; WB = 3'd0;
		MEM_RD = 5'd0; MEM_ALU_RESULT = 32'd0; MEM_Opcode = 6'b000000;
		WB_MEM = 6'd0; MEM_RD = 5'b0; WB_MEM = 5'd0;

		#20 CYCLE = 4'd2;
		IF_Instruction  = 32'b00000000101001100011100000100000;
		IF_PC_4 = 32'd4;

		#20 CYCLE = 4'd3;
		IF_Instruction  = 32'b00000000000000000000000000000000;
		IF_PC_4 = 32'd8;

		//--------------------
		#20 CASE = 4'd1; CYCLE = 4'd1;
		IF_Instruction  = 32'b10001111101010000000000000000000;
		IF_PC_4 = 32'd0;

		#20 CYCLE = 4'd2;
		IF_Instruction  = 32'b00000001000001100011100000100000;
		IF_PC_4 = 32'd4;

		#20 CYCLE = 4'd3;
		IF_PC_4 = 32'd8; MEM_Opcode = 6'b100011; MEM_RD=5'b01000;

		#20 CYCLE = 4'd4; IF_PC_4 = 32'd12;
		MEM_Opcode = 6'b000000; MEM_RD=5'b00111;

		#20 CYCLE = 4'd5; IF_PC_4 = 32'd16; 
		IF_Instruction  = 32'b00000000000000000000000000000000;
		//--------------------
		#20 CASE = 4'd2; CYCLE = 4'd1;
		IF_Instruction  = 32'b10001100000010000000000000000000;
		IF_PC_4 = 32'd0; MEM_RD=5'd0;

		#20 CYCLE = 4'd2;
		IF_Instruction  = 32'b10001101000010100000000000000000;
		IF_PC_4 = 32'd4;

		#20 CYCLE = 4'd3;
		IF_PC_4 = 32'd8; MEM_Opcode = 6'b100011; MEM_RD=5'b01000; WB_MEM = 5'b00100;

		#20 CYCLE = 4'd4; IF_PC_4 = 32'd12; 
		WB_MEM = 5'b00000;
		
		#20 CYCLE = 4'd5; IF_PC_4 = 32'd16;
		IF_Instruction  = 32'b00000000000000000000000000000000;

		#20 CYCLE = 4'd6; IF_PC_4 = 32'd20; 

		#20 CYCLE = 4'd7; IF_PC_4 = 32'd24; MEM_Opcode = 6'b000000; MEM_RD=5'd0; 

		//--------------------
/*
		#20 CASE = 4'd3; CYCLE = 4'd1;
		IF_Instruction  = 32'b10101101000010100000000000000000;
		IF_PC_4 = 32'd0;

		#20 CYCLE = 4'd2;
		IF_Instruction  = 32'b10001101000010100000000000000000;
		IF_PC_4 = 32'd4;

		#20 CYCLE = 4'd3;
		IF_Instruction  = 32'b00000000000000000000000000000000;
		IF_PC_4 = 32'd8;

		#20 CYCLE = 4'd4; IF_PC_4 = 32'd12;
		#20 CYCLE = 4'd5; IF_PC_4 = 32'd16;
*/
		//--------------------
		#20 CASE = 4'd4; CYCLE = 4'd1;
		IF_Instruction  = 32'b00000001000010100100100000100000;
		IF_PC_4 = 32'd0;

		#20 CYCLE = 4'd2;
		IF_Instruction  = 32'b00010001001111000000000000000000;
		IF_PC_4 = 32'd4;

		#20 CYCLE = 4'd3;
		IF_Instruction  = 32'b00000000000000000000000000000000;
		IF_PC_4 = 32'd8;

		#20 CYCLE = 4'd4; IF_PC_4 = 32'd12;
		#20 CYCLE = 4'd5; IF_PC_4 = 32'd16;
		//--------------------
		#20 CASE = 4'd5; CYCLE = 4'd1;
		IF_Instruction  = 32'b10001101000010100000000000000000;
		IF_PC_4 = 32'd0;

		#20 CYCLE = 4'd2;
		IF_Instruction  = 32'b00010101001010100000000000000000;
		IF_PC_4 = 32'd4;

		#20 CYCLE = 4'd3;
		//IF_Instruction  = 32'b00010101001010100000000000000000;
		IF_PC_4 = 32'd8;  //4
		MEM_RD = 5'b01010;
		MEM_Opcode = 6'b100011;
		MEM_ALU_RESULT = 32'd0;

		#20 CYCLE = 4'd4;  
		IF_PC_4 = 32'd12; MEM_RD = 5'd0; MEM_Opcode = 6'b000101;
		#20 CYCLE = 4'd5; IF_PC_4 = 32'd16; IF_Instruction  = 32'b00000000000000000000000000000000;
		#20 CYCLE = 4'd5; IF_PC_4 = 32'd20;

		//--------------------
		#20 CASE = 4'd6; CYCLE = 4'd1;
		IF_Instruction  = 32'b00010001001010100000000000000000;
		IF_PC_4 = 32'd0; MEM_Opcode = 6'b000000;

		#20 CYCLE = 4'd2;
		IF_Instruction  = 32'b00000001000010100100100000100000;
		IF_PC_4 = 32'd4;

		#20 CYCLE = 4'd3;
		IF_Instruction  = 32'b00000000000000000000000000000000;
		IF_PC_4 = 32'd8;

		//--------------------
		#20 CASE = 4'd7; CYCLE = 4'd1;
		IF_Instruction  = 32'b00001000000000000000000000000001;
		IF_PC_4 = 32'd0;

		#20 CYCLE = 4'd2;
		IF_Instruction  = 32'b00000001000010100100100000100000;
		IF_PC_4 = 32'd4;

		#20 CYCLE = 4'd3;
		IF_Instruction  = 32'b00000000000000000000000000000000;
		IF_PC_4 = 32'd8;

		//--------------------
		#20 CASE = 4'd8; CYCLE = 4'd1;
		IF_Instruction  = 32'b00010001000010100000000000000000;
		IF_PC_4 = 32'd0;
		WB_RD = 5'd2;
		WB_RD_DATA = 32'd2;
		WB = 3'd1;
		MEM_RD = 5'd8;
		MEM_ALU_RESULT = 32'd8;
		WB_MEM = 6'b000100;

		#20 CYCLE = 4'd2;
		IF_Instruction  = 32'b00000000000000000000000000000000;
		IF_PC_4 = 32'd4;
		WB_RD = 5'd0;
		WB_RD_DATA = 32'd0;
		WB = 3'd0;
		MEM_RD = 5'd0;
		MEM_ALU_RESULT = 32'd0;
		WB_MEM = 6'b000000;

		//--------------------
		#20 CASE = 4'd9; CYCLE = 4'd1;
		IF_Instruction  = 32'b00010001000010100000000000000000;
		IF_PC_4 = 32'd0;
		WB_RD = 5'd8;
		WB_RD_DATA = 32'd8;
		WB = 3'd1;
		MEM_RD = 5'd2;
		MEM_ALU_RESULT = 32'd2;
		
		#20 CYCLE = 4'd2;
		IF_Instruction  = 32'b00000000000000000000000000000000;
		IF_PC_4 = 32'd4;
		WB_RD = 5'd0;
		WB_RD_DATA = 32'd0;
		WB = 3'd0;
		MEM_RD = 5'd0;
		MEM_ALU_RESULT = 32'd0;
	
		//--------------------
		#20 CASE = 4'd10; CYCLE = 4'd1;
		IF_Instruction  = 32'b00010001000010100000000000000000;
		IF_PC_4 = 32'd0;
		WB_RD = 5'd8;
		WB_RD_DATA = 32'd8;
		WB = 3'd1;
		MEM_RD = 5'd8;
		MEM_ALU_RESULT = 32'd2;
		WB_MEM = 6'b000100;

		#20 CYCLE = 4'd2;
		IF_Instruction  = 32'b00000000000000000000000000000000;
		IF_PC_4 = 32'd4;
		WB_RD = 5'd0;
		WB_RD_DATA = 32'd0;
		WB = 3'd0;
		MEM_RD = 5'd0;
		MEM_ALU_RESULT = 32'd0;
		//--------------------
		#20 CASE = 4'd12; CYCLE = 4'd1;
		IF_Instruction  = 32'b00010001000010000000000000000000;
		IF_PC_4 = 32'd0;
		WB_RD = 5'd0;
		WB_RD_DATA = 32'd0;
		WB = 3'd1;
		MEM_RD = 5'd8;
		MEM_ALU_RESULT = 32'd12;
		WB_MEM = 6'b000100;

		#20 CYCLE = 4'd2;
		IF_Instruction  = 32'b00000000000000000000000000000000;
		IF_PC_4 = 32'd4;
		WB_RD = 5'd0;
		WB_RD_DATA = 32'd0;
		WB = 3'd0;
		MEM_RD = 5'd0;
		MEM_ALU_RESULT = 32'd0;
		WB_MEM = 6'b000000;
		//
	end

endmodule
