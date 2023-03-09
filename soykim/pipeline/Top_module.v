

module Top_module( rst, clk,
PCmodule_PCWrite_in, PCnext, ID_mux1_in, ID_mux2_out, ALUinput1, ALUinput2, ALUcontrol,forwarding_output1,forwarding_output2, 
control_opcode, RegDst, ALUSrc, MemtoReg, Regwrite, MemRead, MemWrite, Branch, jump, ALUOp, PCmux_in, ID_Flush_lwstall, beq_stall,

IFID_Write_in, IFID_instruction_in, IFID_PCnext_in, 
IFID_PCnext_out, IFID_instruction_out, IFID_Write_out,

IDEX_RegDst_in, IDEX_ALUSrc_in, IDEX_MemtoReg_in, IDEX_RegWrite_in, IDEX_MemRead_in, IDEX_MemWrite_in, IDEX_Branch_in, IDEX_jump_in, IDEX_ALUOp_in,//IDEX_PCnext_in, IDEX_PCnext_out, 
IDEX_rs_in, IDEX_rt_in, IDEX_rd_in, IDEX_shamt_in, IDEX_funct_in, IDEX_readata1_in, IDEX_readata2_in, IDEX_offset_in, IDEX_sign_extend_in,IDEX_SWDATA_in, IDEX_SWDATA_out,
IDEX_opcode_in, IDEX_opcode_out, IDEX_RegDst_out, IDEX_ALUSrc_out, IDEX_MemtoReg_out, IDEX_RegWrite_out, IDEX_MemRead_out, IDEX_MemWrite_out, IDEX_ALUOp_out, IDEX_Branch_out, IDEX_jump_out,
IDEX_rs_out, IDEX_rt_out, IDEX_rd_out, IDEX_shamt_out, IDEX_funct_out, IDEX_readata1_out, IDEX_readata2_out, IDEX_sign_extend_out,

EXMEM_ALUresult_in, EXMEM_ALUinput2_in, EXMEM_destination_in,EXMEM_readata2_out,//EXMEM_PCnext_out, 
EXMEM_MemtoReg_out, EXMEM_RegWrite_out, EXMEM_ALUSrc_out, EXMEM_MemRead_out, EXMEM_MemWrite_out,  EXMEM_Write_out,
EXMEM_ALUresult_out, EXMEM_ALUinput2_out, EXMEM_destination_out,//EXMEM_MemWrite_out,---written twice
//MEMWB_PCnext_in, 
MEMWB_MemtoReg_in, MEMWB_RegWrite_in, MEMWB_ALUSrc_in, MEMWB_Write_out,
MEMWB_Readata_in, MEMWB_ALUresult_in, MEMWB_destination_in,//MEMWB_PCnext_out, MEMWB_MemRead_in, MEMWB_MemWrite_in, 
MEMWB_RegWrite_out, MEMWB_ALUSrc_out, MEMWB_MemtoReg_out,
MEMWB_Readata_out, MEMWB_ALUresult_out, MEMWB_destination_out,
WBID_mux_out, WBID_Regwrite_out, WBID_ALUSrc_out);//, test

	input clk, rst;
	output wire PCmodule_PCWrite_in, ID_mux1_in, RegDst, ALUSrc, MemtoReg, Regwrite, MemRead, MemWrite, Branch, jump, PCmux_in, ID_Flush_lwstall, beq_stall,
	IFID_Write_in, IFID_Write_out,
	IDEX_RegDst_in, IDEX_ALUSrc_in, IDEX_MemtoReg_in, IDEX_RegWrite_in, IDEX_MemRead_in, IDEX_MemWrite_in, IDEX_Branch_in, IDEX_jump_in,
	IDEX_RegDst_out, IDEX_ALUSrc_out, IDEX_MemtoReg_out, IDEX_RegWrite_out, IDEX_MemRead_out, IDEX_MemWrite_out, IDEX_Branch_out, IDEX_jump_out,
	EXMEM_MemtoReg_out, EXMEM_RegWrite_out, EXMEM_ALUSrc_out, EXMEM_MemRead_out, EXMEM_MemWrite_out, EXMEM_Write_out,
	MEMWB_MemtoReg_in, MEMWB_RegWrite_in,MEMWB_ALUSrc_in, MEMWB_RegWrite_out, MEMWB_MemtoReg_out, MEMWB_ALUSrc_out, MEMWB_Write_out,
	WBID_Regwrite_out, WBID_ALUSrc_out;// test;//MEMWB_MemRead_in, MEMWB_MemWrite_in, 
	output wire [1:0] forwarding_output1,forwarding_output2, ALUOp, IDEX_ALUOp_in, IDEX_ALUOp_out;
	output wire [3:0] ALUcontrol; 
	output wire [4:0] IDEX_rs_in, IDEX_rt_in, IDEX_rd_in, IDEX_shamt_in, IDEX_rs_out, IDEX_rt_out, IDEX_rd_out, IDEX_shamt_out, 
	EXMEM_destination_in, EXMEM_destination_out, MEMWB_destination_in,
	MEMWB_destination_out;
	output wire [5:0] control_opcode, IDEX_funct_in, IDEX_opcode_in, IDEX_opcode_out, IDEX_funct_out;
	output wire [15:0] IDEX_offset_in;
	output wire [31:0] PCnext, ID_mux2_out, ALUinput1, ALUinput2, 
	IFID_PCnext_in, IFID_PCnext_out, IFID_instruction_in, IFID_instruction_out,//IDEX_PCnext_in, IDEX_PCnext_out, EXMEM_PCnext_out, 
	IDEX_readata1_in, IDEX_readata2_in, IDEX_sign_extend_in, IDEX_SWDATA_in, IDEX_readata1_out, IDEX_readata2_out, IDEX_sign_extend_out, IDEX_SWDATA_out,
	EXMEM_ALUresult_in, EXMEM_ALUinput2_in, EXMEM_ALUresult_out, EXMEM_ALUinput2_out, EXMEM_readata2_out,//MEMWB_PCnext_in, MEMWB_PCnext_out, 
	MEMWB_Readata_in, MEMWB_ALUresult_in, MEMWB_Readata_out, MEMWB_ALUresult_out,
	WBID_mux_out;


	PC_module PC_module(
		.rst(rst),
		.clk(clk),
		.PCmux_in(PCmux_in),
		.PCmodule_PCWrite_in(PCmodule_PCWrite_in),
		.ID_mux2_out(ID_mux2_out),
		.PCnext(PCnext),
		.beq_stall(beq_stall));

	Instruction_module Instruction_module(
		//.rst(rst),
		.PCnext(PCnext),
		.IFID_instruction_in(IFID_instruction_in),
		.IFID_PCnext_in(IFID_PCnext_in),
		.beq_stall(beq_stall));

	IFID_reg_module IFID_reg_module(
		.rst(rst),
		.clk(clk),
		.IFID_Write_in(IFID_Write_in),
		.IFID_instruction_in(IFID_instruction_in),
		.IFID_PCnext_in(IFID_PCnext_in),
		.IFID_PCnext_out(IFID_PCnext_out),
		.IFID_instruction_out(IFID_instruction_out),
		.IDEX_opcode_in(IDEX_opcode_in),
		.IDEX_funct_in(IDEX_funct_in),
		.IDEX_rs_in(IDEX_rs_in),
		.IDEX_rt_in(IDEX_rt_in),
		.IDEX_rd_in(IDEX_rd_in),
		.IDEX_shamt_in(IDEX_shamt_in),
		.IDEX_offset_in(IDEX_offset_in));
	
	Hazard_detection_unit Hazard_detection_unit(
		.rst(rst),
		.IDEX_rt_out(IDEX_rt_out),
		.IDEX_rs_in(IDEX_rs_in),
		.IDEX_rt_in(IDEX_rt_in),
		.IDEX_MemRead_out(IDEX_MemRead_out),
		.PCmodule_PCWrite_in(PCmodule_PCWrite_in),
		.IFID_Write_in(IFID_Write_in),
		.ID_mux1_in(ID_mux1_in),
		.ID_Flush_lwstall(ID_Flush_lwstall),
		.PCmux_in(PCmux_in),
		.IDEX_readata1_in(IDEX_readata1_in),
		.IDEX_readata2_in(IDEX_readata2_in),
		.IDEX_opcode_in(IDEX_opcode_in));

	Controlunit_module Controlunit_module(
		//.rst(rst),
		.IDEX_opcode_in(IDEX_opcode_in),
		.RegDst(RegDst),
		.ALUSrc(ALUSrc),
		.MemtoReg(MemtoReg),
		.Regwrite(Regwrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.Branch(Branch),
		.ALUOp(ALUOp),
		.control_opcode(control_opcode),
		.jump(jump));

	ID_mux1 ID_mux1(
		//.rst(rst),
		.ID_mux1_in(ID_mux1_in),
		.RegDst(RegDst),
		.ALUSrc(ALUSrc),
		.MemtoReg(MemtoReg),
		.Regwrite(Regwrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.Branch(Branch),
		.jump(jump),
		.ALUOp(ALUOp),
		.IDEX_RegDst_in(IDEX_RegDst_in),
		.IDEX_ALUSrc_in(IDEX_ALUSrc_in),
		.IDEX_MemtoReg_in(IDEX_MemtoReg_in),
		.IDEX_RegWrite_in(IDEX_RegWrite_in),
		.IDEX_MemRead_in(IDEX_MemRead_in),
		.IDEX_MemWrite_in(IDEX_MemWrite_in),
		.IDEX_Branch_in(IDEX_Branch_in),
		.IDEX_jump_in(IDEX_jump_in),
		.IDEX_ALUOp_in(IDEX_ALUOp_in));

	ID_adder ID_adder(
		.rst(rst),
		.IFID_instruction_out(IFID_instruction_out),
		.IFID_PCnext_out(IFID_PCnext_out),
		.ID_mux2_out(ID_mux2_out));

	Register_module Register_module(
		.clk(clk),
		.rst(rst),
		.Regwrite(Regwrite),
		.WBID_RegDst_out(WBID_RegDst_out),
		.MEMWB_RegWrite_out(MEMWB_RegWrite_out),
		.RegDst(RegDst),
		.ALUSrc(ALUSrc),
		//.IFID_PCnext_out(IFID_PCnext_out),
		.WBID_mux_out(WBID_mux_out),
		.IDEX_opcode_in(IDEX_opcode_in),
		.IDEX_rs_in(IDEX_rs_in),
		.IDEX_rt_in(IDEX_rt_in),
		.IDEX_rd_in(IDEX_rd_in),
		.IDEX_shamt_in(IDEX_shamt_in),
		.IDEX_funct_in(IDEX_funct_in),
		.IDEX_offset_in(IDEX_offset_in),
		.MEMWB_destination_out(MEMWB_destination_out),
		//.IDEX_PCnext_in(IDEX_PCnext_in),
		.IDEX_readata1_in(IDEX_readata1_in),
		.IDEX_readata2_in(IDEX_readata2_in),
		.IDEX_sign_extend_in(IDEX_sign_extend_in),
		.IDEX_SWDATA_in(IDEX_SWDATA_in)
		//.test(test)
	);


	ID_EX_Reg ID_EX_Reg (
		.clk(clk),
		.rst(rst),
		.control_opcode(control_opcode),
		.IDEX_RegDst_in(IDEX_RegDst_in),
		.IDEX_ALUSrc_in(IDEX_ALUSrc_in),
		.IDEX_MemtoReg_in(IDEX_MemtoReg_in),
		.IDEX_RegWrite_in(IDEX_RegWrite_in),
		.IDEX_MemRead_in(IDEX_MemRead_in),
		.IDEX_MemWrite_in(IDEX_MemWrite_in),
		.IDEX_Branch_in(IDEX_Branch_in),
		.IDEX_jump_in(IDEX_jump_in),
		.IDEX_ALUOp_in(IDEX_ALUOp_in),
		//.IDEX_PCnext_in(IDEX_PCnext_in),
		.IDEX_funct_in(IDEX_funct_in),
		.IDEX_rs_in(IDEX_rs_in),
		.IDEX_rt_in(IDEX_rt_in),
		.IDEX_rd_in(IDEX_rd_in),
		.IDEX_shamt_in(IDEX_shamt_in),
		.IDEX_readata1_in(IDEX_readata1_in),
		.IDEX_readata2_in(IDEX_readata2_in),
		.IDEX_sign_extend_in(IDEX_sign_extend_in),
		.IDEX_opcode_out(IDEX_opcode_out),
		.IDEX_RegDst_out(IDEX_RegDst_out),
		.IDEX_ALUSrc_out(IDEX_ALUSrc_out),
		.IDEX_MemtoReg_out(IDEX_MemtoReg_out),
		.IDEX_RegWrite_out(IDEX_RegWrite_out),
		.IDEX_MemRead_out(IDEX_MemRead_out),
		.IDEX_MemWrite_out(IDEX_MemWrite_out),
		.IDEX_Branch_out(IDEX_Branch_out),
		.IDEX_jump_out(IDEX_jump_out),
		.IDEX_ALUOp_out(IDEX_ALUOp_out),
		//.IDEX_PCnext_out(IDEX_PCnext_out),
		.IDEX_rs_out(IDEX_rs_out),
		.IDEX_rt_out(IDEX_rt_out),
		.IDEX_rd_out(IDEX_rd_out),
		.IDEX_shamt_out(IDEX_shamt_out),
		.IDEX_funct_out(IDEX_funct_out),
		.IDEX_readata1_out(IDEX_readata1_out),
		.IDEX_readata2_out(IDEX_readata2_out),
		.IDEX_sign_extend_out(IDEX_sign_extend_out),
		.IDEX_SWDATA_out(IDEX_SWDATA_out),
		.IDEX_SWDATA_in(IDEX_SWDATA_in),
		.IFID_Write_in(IFID_Write_in),
		.IFID_Write_out(IFID_Write_out));


	Forwarding_unit Forwarding_unit(
		.rst(rst),
		//.equal1(equal1), 
		//.equal2(equal2), 
		//.equal3(equal3), 
		//.equal4(equal4),
		.IDEX_rs_out(IDEX_rs_out),
		.IDEX_rt_out(IDEX_rt_out),
		.EXMEM_destination_out(EXMEM_destination_out),
		.MEMWB_destination_out(MEMWB_destination_out),
		.EXMEM_RegWrite_out(EXMEM_RegWrite_out),
		.MEMWB_RegWrite_out(MEMWB_RegWrite_out),
		.forwarding_output1(forwarding_output1),
		.forwarding_output2(forwarding_output2),
		.EXMEM_MemWrite_out(EXMEM_MemWrite_out),
		.IDEX_RegWrite_out(IDEX_RegWrite_out),
		.IDEX_MemWrite_out(IDEX_MemWrite_out));

	EX_mux1 EX_mux1(
		//.rst(rst),
		.IDEX_readata1_out(IDEX_readata1_out),
		.WBID_mux_out(WBID_mux_out),
		.EXMEM_ALUresult_out(EXMEM_ALUresult_out),
		.forwarding_output1(forwarding_output1),
		.ALUinput1(ALUinput1),
		.EXMEM_ALUinput2_out(EXMEM_ALUinput2_out));

	EX_mux2 EX_mux2(
		//.rst(rst),
		.IDEX_readata2_out(IDEX_readata2_out),
		.WBID_mux_out(WBID_mux_out),
		.EXMEM_ALUresult_out(EXMEM_ALUresult_out),
		.forwarding_output2(forwarding_output2),
		.ALUinput2(ALUinput2),
		.EXMEM_ALUinput2_in(EXMEM_ALUinput2_in),
		.EXMEM_ALUinput2_out(EXMEM_ALUinput2_out),
		.IDEX_sign_extend_out(IDEX_sign_extend_out));

	EX_mux3 EX_mux3(
		//.rst(rst),
		.IDEX_opcode_out(IDEX_opcode_out),
		.IDEX_rt_out(IDEX_rt_out),
		.IDEX_rd_out(IDEX_rd_out),
		.EXMEM_destination_in(EXMEM_destination_in));

	reg_to_alu_module reg_to_alu_module(
		//.rst(rst),
		.IDEX_ALUOp_out(IDEX_ALUOp_out),
		.IDEX_funct_out(IDEX_funct_out),
		.ALUcontrol(ALUcontrol));

	ALU_module ALU_module(
		//.rst(rst),
		.ALUinput1(ALUinput1),
		.ALUinput2(ALUinput2),
		.ALUcontrol(ALUcontrol),
		.IDEX_shamt_out(IDEX_shamt_out),
		.EXMEM_ALUresult_in(EXMEM_ALUresult_in));

	EX_MEM_Reg EX_MEM_Reg(
		.clk(clk),
		.rst(rst),
		//.IDEX_PCnext_out(IDEX_PCnext_out),
		.IDEX_MemtoReg_out(IDEX_MemtoReg_out),
		.IDEX_RegWrite_out(IDEX_RegWrite_out),
		.IDEX_ALUSrc_out(IDEX_ALUSrc_out),
		.IDEX_MemRead_out(IDEX_MemRead_out),
		.IDEX_MemWrite_out(IDEX_MemWrite_out),
		.EXMEM_ALUresult_in(EXMEM_ALUresult_in),
		.EXMEM_ALUinput2_in(EXMEM_ALUinput2_in),
		.EXMEM_destination_in(EXMEM_destination_in),
		//.EXMEM_PCnext_out(EXMEM_PCnext_out),
		.EXMEM_MemtoReg_out(EXMEM_MemtoReg_out),
		.EXMEM_RegWrite_out(EXMEM_RegWrite_out),
		.EXMEM_MemRead_out(EXMEM_MemRead_out),
		.EXMEM_ALUSrc_out(EXMEM_ALUSrc_out),
		.EXMEM_MemWrite_out(EXMEM_MemWrite_out),
		.EXMEM_ALUresult_out(EXMEM_ALUresult_out),
		.EXMEM_ALUinput2_out(EXMEM_ALUinput2_out),
		.EXMEM_destination_out(EXMEM_destination_out),
		.EXMEM_readata2_out(EXMEM_readata2_out),
		.IDEX_SWDATA_out(IDEX_SWDATA_out),
		.IFID_Write_out(IFID_Write_out),
		.EXMEM_Write_out(EXMEM_Write_out));

	Datamem_module Datamem_module(
		.clk(clk),
		.rst(rst),
		//.EXMEM_PCnext_out(EXMEM_PCnext_out),
		.EXMEM_MemtoReg_out(EXMEM_MemtoReg_out),
		.EXMEM_RegWrite_out(EXMEM_RegWrite_out),
		.EXMEM_ALUSrc_out(EXMEM_ALUSrc_out),
		.EXMEM_MemRead_out(EXMEM_MemRead_out),
		.EXMEM_MemWrite_out(EXMEM_MemWrite_out),
		.EXMEM_ALUresult_out(EXMEM_ALUresult_out),
		.EXMEM_ALUinput2_out(EXMEM_ALUinput2_out),
		.EXMEM_destination_out(EXMEM_destination_out),
		.EXMEM_readata2_out(EXMEM_readata2_out),
		//.MEMWB_PCnext_in(MEMWB_PCnext_in),
		.MEMWB_MemtoReg_in(MEMWB_MemtoReg_in),
		.MEMWB_RegWrite_in(MEMWB_RegWrite_in),
		//.MEMWB_MemRead_in(MEMWB_MemRead_in),
		//.MEMWB_MemWrite_in(MEMWB_MemWrite_in),
		.MEMWB_ALUSrc_in(MEMWB_ALUSrc_in),
		.MEMWB_Readata_in(MEMWB_Readata_in),
		.MEMWB_ALUresult_in(MEMWB_ALUresult_in),
		.MEMWB_destination_in(MEMWB_destination_in));

	MEM_WB_Reg MEM_WB_Reg(
		.clk(clk),
		.rst(rst),
		.MEMWB_MemtoReg_in(MEMWB_MemtoReg_in),
		.MEMWB_RegWrite_in(MEMWB_RegWrite_in),
		.MEMWB_ALUSrc_in(MEMWB_ALUSrc_in),
		//.MEMWB_PCnext_in(MEMWB_PCnext_in),
		.MEMWB_Readata_in(MEMWB_Readata_in),
		.MEMWB_ALUresult_in(MEMWB_ALUresult_in),
		.MEMWB_destination_in(MEMWB_destination_in),
		.MEMWB_RegWrite_out(MEMWB_RegWrite_out),
		.MEMWB_ALUSrc_out(MEMWB_ALUSrc_out),
		.MEMWB_MemtoReg_out(MEMWB_MemtoReg_out),
		//.MEMWB_PCnext_out(MEMWB_PCnext_out),
		.MEMWB_Readata_out(MEMWB_Readata_out),
		.MEMWB_ALUresult_out(MEMWB_ALUresult_out),
		.MEMWB_destination_out(MEMWB_destination_out),
		.EXMEM_Write_out(EXMEM_Write_out),
		.MEMWB_Write_out(MEMWB_Write_out));

	Writeback_module Writeback_module(
		//.rst(rst),
		.MEMWB_RegWrite_out(MEMWB_RegWrite_out),
		.MEMWB_ALUSrc_out(MEMWB_ALUSrc_out),
		.MEMWB_MemtoReg_out(MEMWB_MemtoReg_out),
		//.MEMWB_PCnext_out(MEMWB_PCnext_out),
		.MEMWB_Readata_out(MEMWB_Readata_out),
		.MEMWB_ALUresult_out(MEMWB_ALUresult_out),
		//.MEMWB_destination_out(MEMWB_destination_out),
		.WBID_mux_out(WBID_mux_out),
		.WBID_Regwrite_out(WBID_Regwrite_out),
		.WBID_ALUSrc_out(WBID_ALUSrc_out),
		.MEMWB_Write_out(MEMWB_Write_out),
		.MEMWB_Readata_in(MEMWB_Readata_in));


endmodule