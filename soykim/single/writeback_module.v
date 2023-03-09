
module Writeback_module(Readata, ALUresult, MemToReg, outdata);
	input [31:0] Readata, ALUresult;
	input MemToReg;
	output [31:0] outdata;
	
	assign outdata = (MemToReg == 1'b1) ? Readata : ALUresult;
endmodule 