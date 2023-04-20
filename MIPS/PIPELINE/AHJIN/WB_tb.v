module WB_tb;

	reg CLK, RESET;
	
	reg [3:0] CASE, CYCLE;

	reg [4:0] WB_MEM;
	reg [31:0] MEM_ALU_RESULT;
	reg [31:0] MEM_RD_DATA;
	reg [4:0] MEM_RD;
	reg [31:0] MEM_PC_4;

	wire [2:0] WB;
	wire [31:0] WB_ALU_RESULT;
	wire [31:0] WB_RD_Data;
	wire [4:0] WB_RD;
	wire [31:0] WB_PC_4;

	wire [31:0] WB_RD_DATA;



	//WB_EX
	//   2    /   1    /
	//MemtoReg/RegWrite/


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

	MUX4to1 MUX9(
		.a(WB_RD_Data),		//IN
		.b(WB_ALU_RESULT),	//IN
		.c(WB_PC_4),		//IN
		.d(32'b0),		//IN
		.sig(WB[2:1]),		//IN
		.out(WB_RD_DATA)	//OUT	
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
		/*
		[WB_tb]
		
		1. WB Data from MEM READ (LW)
		2. WB Data from ALU (R ...)
		3. WB data from PC+4 (jal)

		*/

		//----------------
		#20
		CASE = 4'd1; CYCLE=4'd1;
		WB_MEM = 5'b01110;
		MEM_ALU_RESULT = 32'd1;
		MEM_RD_DATA = 32'd2;
		MEM_RD = 5'd10;
		MEM_PC_4 = 32'd0;

		#20
		CASE = 4'd1; CYCLE=4'd2;
		WB_MEM = 5'd0;
		MEM_ALU_RESULT = 32'd0;
		MEM_RD_DATA = 32'd0;
		MEM_RD = 5'd0;
		MEM_PC_4 = 32'd4;

		//----------------
		#40
		CASE = 4'd2; CYCLE=4'd1;
		WB_MEM = 5'b00100;
		MEM_ALU_RESULT = 32'd1;
		MEM_RD_DATA = 32'd2;
		MEM_RD = 5'd10;
		MEM_PC_4 = 32'd0;

		#20
		CASE = 4'd1; CYCLE=4'd2;
		WB_MEM = 5'd0;
		MEM_ALU_RESULT = 32'd0;
		MEM_RD_DATA = 32'd0;
		MEM_RD = 5'd0;
		MEM_PC_4 = 32'd4;	

		//----------------
		#40 
		CASE = 4'd3; CYCLE=4'd1;
		WB_MEM = 5'b10100;
		MEM_ALU_RESULT = 32'd1;
		MEM_RD_DATA = 32'd2;
		MEM_RD = 5'd10;
		MEM_PC_4 = 32'd0;

		#20
		CASE = 4'd1; CYCLE=4'd2;
		WB_MEM = 5'd0;
		MEM_ALU_RESULT = 32'd0;
		MEM_RD_DATA = 32'd0;
		MEM_RD = 5'd0;
		MEM_PC_4 = 32'd4;

	end



endmodule
