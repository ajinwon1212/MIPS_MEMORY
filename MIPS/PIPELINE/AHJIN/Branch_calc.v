/*Branch_calc Branch_top(
		.opcode(ID_Instruction[31:26]),	//IN
		.Zero(Zero),			//IN
		.out(Branch)			//OUT
	);
*/

module Branch_calc(opcode, Zero, Branch);
	input [5:0] opcode;
	input [31:0] Zero; //From XNOR gate
	output reg Branch;

	always@(opcode or Zero)
	begin

		if (opcode == 6'b000100) //beq
		begin
			if(Zero == 32'hffffffff) Branch <= 1'b1;
			else Branch <= 1'b0;
		end

		else if (opcode == 6'b000101) //bne
		begin
			if(Zero != 32'hffffffff) Branch <= 1'b1;
			else Branch <= 1'b0;
		end

		else Branch <= 1'b0;
	end

endmodule
