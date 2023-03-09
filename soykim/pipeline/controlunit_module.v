
module Controlunit_module (IDEX_opcode_in, RegDst, ALUSrc, MemtoReg, Regwrite, MemRead, MemWrite, Branch, ALUOp, jump, control_opcode);
	input [5:0] IDEX_opcode_in;
	output RegDst, ALUSrc, MemtoReg, Regwrite, MemRead, MemWrite, Branch, jump;
	output [1:0] ALUOp;
	output [5:0] control_opcode;
	
	assign control_opcode = IDEX_opcode_in;
	
	assign RegDst	= (IDEX_opcode_in == 6'b000000) ? 1'b1 : 1'b0;
	assign ALUSrc	= (IDEX_opcode_in == 6'b100011 || IDEX_opcode_in == 6'b101011) ? 1'b1 : 1'b0;
	assign MemtoReg	= (IDEX_opcode_in == 6'b100011) ? 1'b1 : 1'b0;
	assign Regwrite	= (IDEX_opcode_in == 6'b000000 || IDEX_opcode_in == 6'b100011) ? 1'b1 : 1'b0;
	assign MemRead	= (IDEX_opcode_in == 6'b100011) ? 1'b1 : 1'b0;
	assign MemWrite	= (IDEX_opcode_in == 6'b101011) ? 1'b1 : 1'b0;
	assign Branch	= (IDEX_opcode_in == 6'b000100) ? 1'b1 : 1'b0;
	assign jump		= (IDEX_opcode_in == 6'b000010) ? 1'b1 : 1'b0;
	assign ALUOp	= (IDEX_opcode_in == 6'b000000) ? 2'b10 : ( (IDEX_opcode_in == 6'b000100) ? 2'b01 : 2'b00 );
endmodule