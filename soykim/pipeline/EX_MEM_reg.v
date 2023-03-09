
module EX_MEM_Reg (clk, rst, IDEX_MemtoReg_out, IDEX_RegWrite_out, IDEX_ALUSrc_out, IDEX_MemRead_out, IDEX_MemWrite_out, IDEX_SWDATA_out,
EXMEM_ALUresult_in, EXMEM_ALUinput2_in,EXMEM_destination_in,IFID_Write_out,//EXMEM_PCnext_out, IDEX_PCnext_out, 
EXMEM_MemtoReg_out, EXMEM_RegWrite_out, EXMEM_MemRead_out, EXMEM_ALUSrc_out, EXMEM_MemWrite_out, EXMEM_Write_out,
EXMEM_ALUresult_out, EXMEM_ALUinput2_out, EXMEM_readata2_out, EXMEM_destination_out);

	input clk, rst;
	//input [31:0] IDEX_PCnext_out;
	input IDEX_MemtoReg_out, IDEX_RegWrite_out,IDEX_ALUSrc_out, IDEX_MemRead_out, IDEX_MemWrite_out, IFID_Write_out;
	input [31:0] EXMEM_ALUresult_in, EXMEM_ALUinput2_in, IDEX_SWDATA_out; 
	input [4:0] EXMEM_destination_in;
	//output reg [31:0] EXMEM_PCnext_out;
	output reg EXMEM_MemtoReg_out, EXMEM_RegWrite_out, EXMEM_MemRead_out,EXMEM_ALUSrc_out, EXMEM_MemWrite_out, EXMEM_Write_out;
	output reg[31:0] EXMEM_ALUresult_out, EXMEM_ALUinput2_out, EXMEM_readata2_out;
	output reg[4:0] EXMEM_destination_out;

	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			//EXMEM_PCnext_out <= 32'b0;
		 	EXMEM_MemtoReg_out <= 1'b0;
			EXMEM_RegWrite_out <= 1'b0;
		  	EXMEM_MemRead_out <= 1'b0;
			EXMEM_ALUSrc_out <= 1'b0;
		  	EXMEM_MemWrite_out <= 1'b0;
		  	EXMEM_ALUresult_out <= 32'b0;
		  	EXMEM_ALUinput2_out <= 32'b0;
		  	EXMEM_destination_out <= 5'b0; 
			EXMEM_readata2_out <= 32'b0; 
			EXMEM_Write_out <= 1'b0;
			
		end
		else begin
			//EXMEM_PCnext_out <= IDEX_PCnext_out;
		  	EXMEM_MemtoReg_out <= IDEX_MemtoReg_out;
		  	EXMEM_RegWrite_out <= IDEX_RegWrite_out;
		  	EXMEM_MemRead_out <= IDEX_MemRead_out;
			EXMEM_ALUSrc_out <= IDEX_ALUSrc_out;
		  	EXMEM_MemWrite_out <= IDEX_MemWrite_out;
		  	EXMEM_ALUresult_out <= EXMEM_ALUresult_in;
		  	EXMEM_ALUinput2_out <= EXMEM_ALUinput2_in;
		  	EXMEM_destination_out <= EXMEM_destination_in;
			EXMEM_readata2_out <= IDEX_SWDATA_out;
			EXMEM_Write_out <= IFID_Write_out;
		end
	end
endmodule