`timescale 1ps / 1ps  

module Top_single_TB;

	reg CLK, RESET;


	wire [31:0] PC, PC_next, ADD_OUT_1;
	wire [31:0] Instruction;
	wire [31:0] Read_data_1, Read_data_2, Write_Data;
	wire [2:0] ALUOp;	
	wire [3:0] ALU_control;
	wire [31:0] ALU_result;	
	wire [31:0] HI, LO, ALU_result_s;	
	wire ALU_zero;
	wire [31:0] Read_data;
	wire [4:0] RS = Instruction[25:21];
	wire [4:0] RT = Instruction[20:16];
	wire [4:0] RD = Instruction[15:11];
	//Top_single single( .RESET(RESET), .CLK(CLK) );

	Top_single single(
		.RESET(RESET), 
		.CLK(CLK), 
		.PC(PC), 
		.PC_next(PC_next), 
		.Instruction(Instruction), 
		.Read_data_1(Read_data_1), 
		.Read_data_2(Read_data_2), 
		.Write_Data(Write_Data), 
		.ALUOp(ALUOp),
		.ALU_control(ALU_control), 
		.ALU_result(ALU_result),
		.HI(HI),
		.LO(LO),
		.ALU_result_s(ALU_result_s),
		.ALU_zero(ALU_zero), 
		.Read_data(Read_data),
		.ADD_OUT_1(ADD_OUT_1)
	);


	initial
	begin
		CLK = 1'b0;
		forever
		begin
			#400 CLK = !CLK;
		end
	end

	initial
	begin
		RESET = 1'b1;
		#400 RESET = 1'b0; 
	end


endmodule
