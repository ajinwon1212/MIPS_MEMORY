
module Instruction_module (PC_next, instruction);
   	input [7:0] PC_next;
   	output [31:0] instruction;

   	wire [31:0] instruction_memory[63:0];  
   	assign instruction = instruction_memory[PC_next[7:2]];
	
	assign instruction_memory[0] = 32'b0;                                     // nop
	assign instruction_memory[1] = 32'b100011_00000_01000_00000_00000_000001; // lw $t0, 1($zero)
	assign instruction_memory[2] = 32'b0; //32'b000100_01000_00000_00000_00000_000010; // beq $t0, $zero, 2
	assign instruction_memory[3] = 32'b0; //32'b000100_00000_00000_11111_11111_111110; // beq $zero, $zero, -2
	assign instruction_memory[4] = 32'b000000_01000_01000_01001_00000_000000; // add $t1, $t0, $t0 - mismatch from MIPS standard
	assign instruction_memory[5] = 32'b000000_01000_00000_01001_00000_000000; // add $t1, $t0, $zero
	assign instruction_memory[6] = 32'b0; //32'b000100_01001_01000_00000_00000_000011; // beq $t1, $t0, 3
	assign instruction_memory[7] = 32'b000000_01001_00000_10000_00000_000000; // add $s0, $t1, $zero
	assign instruction_memory[8] = 32'b0;                                     // nop
	assign instruction_memory[9] = 32'b0;                                     // nop
	
	
	assign instruction_memory[10] = 32'b000000_00000_10011_01000_00010_001010;    //sll $t0, $s3, 2
	assign instruction_memory[11] = 32'b000000_00000_10011_01001_00011_001011;    //srl $t1, $s3, 3
	assign instruction_memory[12] = 32'b000000_01001_01000_01010_00000_001110;    //slt $t2, $t1, $t0
	
	
	assign instruction_memory[13] = 32'b101011_01010_10101_00000_00000_001000;    //sw $s5, 8($t2)
	assign instruction_memory[14] = 32'b100011_01001_10110_00000_00000_000100;
	assign instruction_memory[15] = 32'b0;
	assign instruction_memory[16] = 32'b0;
	assign instruction_memory[17] = 32'b0;
	assign instruction_memory[18] = 32'b0;
	assign instruction_memory[19] = 32'b0;
	assign instruction_memory[20] = 32'b0;
	assign instruction_memory[21] = 32'b0;
	assign instruction_memory[22] = 32'b0;
	assign instruction_memory[23] = 32'b0;
	assign instruction_memory[24] = 32'b0;
	assign instruction_memory[25] = 32'b0;
	assign instruction_memory[26] = 32'b0;
	assign instruction_memory[27] = 32'b0;
	assign instruction_memory[28] = 32'b0;
	assign instruction_memory[29] = 32'b0;
	assign instruction_memory[30] = 32'b0;
	assign instruction_memory[31] = 32'b0;
	assign instruction_memory[32] = 32'b0;
	assign instruction_memory[33] = 32'b0;
	assign instruction_memory[34] = 32'b0;
	assign instruction_memory[35] = 32'b0;
	assign instruction_memory[36] = 32'b0;
	assign instruction_memory[37] = 32'b0;
	assign instruction_memory[38] = 32'b0;
	assign instruction_memory[39] = 32'b0;
	assign instruction_memory[40] = 32'b0;
	assign instruction_memory[41] = 32'b0;
	assign instruction_memory[42] = 32'b0;
	assign instruction_memory[43] = 32'b0;
	assign instruction_memory[44] = 32'b0;
	assign instruction_memory[45] = 32'b0;
	assign instruction_memory[46] = 32'b0;
	assign instruction_memory[47] = 32'b0;
	assign instruction_memory[48] = 32'b0;
	assign instruction_memory[49] = 32'b0;
	assign instruction_memory[50] = 32'b0;
	assign instruction_memory[51] = 32'b0;
	assign instruction_memory[52] = 32'b0;
	assign instruction_memory[53] = 32'b0;
	assign instruction_memory[54] = 32'b0;
	assign instruction_memory[55] = 32'b0;
	assign instruction_memory[56] = 32'b0;
	assign instruction_memory[57] = 32'b0;
	assign instruction_memory[58] = 32'b0;
	assign instruction_memory[59] = 32'b0;
	assign instruction_memory[60] = 32'b0;
	assign instruction_memory[61] = 32'b0;
	assign instruction_memory[62] = 32'b0;
	assign instruction_memory[63] = 32'b0;

endmodule