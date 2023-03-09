
module ID_EX_Reg (clk, rst, control_opcode,
IDEX_RegDst_in, IDEX_ALUSrc_in, IDEX_MemtoReg_in, IDEX_RegWrite_in, IDEX_MemRead_in, IDEX_MemWrite_in, IDEX_Branch_in, IDEX_jump_in, IDEX_ALUOp_in,IFID_Write_in,//IDEX_PCnext_in, 
IDEX_rs_in, IDEX_rt_in, IDEX_rd_in, IDEX_shamt_in, IDEX_funct_in, IDEX_readata1_in, IDEX_readata2_in, IDEX_sign_extend_in, IDEX_SWDATA_in,
IDEX_opcode_out, IDEX_RegDst_out, IDEX_ALUSrc_out, IDEX_MemtoReg_out, IDEX_RegWrite_out, IDEX_MemRead_out, IDEX_MemWrite_out, IDEX_Branch_out, IDEX_jump_out, IDEX_ALUOp_out, IFID_Write_out,
IDEX_rs_out, IDEX_rt_out, IDEX_rd_out, IDEX_shamt_out, IDEX_funct_out, IDEX_readata1_out, IDEX_readata2_out, IDEX_sign_extend_out, IDEX_SWDATA_out);//IDEX_PCnext_out, 
	
	input clk, rst;        
	input IDEX_RegDst_in, IDEX_ALUSrc_in, IDEX_MemtoReg_in, IDEX_RegWrite_in, IDEX_MemRead_in, IDEX_MemWrite_in, IDEX_Branch_in, IDEX_jump_in, IFID_Write_in;
	input [1:0] IDEX_ALUOp_in;
	//input [31:0] IDEX_PCnext_in;
	input [5:0] IDEX_funct_in, control_opcode;
	input [4:0] IDEX_rs_in, IDEX_rt_in, IDEX_rd_in, IDEX_shamt_in;
	input [31:0] IDEX_readata1_in, IDEX_readata2_in, IDEX_sign_extend_in, IDEX_SWDATA_in;
	
	output reg IDEX_RegDst_out, IDEX_ALUSrc_out, IDEX_MemtoReg_out, IDEX_RegWrite_out, IDEX_MemRead_out, IDEX_MemWrite_out, IDEX_Branch_out, IDEX_jump_out, IFID_Write_out;
	output reg [1:0] IDEX_ALUOp_out;
	//output reg [31:0] IDEX_PCnext_out;
	output reg [31:0] IDEX_readata1_out, IDEX_readata2_out, IDEX_sign_extend_out, IDEX_SWDATA_out;
	output reg [4:0] IDEX_rs_out, IDEX_rt_out, IDEX_rd_out, IDEX_shamt_out;
	output reg [5:0] IDEX_funct_out, IDEX_opcode_out;
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			IDEX_RegWrite_out <= 1'b0;
			IDEX_MemtoReg_out <= 1'b0;
			IDEX_Branch_out <= 1'b0;
			IDEX_MemRead_out <= 1'b0;
			IDEX_MemWrite_out <= 1'b0;
			IDEX_jump_out <= 1'b0;
			IDEX_RegDst_out <= 1'b0;
			IDEX_ALUSrc_out <= 1'b0;
			IDEX_ALUOp_out <= 2'b0;
			//IDEX_PCnext_out <= 32'b0;
			IDEX_readata1_out <= 32'b0;
			IDEX_readata2_out <= 32'b0;
			IDEX_sign_extend_out <= 32'b0;
			IDEX_rs_out <= 5'b0;
			IDEX_rt_out <= 5'b0;
			IDEX_rd_out <= 5'b0;
			IDEX_shamt_out <= 5'b0;
			IDEX_funct_out <= 6'b0;		
			IDEX_opcode_out <= 6'b0;	
			IDEX_SWDATA_out <= 32'b0;
			IFID_Write_out <= 1'b0;
		end

		else begin
			IDEX_RegWrite_out <= IDEX_RegWrite_in;
			IDEX_MemtoReg_out <= IDEX_MemtoReg_in;
			IDEX_Branch_out <= IDEX_Branch_in;
			IDEX_MemRead_out <= IDEX_MemRead_in;
			IDEX_MemWrite_out <= IDEX_MemWrite_in;
			IDEX_jump_out <= IDEX_jump_in;
			IDEX_RegDst_out <= IDEX_RegDst_in;
			IDEX_ALUSrc_out <= IDEX_ALUSrc_in;
			IDEX_ALUOp_out <= IDEX_ALUOp_in;
			//IDEX_PCnext_out <= IDEX_PCnext_in;
			IDEX_readata1_out <= IDEX_readata1_in; 
			IDEX_readata2_out <= IDEX_readata2_in;
			IDEX_sign_extend_out <= IDEX_sign_extend_in;
			IDEX_rs_out <= IDEX_rs_in;
			IDEX_rt_out <= IDEX_rt_in;
			IDEX_rd_out <= IDEX_rd_in;
			IDEX_shamt_out <= IDEX_shamt_in;
			IDEX_funct_out <= IDEX_funct_in;
			IDEX_opcode_out <= control_opcode;
			IDEX_SWDATA_out <= IDEX_SWDATA_in;
			IFID_Write_out <= IFID_Write_in;
		end			
	end	
	
endmodule