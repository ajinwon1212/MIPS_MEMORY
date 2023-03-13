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
	wire ADD_a; 				//[3.Add]
	wire ADD_b; 				//[3.Add]
	wire ADD_out; 				//[3.Add]
	wire [3:0] ALU_control; 		//[10.ALU_control], [9.ALU]
	wire [31:0] ALU_result;			//[9.ALU], [12.Data_memory] 
	wire ALU_zero; 				//[9.ALU], [13.And]
	wire [31:0] AND_a;			//[13.And]
	wire [31:0] AND_b;			//[13.And]
	wire [31:0] AND_out;			//[13.And]
	output wire [31:0] Read_data;		//[12.Data_memory] 
	
	
	Instruction_module Instruction_module(
		//.rst(rst),
		.PC_next(PC_next),
		.instruction(instruction)); 
	
	Inst_to_reg_module Inst_to_reg_module(
		.instruction(instruction),
		.opcode(opcode),
		.funct(funct),
		.rs(rs), 
		.rt(rt), 
		.rd(rd), 
		.shamt(shamt),
		.offset(offset)); 

	Controlunit_module Controlunit_module(
		.opcode(opcode),
		.RegDst(RegDst),
		.ALUSrc(ALUSrc),
		.MemtoReg(MemtoReg),
		.Regwrite(Regwrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		//.Branch(Branch),
		.ALUOp(ALUOp)
		//.jump(jump)
	);

	Register_module Register_module(
		.clk(clk),
		.rst(rst),
		.rs(rs), 
		.rt(rt), 
		.rd(rd), 
		.shamt(shamt),
		//.funct(funct),
		.offset(offset),
		.outdata(outdata),
		.Regwrite(Regwrite), 
		.RegDst(RegDst),
		.readata1(readata1), 
		.readata2(readata2), 
		.sign_extend(sign_extend),
		.shift(shift)
		//.funct2(funct2)
	);

	reg_to_alu_module reg_to_alu_module(
		.readata1(readata1), 
		.readata2(readata2), 
		.sign_extend(sign_extend),
		.ALUSrc(ALUSrc),
		.ALUOp(ALUOp),
		.funct(funct),
		.ALUinput1(ALUinput1), 
		.ALUinput2(ALUinput2),
		.ALUcontrol(ALUcontrol));

	ALU_module ALU_module(
		.ALUinput1(ALUinput1), 
		.ALUinput2(ALUinput2),
		//.ALUOp(ALUOp),
		.ALUcontrol(ALUcontrol),
		.shift(shift),
        .ALUresult(ALUresult)
		//.zero(zero)
	);

	Datamem_module Datamem_module(
		.clk(clk),
		.rst(rst),
		.ALUresult(ALUresult), 
		.readata2(readata2),
		.MemWrite(MemWrite), 
		.MemRead(MemRead),
		.Readata(Readata));

	Writeback_module Writeback_module(
		.Readata(Readata), 
		.ALUresult(ALUresult),
		.MemToReg(MemtoReg),
		.outdata(outdata));

	PC_module PC_module(
		.rst(rst),
		.clk(clk), 
		//.Branch(Branch), 
		//.zero(zero),
		.sign_extend(sign_extend),
		.PC_next(PC_next),
		.MemRead(MemRead)
	);
 
endmodule
