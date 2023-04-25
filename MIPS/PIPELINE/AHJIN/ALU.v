module ALU( 
	CLK,
	ALU_IN_1, 
	ALU_IN_2,
	ALU_control,
	Shampt,
	//ALU_zero,
	ALU_result,
	Hi,
	Lo
);
	input CLK;
	input signed [31:0] ALU_IN_1; // 32bit input
	input signed [31:0] ALU_IN_2; // 32bit input
	input [3:0] ALU_control; //4bit input
	input [4:0] Shampt; //5bit input, shift size
	
	//output ALU_zero; 
	output signed [31:0] ALU_result;

	output reg signed [31:0] Hi, Lo;

	reg signed [31:0] ALU_Result;

	//assign ALU_zero = (ALU_Result == 0) ? ((ALU_control[0] == 1) ? 0 : 1 ) : ((ALU_control[0] == 1) ? 1 : 0 ); 
	//assign ALU_result = (ALU_control==4'b0111) ? Lo : ((ALU_control==4'b1110)? Hi : ALU_Result);
	assign ALU_result = ALU_Result;

	always @(*) 
	begin		
		ALU_Result <= 32'd0;
		if (ALU_control==4'b0000) ALU_Result <= ALU_IN_1 + ALU_IN_2; // ADD
		else if (ALU_control==4'b1000) ALU_Result <= ALU_IN_1 & ALU_IN_2; // AND
		else if (ALU_control==4'b0100) ALU_Result <= ALU_IN_1 - ALU_IN_2; // SUB (0:sub, beq; 1:bne)
		else if (ALU_control==4'b0110) ALU_Result <= ALU_IN_1 - ALU_IN_2; // SUB (0:sub, beq; 1:bne)
		else if (ALU_control==4'b1100) ALU_Result <= ~(ALU_IN_1 | ALU_IN_2); // NOR
		else if (ALU_control==4'b1010) ALU_Result <= ALU_IN_1 | ALU_IN_2; // OR (ORI)
		else if (ALU_control==4'b0101) ALU_Result <= ALU_IN_1 < ALU_IN_2 ? 1 : 0; // SLT (SLTI)
		else if (ALU_control==4'b0010) ALU_Result <= ALU_IN_1 << Shampt; // SHIFT_LEFT (sll)
		else if (ALU_control==4'b0011) ALU_Result <= ALU_IN_1 >> Shampt; // SHIFT_RIGHT (srl)
		else if (ALU_control==4'b1011) 
				begin
					Lo <= ALU_IN_1 / ALU_IN_2; // division quotient
					Hi <= ALU_IN_1 % ALU_IN_2;
					//$display("Hi: %d, Lo: %d", Hi, Lo);
				end
		else if (ALU_control==4'b1101)// MULT
				begin 
					Lo <= ALU_IN_1 * ALU_IN_2; // MULT
					Hi <= (ALU_IN_1 * ALU_IN_2) >> 32;
					//$display("Hi: %d, Lo: %d", Hi, Lo);
				end
		else if (ALU_control==4'b1001) ALU_Result <= ALU_IN_1 * ALU_IN_2; //MUL	
		//else if (ALU_control==4'b0111) ALU_result <= Lo; //mflo
		//else if (ALU_control==4'b1110) ALU_result <= Hi; //mfhi
		else if (ALU_control==4'b1111) ALU_Result <= 31'b0; // Do nothing
	end

endmodule
