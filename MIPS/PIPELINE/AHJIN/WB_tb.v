module WB_tb;

	reg CLK, RESET;
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

	end



endmodule
