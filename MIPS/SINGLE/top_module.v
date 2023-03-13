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
	CLK, 
	PC,			//[2.PC]
	PC_next,		//[2.PC], [3.Add] (PC+4)
	Read_address,		//[4.Instruction_memory]
	Instruction,		//[4.Instruction_memory], [5.Control], [6.MUX], [7.Registers], [8.Sign_extend]
	RegDst,			//[5.Control], [6.MUX]
	Branch,			//[5.Control], [13.And]
	MemRead,		//[5.Control], [12.Data_memory]
	MemtoReg,		//[5.Control], 
	ALUOp,			//[5.Control], [10.ALU_control]
	MemWrite, 		//[5.Control], [12.Data_memory]
	ALUSrc, 		//[5.Control], [6.MUX]
	RegWrite, 		//[5.Control], [7.Registers]
	MUX_a,			//[6.MUX]
	MUX_b,			//[6.MUX]
	MUX_sig,		//[6.MUX]
	MUX_out,		//[6.MUX]
	Read_register_1,	//[7.Registers]
	Read_register_2, 	//[7.Registers]
	Write_register,		//[6.MUX], [7.Registers]
	Write_Data, 		//[6.MUX], [7.Registers]
	Read_data_1,   		//[7.Registers], [9.ALU]
	Read_data_2, 		//[7.Registers], [6.MUX]
	Sign_extend,		//[8.Sign_extend], [11.Shift_left_2]
	ADD_a, 			//[3.Add]
	ADD_b, 			//[3.Add]
	ADD_out, 		//[3.Add]
	ALU_control, 		//[10.ALU_control], [9.ALU]
	ALU_result,		//[9.ALU], [12.Data_memory] 
	ALU_zero, 		//[9.ALU], [13.And]
	AND_a,			//[13.And]
	AND_b,			//[13.And]
	AND_out,		//[13.And]
	Address,		//[12.Data_memory] 
	Write_data,		//[12.Data_memory] 
	Read_data		//[12.Data_memory] 
);

	input clk, rst;
	output wire [7:0] PC_next; 
	output wire [5:0] opcode, funct;
	output wire [4:0] rs, rt, rd, shamt, shift;
	output wire RegDst, ALUSrc, MemtoReg, Regwrite, MemRead, MemWrite;// Branch, zero;
	output wire [1:0] ALUOp;
	output wire [31:0] instruction, readata1, readata2, ALUinput1, ALUinput2, ALUresult, Readata, outdata, sign_extend;
	output wire [15:0] offset;
	output wire [3:0] ALUcontrol;
   
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
