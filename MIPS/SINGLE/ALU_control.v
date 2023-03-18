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
	input [1:0] ALUOp; // 2bit input
		
	output [3:0] ALU_control; // 4 bit output

    always@(ALUOp or ALU_control_IN)begin // I referred to page 261 of the textbook.
        casex({ALUOp,ALU_control_IN})
            8'b00_xxxxxx:AluCtrl=4'b0010; //lw / sw
            8'b01_xxxxxx:AluCtrl=4'b0110; //beq(Branch equal) // I referred to page 260 of the textbook. (Fig. 4.12)
            8'b1x_xx0000:AluCtrl=4'b0010; //add
            8'b1x_xx0010:AluCtrl=4'b0110; //sub
            8'b1x_xx0100:AluCtrl=4'b0000; //and
            8'b1x_xx0101:AluCtrl=4'b0001; //or
            8'b1x_xx1010:AluCtrl=4'b0111; //slt
        endcase
    end
    
    




endmodule
