`timescale 10ps / 10ps
module HAZARD_tb;

	reg CLK, RESET;
	reg [31:0] IF_PC_4;
	reg [31:0] ID_Instruction;
	reg EX_RegWrite; //@@@@@@@@@@@@@@@@@
	reg [5:0] EX_Opcode;
	reg [4:0] EX_RS, EX_RD;
	reg [5:0] MEM_Opcode;
	reg [4:0] MEM_RD;
	reg Branch;
	reg [1:0] Jump;
	wire PCWrite, IFIDWrite, Hazard_Ctrl;
	wire IF_Flush;
	//wire Bub_CNT, Bub_CNT_1d, CONT_2a, CONT_2b;
	//wire CONT_1, CONT_2a, CONT_2b, DATA_1, DATA_2, DATA_3;
	//wire NOT_EX_JUMP_LW_JP;
///*
	Hazard_detection_unit Hazard(
		.CLK(CLK),				//IN
		.RESET(RESET),				//IN
		.IF_PC_4(IF_PC_4),
		.opcode_ID(ID_Instruction[31:26]),	//IN
		.opcode_EX(EX_Opcode),			//IN
		.opcode_MEM(MEM_Opcode),
		.EX_RegWrite(EX_RegWrite),		//IN
		.ID_RS(ID_Instruction[25:21]), 		//IN
		.ID_RT(ID_Instruction[20:16]),		//IN
		.EX_RS(EX_RS),				//IN
		.EX_RD(EX_RD),				//IN
		.MEM_RD(MEM_RD),
		.Branch(Branch),			//IN
		.Jump(Jump),				//IN
		.PCWrite(PCWrite),			//OUT
		.IFIDWrite(IFIDWrite),			//OUT
		.IF_Flush(IF_Flush),			//OUT
		.Hazard_Ctrl(Hazard_Ctrl)		//OUT
		//.Bub_CNT(Bub_CNT),
		//.Bub_CNT_1d(Bub_CNT_1d),
		//.CONT_2a(CONT_2a), 
		//.CONT_2b(CONT_2b)
	);
//*/
/*
	Hazard_detection_unit Hazard_test( 
	.CLK(CLK), 
	.opcode_ID(ID_Instruction[31:26]), 
	.opcode_EX(EX_Opcode), 
	.ID_RS(ID_Instruction[25:21]), 
	.ID_RT(ID_Instruction[20:16]), 
	.EX_RS(EX_RS), 
	.EX_RD(EX_RD), 
	.Branch(Branch),
	.Jump(Jump),
	.CONT_1(CONT_1), 
	.CONT_2a(CONT_2a), 
	.CONT_2b(CONT_2b), 
	.DATA_1(DATA_1), 
	.DATA_2(DATA_2), 
	.DATA_3(DATA_3),
	.NOT_EX_JUMP_LW_JP(NOT_EX_JUMP_LW_JP),
	.PCWrite(PCWrite), 
	.IFIDWrite(IFIDWrite), 
	.IF_Flush(IF_Flush), 
	.Hazard_Ctrl(Hazard_Ctrl)
);
	*/

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
		#10 RESET = 1'b1; IF_PC_4 = 31'd0; ID_Instruction = 32'b00000000000000000000000000000000;
		#20 RESET = 1'b0;
/*
//DATA1
		#10 ID_Instruction = 32'b10001111101010000000000000000000; 
		EX_Opcode =6'b100011;
		EX_RS = 5'b11101; EX_RD = 5'b01000;
		Branch = 1'b0; Jump = 2'b00;
*/
//CONT2
		#20 IF_PC_4 = 31'd0; ID_Instruction = 32'b00010101001010100000000000000000; 
		EX_Opcode =6'b100011;
		EX_RS = 5'b01000; EX_RD = 5'b01010;
		MEM_Opcode = 6'b000000;
		MEM_RD = 5'b00000;
		Branch = 1'b0; Jump = 2'b00;
//CONT1
/*
		#10 ID_Instruction = 32'b00010001001111000000000000000000; 
		EX_Opcode =6'b000000;
		EX_RS = 5'b01000; EX_RD = 5'b01001;
		Branch = 1'b0; Jump = 2'b00;
	*/
		#20 IF_PC_4 = 31'd4; ID_Instruction = 32'b00010101001010100000000000000000; 
		EX_Opcode =6'b000101;
		EX_RS = 5'b01000; EX_RD = 5'b01010;
		MEM_Opcode = 6'b100011;
		MEM_RD = 5'b01010;
		Branch = 1'b0; Jump = 2'b00;

		#20 IF_PC_4 = 31'd8; ID_Instruction = 32'b00000000000000000000000000000000; 
		EX_Opcode =6'b000000;
		EX_RS = 5'b00000; EX_RD = 5'b00000;
		Branch = 1'b0; Jump = 2'b00;

		#60 IF_PC_4 = 31'd12; ID_Instruction = 32'b00000000000000000000000000000000; 
		EX_Opcode =6'b000000;
		EX_RS = 5'b00000; EX_RD = 5'b00000;
		Branch = 1'b1; Jump = 2'b00;

	end

endmodule
