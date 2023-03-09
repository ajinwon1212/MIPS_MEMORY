
module Writeback_module(MEMWB_RegWrite_out, MEMWB_ALUSrc_out, MEMWB_MemtoReg_out,MEMWB_Write_out, //MEMWB_PCnext_out, 
MEMWB_Readata_out, MEMWB_ALUresult_out, WBID_mux_out, WBID_Regwrite_out, WBID_ALUSrc_out, MEMWB_Readata_in);//MEMWB_destination_out, 
	input MEMWB_RegWrite_out, MEMWB_ALUSrc_out, MEMWB_MemtoReg_out, MEMWB_Write_out;
	input [31:0] MEMWB_Readata_out, MEMWB_Readata_in, MEMWB_ALUresult_out;//MEMWB_PCnext_out, 
	//input [4:0] MEMWB_destination_out;
	output [31:0] WBID_mux_out;
	output WBID_Regwrite_out, WBID_ALUSrc_out;
	
	assign WBID_mux_out = ((MEMWB_MemtoReg_out & MEMWB_Write_out) == 1'b1) ? MEMWB_Readata_in : ( ((!MEMWB_MemtoReg_out & MEMWB_Write_out) == 1'b1) ? MEMWB_ALUresult_out : 32'bx);
	assign WBID_Regwrite_out = (MEMWB_Write_out == 1'b1) ? MEMWB_RegWrite_out : 1'bx;
	assign WBID_ALUSrc_out = (MEMWB_Write_out == 1'b1) ? MEMWB_ALUSrc_out : 1'bx;
	/*
always @(MEMWB_MemtoReg_out,MEMWB_Write_out, MEMWB_RegWrite_out, MEMWB_Readata_out,MEMWB_ALUresult_out)
begin
	if (MEMWB_MemtoReg_out == 1'b1 & MEMWB_Write_out==1'b1) begin
		WBID_mux_out <= MEMWB_Readata_out;
		WBID_Regwrite_out <= MEMWB_RegWrite_out;
		WBID_ALUSrc_out <= MEMWB_ALUSrc_out;
	end  
	else if (MEMWB_MemtoReg_out == 1'b0 & MEMWB_Write_out==1'b1) begin
		WBID_mux_out <= MEMWB_ALUresult_out;
		WBID_Regwrite_out <= MEMWB_RegWrite_out;
		WBID_ALUSrc_out <= MEMWB_ALUSrc_out;
	end 
	else if (MEMWB_MemtoReg_out == 1'bx & MEMWB_Write_out==1'b1) begin
		WBID_mux_out <= 32'bx;
		WBID_Regwrite_out <= 1'bx;
		WBID_ALUSrc_out <= 1'bx;
	end
	else if (MEMWB_Write_out==1'b0) begin
		WBID_mux_out <= 32'bx;
		WBID_Regwrite_out <= 1'bx;
		WBID_ALUSrc_out <= 1'bx;
	end
end
*/
endmodule 
