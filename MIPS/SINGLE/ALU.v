//	<Module names>		<Editor>
// 1. TOP_single		AHJIN
// 2. PC			YUNSUNG
// 3. Add			YUNSUNG				Use 32bit input & output
// 4. Instruction_memory	AHJIN
// 5. Control			AHJIN
// 6. Mux			AHJIN, YUNSUNG, SEUNGWON	Use 32bit input & 1 bit select sig
// 7. Registers			AHJIN
// 8. Sign_extend		AHJIN
// 9. ALU			SEUNGWON
// 10. ALU_control		SEUNGWON
// 11. Shift_left_2		YUNSUNG
// 12. Data_memory		SEUNGWON
// 13. And			YUNSUNG				Use 1bit input & output
//
// ALL connections are standard MIPS 32bit
// Use postive "RESET", "CLK" instance name for module.

// reference; https://chayan-memorias.tistory.com/176

module ALU( 
	ALU_IN_1, 
	ALU_IN_2,
	ALU_control,
	Shampt,
	ALU_zero,
	ALU_result
);

	input [31:0] ALU_IN_1; // 32bit input
	input [31:0] ALU_IN_2; // 32bit input
	input [3:0] ALU_control; //4bit input
	
	input [5:0] Shamt; //5bit input, shift size
	
	output ALU_zero, ALU_result;

	reg ALU_result;

	assign ALU_zero = (ALU_result == 0) ? ((ALU_control[0] == 1) ? 0 : 1 ) : ((ALU_control[0] == 1) ? 1 : 0 ); 

	always @(*) begin
		casex(ALU_control)
			4'b0000: ALU_result = ALU_IN_1 + ALU_IN_2; // ADD
			4'b1000: ALU_result = ALU_IN_1 & ALU_IN_2; // AND
			4'b01x0: ALU_result = ALU_IN_1 - ALU_IN_2; // SUB (0:sub, beq; 1:bne)
			4'b1100: ALU_result = ALU_IN_1 ~| ALU_IN_2; // NOR
			4'b1010: ALU_result = ALU_IN_1 | ALU_IN_2; // OR (ORI)
			4'b0101: ALU_result = ALU_IN_1 < ALU_IN_2 ? 1 : 0; // SLT (SLTI)
			4'b0010: ALU_result = ALU_IN_1 << Shamt; // SHIFT_LEFT (sll)
			4'b0011: ALU_result = ALU_IN_1 >> Shamt; // SHIFT_RIGHT (srl)
			4'b1011: ALU_result = ALU_IN_1 / ALU_IN_2; // DIV @need float therefore only use division quotient
			4'b1101: ALU_result = ALU_IN_1 * ALU_IN_2; // MULT
			4'b1111: ALU_result = 1'b0; // Do nothing
		endcase
		$display("______ALU.v______");
		$display("ALU_result: %d, ALU_zero: %d", ALU_result, ALU_zero);
	end

endmodule
