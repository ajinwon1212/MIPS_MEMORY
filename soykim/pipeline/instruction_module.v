
module Instruction_module (PCnext, IFID_instruction_in, IFID_PCnext_in, beq_stall);
	input [31:0] PCnext; //pc 
	output [31:0] IFID_instruction_in;
	output [31:0] IFID_PCnext_in;
	output beq_stall;

	wire [31:0] instruction_memory[63:0];  
	
	assign IFID_instruction_in = instruction_memory[PCnext >> 2];
	assign IFID_PCnext_in = PCnext;
	assign beq_stall = ((IFID_instruction_in[31:26] == 6'b000100) && (IFID_instruction_in[25:21] - IFID_instruction_in[20:16] == 6'b000000)) ? 1'b0 : 1'b1;


      	//R-type instruction
      	assign instruction_memory[0] = 32'b000000_10011_10010_01000_00000_000000; //add $t0, $s3, $s2
      	assign instruction_memory[1] = 32'b000000_10011_10010_01000_00000_000000; //add $t0, $s3, $s2
      	assign instruction_memory[2] = 32'b000000_10011_10010_01001_00000_000001; //sub $t1, $s3, $s2
      	assign instruction_memory[3] = 32'b000000_10011_10010_01100_00000_000100; //and $t4, $s3, $s2
      	assign instruction_memory[4] = 32'b000000_10011_10010_01101_00000_000101; //or $t5, $s3, $s2
      	assign instruction_memory[5] = 32'b000000_10011_10010_01110_00000_001000; //nor $t6, $s3, $s2
      	assign instruction_memory[6] = 32'b000000_10011_10010_01111_00000_001001; //xor $t7, $s3, $s2

