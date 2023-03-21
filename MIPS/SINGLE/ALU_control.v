/*	// 10. ALU_control	-[SEUNGWON]
	ALU_control ALU_control_top(
		.ALU_control_IN(Instruction[5:0]),	//IN
		.ALUOp(ALUOp),				//IN
		.ALU_control(ALU_control)		//OUT
	);
*/


module ALU_control( 
	ALU_control_IN, // function field for R-type instruction
	ALUOp, // Aluop
	ALU_control , // 4 bit
);

	input [5:0] ALU_control_IN; // 6bit input
	input [2:0] ALUOp; // 3bit input
		
	output [3:0] ALU_control; // 4 bit output

    always@(ALUOp or ALU_control_IN)begin // I referred to page 261 of the textbook.
        casex({ALUOp,ALU_control_IN})
		9'b111_xxxxxx:AluCtrl=4'b1111; //Do nothing in ALU
		9'b000_xxxxxx:AluCtrl=4'b0000; //ADD operation (addi, lw, sw)
		9'b100_xxxxxx:AluCtrl=4'b0100;	//SUB operation 1 (subi, beq)
		9'b100_xxxxxx:AluCtrl=4'b0110;	//SUB operation 2 (bne)
		9'b100_xxxxxx:AluCtrl=4'b0101;	//SUB operation 3 (slti)
		9'b010_xxxxxx:AluCtrl=4'b1000;	//AND operation
		9'b011_xxxxxx:AluCtrl=4'b1010;	//OR operation
		/* R type */
		9'b001_100000:AluCtrl=4'b0000; //ADD operation
		9'b001_100100:AluCtrl=4'b1000;	//AND operation
		9'b001_001000:AluCtrl=4'b1111; //Do nothing in ALU
		9'b001_100111:AluCtrl=4'b1100; //NOR operation
		9'b001_100101:AluCtrl=4'b1010;	//OR operation
		9'b001_101010:AluCtrl=4'b0101;	//SUB operation 3 (slt)
		9'b001_000000:AluCtrl=4'b0010;	//SHIFT Left operation (sll)
		9'b001_000010:AluCtrl=4'b0011;	//SHIFT Right operation (srl)
		9'b001_100010:AluCtrl=4'b0100;	//SUB operation 1 (sub)
		9'b001_011010:AluCtrl=4'b1011;	//DIVIDE operation (div)
		9'b001_011000:AluCtrl=4'b1101;	//MULTIPLY operation 1 (mult)
	endcase
    end
endmodule
