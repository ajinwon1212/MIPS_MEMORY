// beq EXCLUDED

module ALU_module(ALUinput1, ALUinput2, ALUcontrol, IDEX_shamt_out, EXMEM_ALUresult_in);
	input[31:0] ALUinput1, ALUinput2;
	input[3:0] ALUcontrol;
	input[4:0] IDEX_shamt_out;
	output [31:0] EXMEM_ALUresult_in;
	//output zero;
	
	assign EXMEM_ALUresult_in = 
		(ALUcontrol == 4'b0000) ? (ALUinput1 + ALUinput2) : (
		(ALUcontrol == 4'b0001) ? (ALUinput1 - ALUinput2) : (
		/*(ALUcontrol == 4'b0010) ? (ALUinput1 * ALUinput2) : (
		(ALUcontrol == 4'b0011) ? (ALUinput1 / ALUinput2) : (  */
		(ALUcontrol == 4'b0100) ? (ALUinput1 & ALUinput2) : (
		(ALUcontrol == 4'b0101) ? (ALUinput1 | ALUinput2) : (
		(ALUcontrol == 4'b0110) ? (~(ALUinput1 | ALUinput2)) : (
		(ALUcontrol == 4'b0111) ? (ALUinput1 ^ ALUinput2) : (
		(ALUcontrol == 4'b1000) ? (~(ALUinput1 & ALUinput2)) : (
		(ALUcontrol == 4'b1001) ? (~(ALUinput1 ^ ALUinput2)) : (
		(ALUcontrol == 4'b1010) ? (ALUinput2 << IDEX_shamt_out) : (
		(ALUcontrol == 4'b1011) ? (ALUinput2 >> IDEX_shamt_out) : (
		(ALUcontrol == 4'b1110) ? ((ALUinput1 < ALUinput2) ? 32'b1 : 32'b0) : 32'b0 ) ) ) ) ) ) ) ) ) );
	//assign zero = (EXMEM_ALUresult_in == 1'b0) ? 1'b1 : 1'b0;
endmodule