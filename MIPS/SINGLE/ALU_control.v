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
        endcase
    end
    
    




endmodule
