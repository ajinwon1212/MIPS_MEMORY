
module MEM_WB_Reg (clk, rst, MEMWB_MemtoReg_in, MEMWB_RegWrite_in, MEMWB_ALUSrc_in, MEMWB_Readata_in, MEMWB_ALUresult_in, EXMEM_Write_out, MEMWB_destination_in, 
MEMWB_RegWrite_out,MEMWB_ALUSrc_out, MEMWB_MemtoReg_out, MEMWB_Readata_out, MEMWB_destination_out, MEMWB_ALUresult_out, MEMWB_Write_out);
//MEMWB_PCnext_out, MEMWB_PCnext_in, 
	input clk, rst;
	input MEMWB_MemtoReg_in, MEMWB_RegWrite_in, MEMWB_ALUSrc_in, EXMEM_Write_out;
	input [31:0] MEMWB_Readata_in, MEMWB_ALUresult_in;
	input [4:0] MEMWB_destination_in;//MEMWB_PCnext_in, 
	output reg MEMWB_RegWrite_out, MEMWB_ALUSrc_out, MEMWB_MemtoReg_out, MEMWB_Write_out;
	output reg [31:0] MEMWB_Readata_out, MEMWB_ALUresult_out;//MEMWB_PCnext_out, 
	output reg [4:0] MEMWB_destination_out;
	
	always @(posedge clk or negedge rst)
	begin
		if (rst == 1'b0)
		begin
			//MEMWB_PCnext_out <= 32'b0;
			MEMWB_RegWrite_out <= 1'b0;
			MEMWB_MemtoReg_out <= 1'b0;
			MEMWB_ALUresult_out <= 32'b0;
			MEMWB_Readata_out <= 32'b0;
			MEMWB_destination_out <= 5'b0;
			MEMWB_RegWrite_out <= 1'b0; 
			MEMWB_ALUSrc_out <= 1'b0;
			MEMWB_Write_out <= 1'b0;
		end
		else 
		begin
			//MEMWB_PCnext_out <= MEMWB_PCnext_in;
			MEMWB_RegWrite_out <= MEMWB_RegWrite_in;
			MEMWB_MemtoReg_out <= MEMWB_MemtoReg_in;
			MEMWB_ALUresult_out <= MEMWB_ALUresult_in;
			MEMWB_Readata_out <= MEMWB_Readata_in;
			MEMWB_destination_out <= MEMWB_destination_in;
			MEMWB_RegWrite_out <= MEMWB_RegWrite_in; 
			MEMWB_ALUSrc_out <= MEMWB_ALUSrc_in;
			MEMWB_Write_out <= EXMEM_Write_out;
		end
	end	
endmodule