/*
     	//data hazard(R-type)
      	assign instruction_memory[9] = 32'b000000_10001_10011_01000_00000_000000;  //add $t0, $s1, $s3
      	assign instruction_memory[10] = 32'b000000_01000_10001_01001_00000_000000;  //add $t1, $t0, $s1
      	assign instruction_memory[11] = 32'b000000_10001_01001_01010_00000_000000;  //add $t2, $s1, $t1
      	assign instruction_memory[12] = 32'b000000_01010_01010_01011_00000_000000;  //add $t3, $t2, $t2

      	//double data hazard(R-type)
      	assign instruction_memory[13] = 32'b000000_10001_10010_01001_00000_000000;  //add $t1, $s1, $s2
      	assign instruction_memory[14] = 32'b000000_01001_01011_01001_00000_000000;  //add $t1, $t1, $t3
      	assign instruction_memory[15] = 32'b000000_01001_10100_01001_00000_000000;  //add $t1, $t1, $s4

     	//lw,sw instruction
      	assign instruction_memory[16] = 32'b000000_10011_10010_01010_00000_000000; //add $t2, $s3, $s2
      	assign instruction_memory[17] = 32'b101011_01010_10001_00000_00000_001000; //sw $s1, 8($t2)
      	assign instruction_memory[18] = 32'b100011_01010_01000_00000_00000_001000; //lw $t0, 8($t2)
      	assign instruction_memory[19] = 32'b000000_01000_10000_01001_00000_000000; //add $t1,$t0,$s0
      	assign instruction_memory[20] = 32'b000000_10001_01001_01001_00000_000000; //add $t1,$s1,$t1

      	//1 data hazard(lw)
      	assign instruction_memory[21] = 32'b000000_10000_10001_01001_00000_000000;  //add $t1, $s0, $s1
      	assign instruction_memory[22] = 32'b100011_01001_01010_00000_00000_001000;  //lw $t2, 8($t1)
      	assign instruction_memory[23] = 32'b000000_01010_10001_01010_00000_000000;  //add $t2, $t2, $s1

      	//1 data hazard(sw)
      	assign instruction_memory[24] = 32'b000000_10011_10010_01010_00000_000000; //add $t2, $s3, $s2
      	assign instruction_memory[25] = 32'b101011_10000_01010_00000_00000_001000; //sw $t2, 8($s0)
      	assign instruction_memory[26] = 32'b100011_10000_01001_00000_00000_001000; //lw $t1, 8($s0)
*/

	assign instruction_memory[9] = 32'b0;
	assign instruction_memory[10] = 32'b0;
	assign instruction_memory[11] = 32'b0;
	assign instruction_memory[12] = 32'b0;
	assign instruction_memory[13] = 32'b0;
	assign instruction_memory[14] = 32'b0;
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
	

	
/*
	assign instruction_memory[0] = 32'b000000_01000_01000_01000_00000_000000; //add $t0, $t0, $t0
	assign instruction_memory[1] = 32'b101011_01000_10001_00000_00000_000001; //sw $s1, 1($t0)
	assign instruction_memory[2] = 32'b100011_01000_10001_00000_00000_000001; //lw $s1, 1($t0)
	assign instruction_memory[3] = 32'b000000_10001_01001_10001_00000_000010; //mul $s1, $s1, $t1
	assign instruction_memory[4] = 32'b000000_10000_10001_10000_00000_000000; //add $s0, $s0, $s1
	
	assign instruction_memory[5] = 32'b101011_01000_10010_00000_00000_000010; //sw $s2, 2($t0)
	assign instruction_memory[6] = 32'b100011_01000_10001_00000_00000_000010; //lw $s1, 2($t0)
	assign instruction_memory[7] = 32'b000000_10001_01010_10001_00000_000010; //mul $s1, $s1, $t2
	assign instruction_memory[8] = 32'b000000_10000_10001_10000_00000_000000; //add $s0, $s0, $s1
	
	assign instruction_memory[9] = 32'b101011_01000_10011_00000_00000_000011; //sw $s3, 3($t0)
	assign instruction_memory[10] = 32'b100011_01000_10001_00000_00000_000011; //lw $s1, 3($t0)
	assign instruction_memory[11] = 32'b000000_10001_01011_10001_00000_000010; //mul $s1, $s1, $t3
	assign instruction_memory[12] = 32'b000000_10000_10001_10000_00000_000000; //add $s0, $s0, $s1
	
	assign instruction_memory[13] = 32'b101011_01000_10100_00000_00000_000100; //sw $s4, 4($t0)
	assign instruction_memory[14] = 32'b100011_01000_10001_00000_00000_000100; //lw $s1, 4($t0)
	assign instruction_memory[15] = 32'b000000_10001_01100_10001_00000_000010; //mul $s1, $s1, $t4
	assign instruction_memory[16] = 32'b000000_10000_10001_10000_00000_000000; //add $s0, $s0, $s1
	
	assign instruction_memory[17] = 32'b101011_01000_10101_00000_00000_000101; //sw $s5, 5($t0)
	assign instruction_memory[18] = 32'b100011_01000_10001_00000_00000_000101; //lw $s1, 5($t0)
	assign instruction_memory[19] = 32'b000000_10001_01101_10001_00000_000010; //mul $s1, $s1, $t5
	assign instruction_memory[20] = 32'b000000_10000_10001_10000_00000_000000; //add $s0, $s0, $s1
	
	assign instruction_memory[21] = 32'b101011_01000_10110_00000_00000_000110; //sw $s6, 6($t0)
	assign instruction_memory[22] = 32'b100011_01000_10001_00000_00000_000110; //lw $s1, 6($t0)
	assign instruction_memory[23] = 32'b000000_10001_01110_10001_00000_000010; //mul $s1, $s1, $t6
	assign instruction_memory[24] = 32'b000000_10000_10001_10000_00000_000000; //add $s0, $s0, $s1
	
	assign instruction_memory[25] = 32'b101011_01000_10111_00000_00000_000111; //sw $s7, 7($t0)
	assign instruction_memory[26] = 32'b100011_01000_10001_00000_00000_000111; //lw $s1, 7($t0)
	assign instruction_memory[27] = 32'b000000_10001_01111_10001_00000_000010; //mul $s1, $s1, $t7
	assign instruction_memory[28] = 32'b000000_10000_10001_10000_00000_000000; //add $s0, $s0, $s1
	
	assign instruction_memory[29] = 32'b101011_01000_11010_00000_00000_001000; //sw $s8, 8($t0)
	assign instruction_memory[30] = 32'b100011_01000_10001_00000_00000_001000; //lw $s1, 8($t0)
	assign instruction_memory[31] = 32'b000000_10001_11000_10001_00000_000010; //mul $s1, $s1, $t8
	assign instruction_memory[32] = 32'b000000_10000_10001_10000_00000_000000; //add $s0, $s0, $s1
	
	assign instruction_memory[33] = 32'b101011_01000_11011_00000_00000_001001; //sw $s9, 9($t0)
	assign instruction_memory[34] = 32'b100011_01000_10001_00000_00000_001001; //lw $s1, 9($t0)
	assign instruction_memory[35] = 32'b000000_10001_11001_10001_00000_000010; //mul $s1, $s1, $t9
	assign instruction_memory[36] = 32'b000000_10000_10001_10000_00000_000000; //add $s0, $s0, $s1
	
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
	

*/
	/*
	reg [5:0] opcode;
	reg [4:0] rs, rt;
	assign opcode= IFID_instruction_in[31:26];
	assign rs = IFID_instruction_in[25:21];
	assign rt = IFID_instruction_in[20:16];
	
   always @(opcode,rs,rt)
   begin
	if(opcode == 6'b000100) begin
		if(rs == rt) begin
			beq_stall <= 1'b0;
		end
		else begin
			beq_stall <= 1'bx;
		end
	end
	else begin
		beq_stall <= 1'bx;
	end
   end
   */
endmodule