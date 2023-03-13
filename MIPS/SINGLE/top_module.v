//	<Module names>		<Editor>
// 1. TOP_single		AHJIN
// 2. PC			YUNSUNG
// 3. Add			YUNSUNG
// 4. Instruction_memory	AHJIN
// 5. Control			AHJIN
// 6. Mux			AHJIN, YUNSUNG, SEUNGWON
// 7. Registers			AHJIN
// 8. Sign_extend		AHJIN
// 9. ALU			SEUNGWON
// 10. ALU_control		SEUNGWON
// 11. Shift_left_2		YUNSUNG
// 12. Data_memory		SEUNGWON
// 13. And			YUNSUNG
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
	wire [1:0] RegDst;			//[5.Control], [6.MUX]
	wire Branch; 				//[5.Control], [12.Data_memory]
	wire [1:0] MemtoReg;			//[5.Control], 
	wire [1:0] ALUOp;			//[5.Control], [10.ALU_control]
	wire MemWrite; 				//[5.Control], [12.Data_memory]
	wire [1:0] ALUSrc; 			//[5.Control], [6.MUX]
	wire RegWrite; 				//[5.Control], [7.Registers]
	wire [31:0] MUX_a;			//[6.MUX]
	wire [31:0] MUX_b;			//[6.MUX]
	wire [31:0] MUX_sig;			//[6.MUX]
	wire [31:0] MUX_out;			//[6.MUX]
	wire [4:0] Read_register_1;		//[7.Registers]
	wire [4:0] Read_register_2; 		//[7.Registers]
	wire [4:0] Write_register;		//[6.MUX], [7.Registers]
	wire [31:0] Write_Data; 		//[12.Data_memory], [6.MUX], [7.Registers]
	wire [31:0] Read_data_1;   		//[7.Registers], [9.ALU]
	wire [31:0] Read_data_2; 		//[7.Registers], [6.MUX]
	wire [31:0] Sign_extend;		//[8.Sign_extend], [11.Shift_left_2]
	wire [31:0] ADD_a; 			//[3.Add]
	wire [31:0] ADD_b; 			//[3.Add]
	wire [31:0] ADD_out; 			//[3.Add]
	wire [3:0] ALU_control; 		//[10.ALU_control], [9.ALU]
	wire [31:0] ALU_result;			//[9.ALU], [12.Data_memory] 
	wire ALU_zero; 				//[9.ALU], [13.And]
	wire AND_a;				//[13.And]
	wire AND_b;				//[13.And]
	wire AND_out;				//[13.And]
	wire [31:0] Read_data;		//[12.Data_memory] 
	
	// 2. PC
	PC PC(
		.CLK(CLK),		//IN
		.RESET(RESET),		//IN
		.PC_next(PC_next),	//IN
		.PC(PC) 		//OUT
	);
	
	// 3. Add
	Add Add(
		.ADD_a(ADD_a), 		//IN
		.ADD_b(ADD_b),		//IN
		.ADD_out(ADD_out)	//OUT
	);
	
	// 4. Instruction_memory
	Instruction_memory Instruction_memory(
		.CLK(CLK)			//IN
		.RESET(RESET),			//IN
		.Read_address(Read_address),	//IN
		.Instruction(Instruction)	//OUT
	);
	
	// 5. Control
	Control Control(
		.in(instruction[31:26]), 	//IN
		.RegDst(RegDst),		//OUT
		.Branch(Branch),		//OUT
		.MemRead(MemRead),		//OUT
		.MemtoReg(MemtoReg),		//OUT
		.ALUOp(ALUOp),			//OUT
		.MemWrite(MemWrite),		//OUT
		.ALUSrc(ALUSrc),		//OUT
		.RegWrite(RegWrite)		//OUT
	);
	
	
endmodule
