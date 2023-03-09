
module reg_to_alu_module (IDEX_ALUOp_out, IDEX_funct_out, ALUcontrol);
	input [1:0] IDEX_ALUOp_out;
	input [5:0] IDEX_funct_out;
	output wire [3:0] ALUcontrol;
	
	assign ALUcontrol = 
		(IDEX_ALUOp_out == 2'b00) ? 4'b0000 : (
		(IDEX_ALUOp_out == 2'b01) ? 4'b0001 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b000000) ? 4'b0000 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b000001) ? 4'b0001 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b000010) ? 4'b0010 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b000011) ? 4'b0011 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b000100) ? 4'b0100 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b000101) ? 4'b0101 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b000110) ? 4'b0110 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b000111) ? 4'b0111 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b001000) ? 4'b1000 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b001001) ? 4'b1001 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b001010) ? 4'b1010 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b001011) ? 4'b1011 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b001100) ? 4'b1100 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b001101) ? 4'b1101 : (
		(IDEX_ALUOp_out == 2'b10 && IDEX_funct_out == 6'b001110) ? 4'b1110 : 4'b0000) ) ) ) ) ) ) ) ) ) ) ) ) ) ) );
endmodule