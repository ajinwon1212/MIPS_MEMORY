`timescale 1ns / 1ns

module IF_CACHE_tb;

	reg [3:0] CASE, CYCLE;
	reg [31:0] JUMP_Addr, BTB_Addr;
	reg Branch, JUMP;
	wire [31:0] PC_next;
	wire [31:0] IF_PC_4;

	reg CLK, RESET;
	reg PCWrite;
	wire [31:0] PC;
	wire PCLK;
	wire [31:0] IF_Instruction;
	reg IFIDWrite, IF_Flush;
	wire FLUSH;
	wire [31:0] ID_INSTRUCTION;
	wire [31:0] ID_PC_4;

	wire PCWRITE; //PCWrite || HitWrite
	//wire IFIDWRITE; //IFIDWrite || HitWrite
	wire [2:0] TYPE; //@@@@@@@@@

	wire HitWrite;
        wire Access_MM;
        wire [31:0] Data_MM;
        wire [19:0] CNT_HIT, CNT_MISS;
	wire CCLK;
	wire [1:0] CONT;
	//wire [2:0] INDEX;
	//wire VALID;
	//wire [2:0] FIFO;


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

/*
	Cache_Fully Fully(
		.CLK(CLK), 			//IN
		.RESET(RESET),			//IN 
		.PC(PC),			//IN 
		.Access_MM(Access_MM), 		//IN
		.Data_MM(Data_MM), 		//IN
		.HitWrite(HitWrite), 		//OUT
		.Data_Cache(IF_Instruction), 	//OUT
		.CNT_HIT(CNT_HIT), 		//OUT
		.CNT_MISS(CNT_MISS),		//OUT
		.FIFO(FIFO)			//OUT
	);*/
        Cache_Direct Direct(
                .CLK(PCLK),                     //IN
                .RESET(RESET),                  //IN
                .PC(PC),                        //IN
		.index(PC[4:2]),		//IN
                .Access_MM(Access_MM),          //IN
                .Data_MM(Data_MM),              //IN
                .HitWrite(HitWrite),            //OUT
                .Data_Cache(IF_Instruction),    //OUT
                .CNT_HIT(CNT_HIT),              //OUT
                .CNT_MISS(CNT_MISS),            //OUT
		.CCLK(CCLK),			//OUT
		.CONT(CONT)			//OUT
		//.INDEX(INDEX),
		//.VALID(VALID)
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
		RESET = 1'b0;
		#20 RESET = 1'b1;
		#10 RESET = 1'b0; 		
		PCWrite = 1'b1;
		IFIDWrite = 1'b1;
		IF_Flush = 1'b0;
		//1. PC+4 test with MISS
		CASE=4'd1; //[0]
		JUMP_Addr = 32'd60;
		BTB_Addr = 32'd12;
		Branch = 1'b0;
		JUMP = 1'b0;
		#40 CASE=4'd1; //[4]
		#40 CASE=4'd1; //[8]
		#40 CASE=4'd1; //[12]
		#40 CASE=4'd1; //[16]
		#40 CASE=4'd1; //[20]
		#40 CASE=4'd1; //[24]
		#40 CASE=4'd1; //[28]
		#40 CASE=4'd1;  //[32]
		#40 CASE=4'd1;  //[36]

		//2. Jump(JUMP instruction) test with MISS
		#40 CASE=4'd2; //[60]
		JUMP = 1'b1; IF_Flush = 1'b1; //IFIDWrite = 1'b0;
		#20  IF_Flush = 1'b0; //IFIDWrite = 1'b1;
		#20 CASE=4'd2; //[64]
		JUMP = 1'b0; IF_Flush = 1'b0;
		#20 CASE=4'd2; //[68]

		//3. Jump(Branch instruction) test with HIT
		#40 CASE=4'd3; //[12]
		Branch = 1'b1; IF_Flush = 1'b1; //IFIDWrite = 1'b0;
		#20  IF_Flush = 1'b0; //IFIDWrite = 1'b1;

		//4. PC+4 test with HIT
		#20 CASE=4'd4; //[16]
		Branch = 1'b0; IF_Flush = 1'b0;
		#20 CASE=4'd4; //[20]

		//5. IFIDWrite test
		#20 CASE=4'd5;
		IFIDWrite = 1'b0; //[24]

		//6. PCWrite test
		#20 CASE=4'd5; 
		IFIDWrite = 1'b1;
		PCWrite = 1'b0; //[24]

	end

endmodule
