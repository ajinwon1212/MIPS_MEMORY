module ALU( 
	ALU_IN_1, 
	ALU_IN_2,
	ALU_control,
	Shampt,
	ALU_zero,
	ALU_result,
	Hi,
	Lo
);

	input signed [31:0] ALU_IN_1; // 32bit input
	input signed [31:0] ALU_IN_2; // 32bit input
	input [3:0] ALU_control; //4bit input
	input [4:0] Shampt; //5bit input, shift size
	
	output reg ALU_zero; 
	output reg signed [31:0] ALU_result;

	output reg signed [31:0] Hi, Lo;

	//reg ALU_result;

	assign ALU_zero = (ALU_result == 0) ? ((ALU_control[0] == 1) ? 0 : 1 ) : ((ALU_control[0] == 1) ? 1 : 0 ); 

	always @(*) begin
		casex(ALU_control)
			4'b0000: ALU_result = ALU_IN_1 + ALU_IN_2; // ADD
			4'b1000: ALU_result = ALU_IN_1 & ALU_IN_2; // AND
			4'b01x0: ALU_result = ALU_IN_1 - ALU_IN_2; // SUB (0:sub, beq; 1:bne)
			4'b1100: ALU_result = ~(ALU_IN_1 | ALU_IN_2); // NOR
			4'b1010: ALU_result = ALU_IN_1 | ALU_IN_2; // OR (ORI)
			4'b0101: ALU_result = ALU_IN_1 < ALU_IN_2 ? 1 : 0; // SLT (SLTI)
			4'b0010: ALU_result = ALU_IN_1 << Shampt; // SHIFT_LEFT (sll)
			4'b0011: ALU_result = ALU_IN_1 >> Shampt; // SHIFT_RIGHT (srl)
			4'b1011: // DIV
				begin
					Lo = ALU_IN_1 / ALU_IN_2; // division quotient
					Hi = ALU_IN_1 % ALU_IN_2;
					$display("Hi: %d, Lo: %d", Hi, Lo);
				end
			4'b1101: // MULT
				begin 
					Lo = ALU_IN_1 * ALU_IN_2; // MULT
					Hi = (ALU_IN_1 * ALU_IN_2) >> 32;
					$display("Hi: %d, Lo: %d", Hi, Lo);
				end
			4'b1001: ALU_result = ALU_IN_1 * ALU_IN_2; //MUL			
			4'b1111: ALU_result = 1'b0; // Do nothing
		endcase
		//$display("______ALU.v______");
		$display("ALU_result: %d, ALU_zero: %d", ALU_result, ALU_zero);
	end

endmodule
