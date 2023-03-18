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

// 참고 자료 https://chayan-memorias.tistory.com/176

module ALU( 
	ALU_IN_1, 
	ALU_IN_2,
	ALU_control ,
	ALU_zero,
	ALU_result
);

	input [31:0] ALU_IN_1; // 32bit input
	input [31:0] ALU_IN_2; // 32bit input
	input [3:0] ALU_control; // the number of opcodes in https://opencores.org/projects/plasma/opcodes 
	
	output ALU_zero, ALU_result;

	reg ALU_result;

	assign ALU_zero = (ALU_result == 0); 

	always @(*) begin
		case(ALU_control)
			4'b0000: ALU_result=ALU_IN_1&ALU_IN_2; // AND
			4'b0001: ALU_result=ALU_IN_1|ALU_IN_2; // OR
			4'b0010: ALU_result=ALU_IN_1+ALU_IN_2; // add
			4'b0110: ALU_result=ALU_IN_1-ALU_IN_2; // sub
			4'b0111: ALU_result=ALU_IN_1<ALU_IN_2?1:0; //slt, set on less than
			4'b1100: ALU_result=~(ALU_IN_1|ALU_IN_2); // NOR
		endcase
	end

endmodule
