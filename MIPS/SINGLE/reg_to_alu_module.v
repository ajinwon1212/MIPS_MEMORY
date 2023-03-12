
module reg_to_alu_module (readata1, readata2, sign_extend, ALUSrc, ALUOp, funct, ALUinput1, ALUinput2, ALUcontrol);
	input [31:0] readata1, readata2, sign_extend;
	input ALUSrc;
	input [1:0] ALUOp;
	input [5:0] funct;
	output [31:0] ALUinput1, ALUinput2; 
	output [3:0] ALUcontrol;
	
	assign ALUinput1 = readata1;
	assign ALUinput2 = (ALUSrc == 1'b1) ? sign_extend : readata2;
	
	assign ALUcontrol = 
		(ALUOp == 2'b00) ? 4'b0000 : (
		(ALUOp == 2'b01) ? 4'b0001 : (
		(ALUOp == 2'b10 && funct == 6'b000000) ? 4'b0000 : (
		(ALUOp == 2'b10 && funct == 6'b000001) ? 4'b0001 : (
		(ALUOp == 2'b10 && funct == 6'b000010) ? 4'b0010 : (
		(ALUOp == 2'b10 && funct == 6'b000011) ? 4'b0011 : (
		(ALUOp == 2'b10 && funct == 6'b000100) ? 4'b0100 : (
		(ALUOp == 2'b10 && funct == 6'b000101) ? 4'b0101 : (
		(ALUOp == 2'b10 && funct == 6'b000110) ? 4'b0110 : (
		(ALUOp == 2'b10 && funct == 6'b000111) ? 4'b0111 : (
		(ALUOp == 2'b10 && funct == 6'b001000) ? 4'b1000 : (
		(ALUOp == 2'b10 && funct == 6'b001001) ? 4'b1001 : (
		(ALUOp == 2'b10 && funct == 6'b001010) ? 4'b1010 : (
		(ALUOp == 2'b10 && funct == 6'b001011) ? 4'b1011 : (
		(ALUOp == 2'b10 && funct == 6'b001100) ? 4'b1100 : (
		(ALUOp == 2'b10 && funct == 6'b001101) ? 4'b1101 : (
		(ALUOp == 2'b10 && funct == 6'b001110) ? 4'b1110 : 4'b0000) ) ) ) ) ) ) ) ) ) ) ) ) ) ) );
endmodule