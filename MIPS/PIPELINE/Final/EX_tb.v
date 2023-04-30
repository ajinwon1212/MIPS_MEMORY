module EX_tb();

	reg CLK;            
	reg RESET;    

	reg [3:0] CASE, CYCLE;
     
	reg [31:0] WB_MEM_EX_32;      
	reg [31:0] ID_Instruction;
	reg [31:0] ID_RS_DATA, ID_RT_DATA, ID_Sign_extend;
	reg [31:0] ID_RD_32;
	reg [31:0] ID_PC_4; 

	wire [31:0] ALU_result;
	wire [1:0] FW_sig_EX_1, FW_sig_EX_2;

   	wire [4:0] EX_RS;         
	wire [4:0] EX_RT;        
	wire [31:0] EX_RS_Data;      
	wire [31:0] EX_RT_Data;   
	wire [31:0] EX_RS_DATA, EX_RT_DATA;  

	wire [31:0] Hi, Lo, HI, LO;

	wire [4:0] MEM_RD;
	wire [31:0] MEM_ALU_RESULT;

	reg [4:0] WB_RD;
	reg [31:0] WB_RD_DATA; //WB_RD_Data X
	reg [2:0] WB; //[0] == RegWrite

	wire [10:0] WB_MEM_EX;
	wire [5:0] EX_Opcode;        
    
	wire [31:0] EX_Sign_extend;     
	wire [4:0] EX_Shmpt;        
	wire [5:0] EX_Funct;      
	wire [4:0] EX_RD;          
	wire [31:0] EX_PC_4;       

	wire [3:0] ALU_control;
	wire [31:0] EX_ALU_RESULT;

	wire [4:0] WB_MEM; //[2] == RegWrite
	wire [31:0] MEM_PC_4;
	wire [31:0] MEM_RT_DATA;
	wire [5:0] MEM_Opcode;

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
		.FW_sig2(FW_sig_EX_2)
	);

	EXMEM_Reg EXMEM(
		.CLK(CLK),
		.RESET(RESET),
		.WB_MEM_EX(WB_MEM_EX),
		.EX_Opcode(EX_Opcode),
		.EX_ALU_RESULT(EX_ALU_RESULT),
		.EX_RT_DATA(EX_RT_Data),
		.EX_RD(EX_RD),
		.EX_PC_4(EX_PC_4),
		.WB_MEM(WB_MEM),
		.MEM_Opcode(MEM_Opcode),
		.MEM_ALU_RESULT(MEM_ALU_RESULT),
		.MEM_RT_DATA(MEM_RT_DATA),
		.MEM_RD(MEM_RD),
		.MEM_PC_4(MEM_PC_4)
	);


	initial
		begin
  		CLK = 1'b1;
   			forever
   			begin
     			#10 CLK = !CLK;
   			end
	end

	initial
	begin
		#10 RESET = 1'b1; 
		#10 RESET = 1'b0; 
