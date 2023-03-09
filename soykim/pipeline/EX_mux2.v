
module EX_mux2 (IDEX_readata2_out, WBID_mux_out, EXMEM_ALUresult_out,EXMEM_ALUinput2_out, forwarding_output2, ALUinput2, EXMEM_ALUinput2_in, IDEX_sign_extend_out);
	input [31:0] IDEX_readata2_out, WBID_mux_out, EXMEM_ALUresult_out,EXMEM_ALUinput2_out, IDEX_sign_extend_out;
	input [1:0] forwarding_output2;
	output [31:0] ALUinput2, EXMEM_ALUinput2_in; 
	
	assign ALUinput2 = 
		(forwarding_output2 == 2'b00) ? IDEX_readata2_out : (
		(forwarding_output2 == 2'b01) ? WBID_mux_out : (
		(forwarding_output2 == 2'b10) ? EXMEM_ALUresult_out : IDEX_sign_extend_out ) );
	assign EXMEM_ALUinput2_in = 
		(forwarding_output2 == 2'b00) ? IDEX_readata2_out : (
		(forwarding_output2 == 2'b01) ? WBID_mux_out : (
		(forwarding_output2 == 2'b10) ? EXMEM_ALUresult_out : IDEX_sign_extend_out ) );
endmodule