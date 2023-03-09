
module ID_mux1 (ID_mux1_in, RegDst, ALUSrc, MemtoReg, Regwrite, MemRead, MemWrite, Branch, jump, ALUOp,
IDEX_RegDst_in, IDEX_ALUSrc_in, IDEX_MemtoReg_in, IDEX_RegWrite_in, IDEX_MemRead_in, IDEX_MemWrite_in, IDEX_Branch_in, IDEX_jump_in, IDEX_ALUOp_in);
	
	input ID_mux1_in, RegDst, ALUSrc, MemtoReg, Regwrite, MemRead, MemWrite, Branch, jump;
	input [1:0] ALUOp;
	output IDEX_RegDst_in, IDEX_ALUSrc_in, IDEX_MemtoReg_in, IDEX_RegWrite_in, IDEX_MemRead_in, IDEX_MemWrite_in, IDEX_Branch_in, IDEX_jump_in;
	output [1:0] IDEX_ALUOp_in;
	
	assign IDEX_RegDst_in = (ID_mux1_in == 1'b1) ? 1'b0 : RegDst;
	assign IDEX_ALUSrc_in = (ID_mux1_in == 1'b1) ? 1'b0 : ALUSrc;
	assign IDEX_MemtoReg_in = (ID_mux1_in == 1'b1) ? 1'b0 : MemtoReg;
	assign IDEX_RegWrite_in = (ID_mux1_in == 1'b1) ? 1'b0 : Regwrite;
	assign IDEX_MemRead_in = (ID_mux1_in == 1'b1) ? 1'b0 : MemRead;
	assign IDEX_MemWrite_in = (ID_mux1_in == 1'b1) ? 1'b0 : MemWrite;
	assign IDEX_Branch_in = (ID_mux1_in == 1'b1) ? 1'b0 : Branch;
	assign IDEX_jump_in = (ID_mux1_in == 1'b1) ? 1'b0 : jump;
	assign IDEX_ALUOp_in = (ID_mux1_in == 1'b1) ? 2'b00 : ALUOp;
endmodule


