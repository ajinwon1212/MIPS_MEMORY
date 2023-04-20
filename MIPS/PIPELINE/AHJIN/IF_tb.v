`timescale 1ns / 1ns

module IF_tb;

	reg [3:0] CASE, CYCLE;
	reg [31:0] Jump_Addr, BTB_Addr;
	reg Branch, Jump;
	wire [31:0] PC_next;
	wire [31:0] IF_PC_4;

	MUX4to1 MUX1(
		.a(IF_PC_4),		//IN (00)
		.b(Jump_Addr),		//IN (01)
		.c(BTB_Addr),		//IN (10)
		.d(32'd0),
		.sig({Branch, Jump}),	//IN @@@@@@@@@@@@@@@@@@@@@@
		.out(PC_next)		//OUT
	);

	reg CLK, RESET;
	reg PCWrite;
	wire [31:0] PC;

	PC PC_top(
		.CLK(CLK),		//IN
		.RESET(RESET),		//IN
		.PCWrite(PCWrite),	//IN
		.PC_next(PC_next),	//IN
		.PC(PC)			//OUT
	);

	ADD ADD1(
		.a(PC),		//IN
		.b(32'd4),	//IN
		.out(IF_PC_4)	//OUT
	);

	wire [31:0] IF_Instruction;

	Instruction_memory Inst_Mem(
		.CLK(CLK),			//IN
		.RESET(RESET),			//IN
		.PC(PC),			//IN
		.IF_Instruction(IF_Instruction)	//OUT
	);

	reg IFIDWrite, IF_Flush;
	wire [31:0] ID_Instruction;
	wire [31:0] ID_PC_4;

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
		RESET = 1'b1;
		#10 RESET = 1'b0; 

		#20 CASE=4'd1; CYCLE=4'd1;
	//0. PC+4 Test 00100011101111011111111111110000
		Jump_Addr = 31'd4;
		BTB_Addr = 31'd16;
		Branch = 1'b0;
		Jump = 1'b0;
		PCWrite = 1'b1;
		IFIDWrite = 1'b1;
		IF_Flush = 1'b0;
		#20 CASE=4'd1; CYCLE=4'd2;
		#20 CASE=4'd1; CYCLE=4'd3;


		#20 CASE=4'd2; CYCLE=4'd1;
	//1.Jump Test
		Jump_Addr = 31'd4; //00100000000100000000000000001000
		BTB_Addr = 31'd16; //00000000000000000000000000000000
		Branch = 1'b0;
		Jump = 1'b1;
		PCWrite = 1'b1;
		IFIDWrite = 1'b1;
		IF_Flush = 1'b0;

		#20 CASE=4'd3; CYCLE=4'd1;
	//2. Branch Test
		Jump_Addr = 31'd4;
		BTB_Addr = 31'd16;
		Branch = 1'b1;
		Jump = 1'b0;
		PCWrite = 1'b1;
		IFIDWrite = 1'b1;
		IF_Flush = 1'b0;

		#20 CASE=4'd4; CYCLE=4'd1;
	//3. PCWrite, IFIDWrite Test
		Jump_Addr = 31'd4;
		BTB_Addr = 31'd16;
		Branch = 1'b0;
		Jump = 1'b0;
		PCWrite = 1'b0;
		IFIDWrite = 1'b0;
		IF_Flush = 1'b0;

		#20 CASE=4'd5; CYCLE=4'd1;
	//4. IF_Flush Test
		Jump_Addr = 31'd4;
		BTB_Addr = 31'd16;
		Branch = 1'b0;
		Jump = 1'b0;
		PCWrite = 1'b1;
		IFIDWrite = 1'b1;
		IF_Flush = 1'b1;


	end

endmodule
