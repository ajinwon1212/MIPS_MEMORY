
module Controlunit_module (opcode, RegDst, ALUSrc, MemtoReg, Regwrite, MemRead, MemWrite, ALUOp);
	input [5:0] opcode;
	output RegDst, ALUSrc, MemtoReg, Regwrite, MemRead, MemWrite;  // Branch;
	output [1:0] ALUOp;
	
	assign RegDst	= (opcode == 6'b000000) ? 1'b1 : 1'b0;
	assign ALUSrc	= (opcode == 6'b100011 || opcode == 6'b101011) ? 1'b1 : 1'b0;
	assign MemtoReg	= (opcode == 6'b100011) ? 1'b1 : 1'b0;
	assign Regwrite	= (opcode == 6'b000000 || opcode == 6'b100011) ? 1'b1 : 1'b0;
	assign MemRead	= (opcode == 6'b100011) ? 1'b1 : 1'b0;
	assign MemWrite	= (opcode == 6'b101011) ? 1'b1 : 1'b0;
	//assign Branch	= (opcode == 6'b000100) ? 1'b1 : 1'b0; cause beq eliminated
	assign ALUOp	= (opcode == 6'b000000) ? 2'b10 : ( (opcode == 6'b000100) ? 2'b01 : 2'b00 );
	
endmodule