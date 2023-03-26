`timescale 1ns / 1ns  

module Instruction_memory_TB;

	reg CLK, RESET;

	Instruction_memory IST_MEM(
		.CLK(CLK), 
		.RESET(RESET), 
		.Read_address(32'b0), 
		.Instruction()
	);

	initial
	begin
		CLK = 1'b0;
		forever
		begin
			#10 CLK = !CLK;
		end
	end

	initial
	begin
		RESET = 1'b1;
		#30 RESET = 1'b0; 
		#30 RESET = 1'b1;
	end


endmodule
