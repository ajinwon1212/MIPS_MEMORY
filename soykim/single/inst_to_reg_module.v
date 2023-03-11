
module Inst_to_reg_module (instruction, opcode, funct, rs, rt, rd, shamt, offset);
	input [31:0] instruction;	// get 32bit instruction
	output [5:0] opcode, funct;
	output [4:0] rs, rt, rd, shamt;
	output [15:0] offset;		

	assign opcode = instruction[31:26]; 
	assign rs = instruction[25:21];  
	assign rt = instruction[20:16];
	assign rd = instruction[15:11];  
	assign shamt = instruction[10:6];
	assign funct = instruction[5:0];
	assign offset = instruction[15:0];   // seperate 32bit instruction to [opcode, funct, rs, rt, rd, shamt, offset]
endmodule
