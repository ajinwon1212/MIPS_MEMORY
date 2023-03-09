
module EX_mux1 (IDEX_readata1_out, WBID_mux_out, EXMEM_ALUresult_out, EXMEM_ALUinput2_out, forwarding_output1, ALUinput1);
	input [31:0] IDEX_readata1_out, WBID_mux_out, EXMEM_ALUresult_out, EXMEM_ALUinput2_out;
	input [1:0] forwarding_output1;
	output [31:0] ALUinput1; 
	
	assign ALUinput1 = 
		(forwarding_output1 == 2'b00) ? IDEX_readata1_out : (
		(forwarding_output1 == 2'b01) ? WBID_mux_out : EXMEM_ALUresult_out );
endmodule