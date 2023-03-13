//	<Module names>		<Editor>
// 1. TOP_single		AHJIN
// 2. PC			YUNSUNG
// 3. Add			YUNSUNG				Use 32bit input & output
// 4. Instruction_memory	AHJIN
// 5. Control			AHJIN
// 6. Mux			AHJIN, YUNSUNG, SEUNGWON	Use 32bit input & 1 bit select sig
// 7. Registers			AHJIN
// 8. Sign_extend		AHJIN
// 9. ALU			SEUNGWON
// 10. ALU_control		SEUNGWON
// 11. Shift_left_2		YUNSUNG
// 12. Data_memory		SEUNGWON
// 13. And			YUNSUNG				Use 1bit input & output
//
// ALL connections are standard MIPS 32bit
// Use postive "RESET", "CLK" instance name for module.

module Top_single ( 
	RESET, 
	CLK
);

   	input RESET;
	input CLK;
	
	/*
	output ;
	*/
	
	wire [31:0] PC;				//[2.PC]
	wire [31:0] PC_next;			//[2.PC], [3.Add] (PC+4)
	wire [31:0] Read_address;		//[4.Instruction_memory]
	wire [31:0] Instruction;		//[4.Instruction_memory], [5.Control], [6.MUX], [7.Registers], [8.Sign_extend]
	wire RegDst;				//[5.Control], [6.MUX]
	wire Branch; 				//[5.Control], [12.Data_memory]
	wire MemtoReg;				//[5.Control], 
	wire [1:0] ALUOp;			//[5.Control], [10.ALU_control]
	wire MemWrite; 				//[5.Control], [12.Data_memory]
	wire ALUSrc; 				//[5.Control], [6.MUX]
	wire RegWrite; 				//[5.Control], [7.Registers]
	wire [4:0] Write_register;		//[6.MUX], [7.Registers]
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
	wire [31:0] ALU_result;			//[9.ALU], [12.Data_memory] 
	wire ALU_zero; 				//[9.ALU], [13.And]
	wire AND_out;				//[13.And]
	wire [31:0] Read_data;			//[12.Data_memory] 
	
	// 2. PC	-YUNSUNG
	PC PC(
		.CLK(CLK),		//IN
		.RESET(RESET),		//IN
		.PC_next(PC_next),	//IN
		.PC(PC) 		//OUT
	);
	
	// 3. Add1	-YUNSUNG
	Add Add1(
		.ADD_a(PC), 		//IN
		.ADD_b(32'd4),		//IN
		.ADD_out(ADD_OUT_1)	//OUT
	);
	
	// 4. Instruction_memory	-[AHJIN]
	Instruction_memory Instruction_memory(
		.CLK(CLK)			//IN
		.RESET(RESET),			//IN
		.Read_address(Read_address),	//IN
		.Instruction(Instruction)	//OUT
	);
	
	// 5. Control	-[AHJIN]
	Control Control(
		.opcode(instruction[31:26]), 	//IN
		.RegDst(RegDst),		//OUT
		.Branch(Branch),		//OUT
		.MemRead(MemRead),		//OUT
		.MemtoReg(MemtoReg),		//OUT
		.ALUOp(ALUOp),			//OUT
		.MemWrite(MemWrite),		//OUT
		.ALUSrc(ALUSrc),		//OUT
		.RegWrite(RegWrite)		//OUT
	);
	
	//6. Mux1	-[AHJIN]
	MUX1 MUX(
		.MUX_a(Instruction[20:16]),		//IN
		.MUX_b(Instruction[15:11]),		//IN
		.MUX_sig(Reg_Dst),			//IN
		.MUX_out(Write_register)		//OUT
	);
	
	//7. Registers	-[AHJIN]
	Registers Registers(
		.CLK(CLK),				//IN
		.RESET(RESET),				//IN
		.Read_register_1(Instruction[20:16]),	//IN
		.Read_register_2(Instruction[15:11]),	//IN
		.Write_register(Write_register),	//IN
		.Write_Data(Write_Data),		//IN
		.Read_data_1(Read_data_1),		//OUT
		.Read_data_2(Read_data_2)		//OUT
	);
	
	// 8. Sign_extend	-[AHJIN]
	Sign_extend Sign_extend(
		.Sign_extend_in(Instruction[15:0]),	//IN
		.Sign_extend(Sign_extend)		//OUT
	);
	
	//6. Mux2	-[SEUNGWON]
	MUX2 MUX(
		.MUX_a(Read_data_2),		//IN
		.MUX_b(Sign_extend),		//IN
		.MUX_sig(ALUSrc),		//IN
		.MUX_out(MUX_Registers)		//OUT
	);	
	
	// 10. ALU_control	-[SEUNGWON]
	ALU_control ALU_control(
		.ALU_control_IN(Instruction[5:0]),	//IN
		.ALUOp(ALUOp),				//IN
		.ALU_control(ALU_control)		//OUT
	);
	
	
	// 9. ALU	-[SEUNGWON]
	ALU ALU(
		.ALU_IN_1(Read_data_1),		//IN
		.ALU_IN_2(MUX_Registers),	//IN
		.ALU_control(ALU_control),	//IN
		.ALU_zero(ALU_zero),		//OUT
		.ALU_result(ALU_result)		//OUT
	);
	
	// 11. Shift_left_2	-YUNSUNG
	Shift_left_2 Shift_left_2(
		.Sign_extend(Sign_extend),
		.Shift_left_2_OUT(Shift_left_2_OUT)
	);
	
	// 3. Add2	-YUNSUNG
	Add Add2(
		.ADD_a(ADD_OUT_1), 		//IN
		.ADD_b(Shift_left_2_OUT),	//IN
		.ADD_out(Add_result)		//OUT
	);	
	
	// 13. And	-YUNSUNG
	AND AND(
		.AND_a(Branch),			//IN
		.AND_b(ALU_zero),		//IN
		.AND_out(AND_out)		//OUT
	);
	
	//6. Mux3	-YUNSUNG
	MUX3 MUX(
		.MUX_a(ADD_OUT_1),		//IN
		.MUX_b(Add_result),		//IN
		.MUX_sig(AND_out),		//IN
		.MUX_out(PC_next)		//OUT
	);	
	
	// 12. Data_memory	-[SEUNGWON]
	Data_memory Data_memory(
		.Address(ALU_result),		//IN
		.Write_data(Read_data_2),	//IN
		.MemWrite(MemWrite),		//IN
		.MemRead(MemRead),		//IN
		.Read_data(Read_data)		//OUT
	);
	
	//6. Mux4	-[SEUNGWON]
	MUX4 MUX(
		.MUX_a(Read_data),		//IN
		.MUX_b(ALU_result),		//IN
		.MUX_sig(MemtoReg),		//IN
		.MUX_out(Write_Data)		//OUT	
	);
	
endmodule
