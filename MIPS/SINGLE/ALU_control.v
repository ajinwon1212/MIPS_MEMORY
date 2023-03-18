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

module ALU_control( 
	opA, 
	opB,
	ALUop,
	result,
	zero
);

   	input [31:0] opA; // 32bit input
	input [31:0] opB; // 32bit input
	input [3:0] ALUop; // the number of opcodes in https://opencores.org/projects/plasma/opcodes 
	
	output result, zero;

	reg result;

	assign zero = (result == 0); 

	always @(*) begin
		case(ALUop)
			4'b0000: result=opA&opB; // AND
			4'b0001: result=opA|opB; // OR
			4'b0010: result=opA+opB; // add
			4'b0110: result=opA-opB; // sub
			4'b0111: result=opA<opB?1:0; //slt, set on less than
			4'b1100: result=~(opA|opB); // NOR
		endcase
	end

endmodule

