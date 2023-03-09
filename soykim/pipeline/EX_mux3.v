// temp: lw/sw-> rt, R,beq->rd

module EX_mux3 (IDEX_opcode_out, IDEX_rt_out, IDEX_rd_out, EXMEM_destination_in);
	input[5:0] IDEX_opcode_out;
	input [4:0] IDEX_rt_out, IDEX_rd_out;
	output [4:0] EXMEM_destination_in; 
	
	assign EXMEM_destination_in = 
		(IDEX_opcode_out == 6'b000000 || IDEX_opcode_out == 6'b000100) ? IDEX_rd_out[4:0] : (
		(IDEX_opcode_out == 6'b101011 || IDEX_opcode_out == 6'b100011) ? IDEX_rt_out[4:0] : 5'b00000 );
endmodule