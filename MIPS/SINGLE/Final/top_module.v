
module Top_single(RESET, CLK, PC, PC_next, Instruction, 
Read_data_1, Read_data_2, Write_Data, ALUOp, 
ALU_control, ALU_result, HI, LO, ALU_result_s, ALU_zero, Read_data, ADD_OUT_1);

//module Top_single(RESET, CLK, PC, PC_next, Instruction, 
//Read_data_1, Read_data_2, Write_Data, ALUOp, 
//ALU_control, ALU_result, HI, LO, ALU_zero, Read_data, ADD_OUT_1);

   	input RESET;
	input CLK;
	
	
	output [31:0] PC, PC_next;
	output [31:0] Instruction;
	output [31:0] Read_data_1, Read_data_2, Write_Data;
	output [2:0] ALUOp;	
	output [3:0] ALU_control;
	output [31:0] ALU_result;	
	output [31:0] HI, LO, ALU_result_s;
	output ALU_zero;
	output [31:0] Read_data;
	output [31:0] ADD_OUT_1;

	
	wire [31:0] PC;				//[2.PC]
	wire [31:0] PC_next;			//[2.PC], [3.Add] (PC+4)
	wire [31:0] Instruction;		//[4.Instruction_memory], [5.Control], [6.MUX], [7.Registers], [8.Sign_extend]
	wire [31:0] Jump_address_without_PC;	//[11.Shift_left_2]
	wire [31:0] MUX_IN;			//[6.MUX]
	
	//Control Signal
	wire [1:0] RegDst;			//[5.Control], [6.MUX]
	wire [1:0] Jump;			//[5.Control], [6.MUX]
	wire Branch; 				//[5.Control], [13.And]
	wire MemRead;				//[5.Control], [12.Data_memory]
	wire [1:0] MemtoReg;			//[5.Control], [6.MUX]
	wire [2:0] ALUOp;			//[5.Control], [10.ALU_control]
	wire MemWrite; 				//[5.Control], [12.Data_memory]
	wire ALUSrc; 				//[5.Control], [6.MUX]
	wire RegWrite; 				//[5.Control], [7.Registers]
	wire [1:0] HiLo;			//[5.Control], [9.ALU]

	wire [31:0] Write_register_31;		//[6.MUX], [7.Registers]
	wire [31:0] Write_Data; 		//[6.MUX], [7.Registers]
	wire [31:0] Read_data_1;   		//[7.Registers], [9.ALU]
	wire [31:0] Read_data_2; 		//[7.Registers], [6.MUX]
	wire [31:0] MUX_Registers;		//[6.MUX]
	wire [31:0] Sign_extend;		//[8.Sign_extend], [11.Shift_left_2]
	wire [31:0] Shift_left_2_OUT;		//[11.Shift_left_2]
	wire [31:0] ADD_OUT_1; 			//[3.Add]
	wire [31:0] ADD_OUT_2; 			//[3.Add]
	wire [31:0] Add_result;			//[3.Add], [6.MUX]
	wire [3:0] ALU_control; 		//[10.ALU_control], [9.ALU]
	wire [31:0] ALU_result;			//[9.ALU]
	wire [31:0] ALU_result_s;		//[9.ALU],[6.MUX],[12.Data_memory]
	wire [31:0] Hi, Lo, HI, LO;
	wire ALU_zero; 				//[9.ALU], [13.And]
	wire AND_out;				//[13.And]
	wire [31:0] Read_data;			//[12.Data_memory] 
	
	// 2. PC	-YUNSUNG
	PC PC_top(
		.CLK(CLK),		//IN
		.RESET(RESET),		//IN
		.PC_next(PC_next),	//IN
		.PC(PC) 		//OUT
	);
	
	// 3. Add1	-YUNSUNG
	Add Add1(
		.RESET(RESET),		//IN
		.ADD_a(PC), 		//IN
		.ADD_b(32'd4),		//IN
		.ADD_out(ADD_OUT_1)	//OUT
	);
	
	// 4. Instruction_memory	-[AHJIN]
	Instruction_memory Instruction_memory_top(
		.CLK(CLK),			//IN
		.RESET(RESET),			//IN
		.Read_address(PC),		//IN
		.Instruction(Instruction)	//OUT
	);
	
	// 11. Shift_left_2_1	-YUNSUNG
	Shift_left_2 Shift_left_2_Ins_top(
		.Shift_left_2_IN({6'd0, Instruction[25:0]}),	//IN
		.Shift_left_2_OUT(Jump_address_without_PC)	//OUT
	);
	
	// 5. Control	-[AHJIN]
	Control Control_top(
		.CLK(CLK),			//IN
		.RESET(RESET),			//IN
		.opcode(Instruction[31:26]), 	//IN
		.funct(Instruction[5:0]),	//IN
		.RegDst(RegDst),		//OUT
		.Jump(Jump),			//OUT
		.Branch(Branch),		//OUT
		.MemRead(MemRead),		//OUT
		.MemtoReg(MemtoReg),		//OUT
		.ALUOp(ALUOp),			//OUT
		.MemWrite(MemWrite),		//OUT
		.ALUSrc(ALUSrc),		//OUT
		.RegWrite(RegWrite),		//OUT
		.HiLo(HiLo)			//OUT
	);
	
	//6. Mux1	-[AHJIN]
	FourOneMUX MUX1(
		.MUX_a({27'd0, Instruction[20:16]}),	//IN
		.MUX_b({27'd0, Instruction[15:11]}),	//IN
		.MUX_c(32'd31),	//IN
		.MUX_d(32'd0),	//IN
		.MUX_sig(RegDst),			//IN
		.MUX_out(Write_register_31)		//OUT
	);
	
	//7. Registers	-[AHJIN]
	Registers Registers_top(
		.CLK(CLK),					//IN
		.RESET(RESET),					//IN
		.RegWrite(RegWrite),				//IN
		.Read_register_1(Instruction[25:21]),		//IN
		.Read_register_2(Instruction[20:16]),		//IN
		.Write_register(Write_register_31[4:0]),	//IN
		.Write_Data(Write_Data),			//IN
		.Read_data_1(Read_data_1),			//OUT
		.Read_data_2(Read_data_2)			//OUT
	);
	
	// 8. Sign_extend	-[AHJIN]
	Sign_extend Sign_extend_top(
		.Sign_extend_in(Instruction[15:0]),	//IN
		.Sign_extend(Sign_extend)		//OUT
	);
	
	//6. Mux2	32bit mux -YUNSUNG
	MUX MUX2(
		.MUX_a(Read_data_2),		//IN
		.MUX_b(Sign_extend),		//IN
		.MUX_sig(ALUSrc),		//IN
		.MUX_out(MUX_Registers)		//OUT
	);	
	
	// 10. ALU_control	-[SEUNGWON]
	ALU_control ALU_control_top(
		.ALU_control_IN(Instruction[5:0]),	//IN
		.ALUOp(ALUOp),				//IN
		.ALU_control(ALU_control)		//OUT
	);
	
	
	// 9. ALU	-[SEUNGWON]
	ALU ALU_top(
		.CLK(CLK),
		.ALU_IN_1(Read_data_1),		//IN
		.ALU_IN_2(MUX_Registers),	//IN
		.ALU_control(ALU_control),	//IN
		.Shampt(Instruction[10:6]),	//IN
		.ALU_zero(ALU_zero),		//OUT
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
	



	//6. Mux5	32bit mux -YUNSUNG
	FourOneMUX MUX5(
		.MUX_a(ALU_result),		//IN
		.MUX_b(LO),			//IN
		.MUX_c(HI),			//IN
		.MUX_d(32'b0),			//IN
		.MUX_sig(HiLo),			//IN
		.MUX_out(ALU_result_s)		//OUT	
	);
	
	// 11. Shift_left_2_2	-YUNSUNG
	Shift_left_2 Shift_left_2_top(
		.Shift_left_2_IN(Sign_extend),
		.Shift_left_2_OUT(Shift_left_2_OUT)
	);
	
	// 3. Add2	-YUNSUNG
	Add Add2(
		.RESET(RESET),			//IN
		.ADD_a(ADD_OUT_1), 		//IN
		.ADD_b(Shift_left_2_OUT),	//IN
		.ADD_out(Add_result)		//OUT
	);	
	
	// 13. And	-YUNSUNG
	AND AND_top(
		.AND_a(Branch),		//IN
		.AND_b(ALU_zero),		//IN
		.AND_out(AND_out)		//OUT
	);
	
	//6. Mux3	32bit mux -YUNSUNG
	MUX MUX3(
		.MUX_a(ADD_OUT_1),		//IN
		.MUX_b(Add_result),		//IN
		.MUX_sig(AND_out),		//IN
		.MUX_out(MUX_IN)		//OUT
	);	
	
	//6. Mux4	32bit mux -YUNSUNG
	FourOneMUX MUX4(
		.MUX_a(MUX_IN),							//IN
		.MUX_b({ADD_OUT_1[31:28], Jump_address_without_PC[27:0]}),	//IN
		.MUX_c(Read_data_1),						//IN
		.MUX_d(32'd0),							//IN
		.MUX_sig(Jump),							//IN
		.MUX_out(PC_next)						//OUT
	);
	
	// 12. Data_memory	-[SEUNGWON]
	Data_memory Data_memory_top(
		.CLK(CLK),
		.RESET(RESET),
		.Address(ALU_result_s),		//IN
		.Write_Data(Read_data_2),	//IN
		.MemWrite(MemWrite),		//IN
		.MemRead(MemRead),		//IN
		.Read_data(Read_data)		//OUT
	);
	
	//6. Mux6	32bit mux -YUNSUNG
	FourOneMUX MUX6(
		.MUX_a(ALU_result_s),		//IN
		.MUX_b(Read_data),		//IN
		.MUX_c(ADD_OUT_1),		//IN
		.MUX_d(32'b0),			//IN
		.MUX_sig(MemtoReg),		//IN
		.MUX_out(Write_Data)		//OUT	
	);
	
endmodule
