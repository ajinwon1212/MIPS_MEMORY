module ALU_control( 
	ALU_control_IN, // function field for R-type instruction
	ALUOp, // Aluop
	ALU_control // 4 bit
);

	input [5:0] ALU_control_IN; // 6bit input
	input [2:0] ALUOp; // 3bit input
		
	output reg [3:0] ALU_control; // 4 bit output

	always@(ALUOp or ALU_control_IN)
	begin // I referred to page 261 of the textbook.
		
		//$display("______ALU_control.v______");
		
		casex({ALUOp,ALU_control_IN})
		9'b111_xxxxxx: 
				begin 
				ALU_control <= 4'b1111;	//Do nothing in ALU
				$display("[j, jal] ALUop: %b", ALUOp); 
				end
		9'b000_xxxxxx: 
				begin
				ALU_control <= 4'b0000;	//ADD operation (addi, lw, sw)
				$display("[addi, lw, sw] ALUop: %b", ALUOp);
				end
		9'b100_xxxxxx: 
				begin
				ALU_control <= 4'b0100;	//SUB operation 1 (subi, beq)
				$display("[subi, beq] ALUop: %b", ALUOp);
				end
		9'b101_xxxxxx: 
				begin 
				ALU_control <= 4'b0110;	//SUB operation 2 (bne)
				$display("[bne] ALUop: %b", ALUOp);
				end
		9'b110_xxxxxx: 
				begin 
				ALU_control <= 4'b0101;	//SUB operation 3 (slti)
				$display("[slti] ALUop: %b", ALUOp);
				end
		9'b010_xxxxxx: 
				begin
				ALU_control <= 4'b1000;	//AND operation
				$display("[andi] ALUop: %b", ALUOp);
				end
		9'b011_xxxxxx: 
				begin 
				ALU_control <= 4'b1010;	//OR operation
				$display("[ori] ALUop: %b", ALUOp);
				end
		/* R type */
		9'b001_100000: 
				begin
				ALU_control <= 4'b0000;	//ADD operation
				$display("[add] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_100100: 
				begin
				ALU_control <= 4'b1000;	//AND operation
				$display("[and] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_001000: 
				begin
				ALU_control <= 4'b1111;	//Do nothing in ALU
				$display("[jr] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_100111: 
				begin
				ALU_control <= 4'b1100;	//NOR operation
				$display("[nor] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_100101: 
				begin
				ALU_control <= 4'b1010;	//OR operation
				$display("[or] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_101010: 
				begin
				ALU_control <= 4'b0101;	//SUB operation 3 (slt)
				$display("[slt] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_000000: 
				begin 
				ALU_control <= 4'b0010;	//SHIFT Left operation (sll)
				$display("[sll] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_000010: 
				begin 
				ALU_control <= 4'b0011;	//SHIFT Right operation (srl)
				$display("[srl] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_100010: 
				begin 
				ALU_control <= 4'b0100;	//SUB operation 1 (sub)
				$display("[sub] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_011010: 
				begin
				ALU_control <= 4'b1011;	//DIVIDE operation (div)
				$display("[div] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_011000: 
				begin 
				ALU_control <= 4'b1101;	//MULTIPLY operation 1 (mult)
				$display("[mult] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_010000:
				begin
				ALU_control <= 4'b1110; //Move From Hi (mfhi)
				$display("[mfhi] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_010010:
				begin
				ALU_control <= 4'b0111; //Move From Lo (mflo)
				$display("[mflo] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		9'b001_011001: //Substitude multu > mul in this project!
				begin
				ALU_control <= 4'b1001; //MULTIPLY operation 2 (mul)
				$display("[mul] ALUop: %b, funct: %b", ALUOp, ALU_control_IN);
				end
		endcase
	end
endmodule