/*
		0. normal operation
		 :No Forwarding RS, RT
		1. Fowarding case RT
		 :No Forwarding RS, Forwarding RT(MEM)
		2. Fowarding case RS
		 :Forwarding RS(MEM), No Forwarding RT
		3. Fowarding case RS, RT
		 :Forwarding RS(WB), Forwarding RT(WB)
		4. Double data hazard RS
		 :Forwarding RS(MEM, WB), No forwarding RT
		5. mflo, mfhi test
*/
		
		//--------------
		CASE = 4'd0; CYCLE = 4'd1;
		WB_MEM_EX_32 = 32'b00000000000000000000000100001000;
		ID_Instruction = 32'b00000000111001100011100000100000;
		ID_RD_32 = 32'd7;
		ID_PC_4 = 32'd0;
		ID_RS_DATA = 32'd1; 
		ID_RT_DATA = 32'd2; 
		ID_Sign_extend =32'd0;
		WB_RD = 5'd0;
		WB_RD_DATA = 32'd0;
		WB = 3'b0; //[0]
		
		#20 CASE = 4'd0; CYCLE = 4'd2;
		WB_MEM_EX_32 = 32'b00000000000000000000000100001000;
		ID_Instruction = 32'b00000000101001100011100000100000;
		ID_RS_DATA = 32'd5; 
		ID_RT_DATA = 32'd8; 
		ID_RD_32 = 32'd7;
		ID_PC_4 = 32'd4;

		#20 CASE = 4'd0; CYCLE = 4'd3;
		WB_MEM_EX_32 = 32'b0;
		ID_Instruction = 32'b0;
		ID_RS_DATA = 32'd0; 
		ID_RT_DATA = 32'd0; 
		ID_RD_32 = 32'd0;
		ID_PC_4 = 32'd8;

		//--------------
		#20 CASE = 4'd1; CYCLE = 4'd1;
		WB_MEM_EX_32 = 32'b00000000000000000000000100001000;
		ID_Instruction = 32'b00000000101001100011100000100000;
		ID_RS_DATA = 32'd1; 
		ID_RT_DATA = 32'd2; 
		ID_RD_32 = 32'd7;
		ID_PC_4 = 32'd0;

		#20 CASE = 4'd1; CYCLE = 4'd2;
		WB_MEM_EX_32 = 32'b00000000000000000000000100001000;
		ID_Instruction = 32'b00000000110001110100000000100000;
		ID_RS_DATA = 32'd5; 
		ID_RT_DATA = 32'd8; 
		ID_RD_32 = 32'd8;
		ID_PC_4 = 32'd4;

		#20 CASE = 4'd1; CYCLE = 4'd3;
		WB_MEM_EX_32 = 32'b0;
		ID_Instruction = 32'b0;
		ID_RS_DATA = 32'd0; 
		ID_RT_DATA = 32'd0; 
		ID_RD_32 = 32'd0;
		ID_PC_4 = 32'd8;


		//--------------
		#20 CASE = 4'd2; CYCLE = 4'd1;
		WB_MEM_EX_32 = 32'b00000000000000000000000100001000;
		ID_Instruction = 32'b00000000101001100011100000100000;
		ID_RS_DATA = 32'd1; 
		ID_RT_DATA = 32'd2; 
		ID_RD_32 = 32'd7;
		ID_PC_4 = 32'd0;

		#20 CASE = 4'd2; CYCLE = 4'd2;
		WB_MEM_EX_32 = 32'b00000000000000000000000100001000;
		ID_Instruction = 32'b00000000111001100100000000100000;
		ID_RS_DATA = 32'd5; 
		ID_RT_DATA = 32'd8; 
		ID_RD_32 = 32'd8;
		ID_PC_4 = 32'd4;

		#20 CASE = 4'd2; CYCLE = 4'd3;
		WB_MEM_EX_32 = 32'b0;
		ID_Instruction = 32'b0;
		ID_RS_DATA = 32'd0; 
		ID_RT_DATA = 32'd0; 
		ID_RD_32 = 32'd0;
		ID_PC_4 = 32'd8;

		//--------------
		#20 CASE = 4'd3; CYCLE = 4'd1;
		WB_MEM_EX_32 = 32'b00000000000000000000000100001000;
		ID_Instruction = 32'b00000000101001010011100000100000;
		ID_RS_DATA = 32'd1; 
		ID_RT_DATA = 32'd2; 
		ID_RD_32 = 32'd7;
		ID_PC_4 = 32'd0;
		WB_RD = 5'd5;
		WB_RD_DATA = 32'd99;
		WB = 3'b001; //[0]

		#20 CASE = 4'd3; CYCLE = 4'd2;
		WB_MEM_EX_32 = 32'b0;
		ID_Instruction = 32'b0;
		ID_RS_DATA = 32'd0; 
		ID_RT_DATA = 32'd0; 
		ID_RD_32 = 32'd0;
		ID_PC_4 = 32'd4;
		WB_RD = 5'd0;
		WB_RD_DATA = 32'd0;
		WB = 3'b0; //[0]


		//--------------
		#20 CASE = 4'd4; CYCLE = 4'd1;
		WB_MEM_EX_32 = 32'b00000000000000000000000100001000;
		ID_Instruction = 32'b00000000101001100010100000100000;
		ID_RS_DATA = 32'd1; 
		ID_RT_DATA = 32'd2; 
		ID_RD_32 = 32'd5;
		ID_PC_4 = 32'd0;
		WB_RD = 5'd0;
		WB_RD_DATA = 32'd0;
		WB = 3'b0; //[0]

		#20 CASE = 4'd4; CYCLE = 4'd2;
		WB_MEM_EX_32 = 32'b00000000000000000000000100001000;
		ID_Instruction = 32'b00000000101001100011100000100000;
		ID_RS_DATA = 32'd5; 
		ID_RT_DATA = 32'd8; 
		ID_RD_32 = 32'd7;
		ID_PC_4 = 32'd4;
		WB_RD = 5'd5;
		WB_RD_DATA = 32'd99;
		WB = 3'b001; //[0]

		#20 CASE = 4'd4; CYCLE = 4'd3;
		WB_MEM_EX_32 = 32'b0;
		ID_Instruction = 32'b0;
		ID_RS_DATA = 32'd0; 
		ID_RT_DATA = 32'd0; 
		ID_RD_32 = 32'd0;
		ID_PC_4 = 32'd8;
		WB_RD = 5'd0;
		WB_RD_DATA = 32'd0;
		WB = 3'b0; //[0]

		//--------------
		#20 CASE = 4'd5; CYCLE = 4'd1;
		WB_MEM_EX_32 = 32'b00000000000000000000000000001000;
		ID_Instruction = 32'b00000000101001100000000000011000;
		ID_RS_DATA = 32'hffffffff; 
		ID_RT_DATA = 32'd3; //2 FFFF FFFD
		ID_RD_32 = 32'd0;
		ID_PC_4 = 32'd0;

		#20 CASE = 4'd5; CYCLE = 4'd2;
		WB_MEM_EX_32 = 32'b00000000000000000000000100001010;
		ID_Instruction = 32'b00000000000000000001100000010000;
		ID_RS_DATA = 32'd0; 
		ID_RT_DATA = 32'd0; 
		ID_RD_32 = 32'd3;
		ID_PC_4 = 32'd4;

		#20 CASE = 4'd5; CYCLE = 4'd3;
		WB_MEM_EX_32 = 32'b00000000000000000000000100001001;
		ID_Instruction = 32'b00000000000000000010000000010010;
		ID_RS_DATA = 32'd0; 
		ID_RT_DATA = 32'd0; 
		ID_RD_32 = 32'd4;
		ID_PC_4 = 32'd8;

		#20 CASE = 4'd5; CYCLE = 4'd4;
		WB_MEM_EX_32 = 32'b0;
		ID_Instruction = 32'b0;
		ID_RS_DATA = 32'd0; 
		ID_RT_DATA = 32'd0; 
		ID_RD_32 = 32'd0;
		ID_PC_4 = 32'd12;


	end

endmodule
