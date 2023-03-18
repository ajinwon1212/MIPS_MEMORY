module Control( opcode, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);

	input [5:0] opcode;

	//Use reg for behavioral
	output reg [2:0] RegDst;
	output reg [2:0] Jump;
	output reg [2:0] Branch;
	output reg [2:0] MemRead;
	output reg [2:0] MemtoReg;
	output reg [1:0] ALUOp;
	output reg [2:0] MemWrite;
	output reg [2:0] ALUSrc;
	output reg [2:0] RegWrite;

	always @(*) 
	begin //R formmat 000000  is default
		RegDst		<= 1'b1;
		Jump		<= 1'b0;
		Branch		<= 1'b0;
		MemRead		<= 1'b0;
		MemtoReg	<= 1'b0;
		ALUOp[1:0]	<= 2'b10; 
		MemWrite	<= 1'b0;
		ALUSrc		<= 1'b0;	
		RegWrite	<= 1'b1;

		casex (opcode)
			6'b000000: //R formmat 000000
			begin	
			end

			6'b0100xx: //J formmat 0100xx
			begin	
				Jump		<= 1'b1;
			end
/*
			6'b000100: //coprocessor opcode 0100xx 
			begin	
				aluop[0]  <= 1'b1;
				aluop[1]  <= 1'b0;
				branch_eq <= 1'b1;
				regwrite  <= 1'b0;
			end
*/
			6'b011100: //lw
			begin	
				RegDst		<= 1'b0;
				Jump		<= 1'b0;
				Branch		<= 1'b0;
				MemRead		<= 1'b1;
				MemtoReg	<= 1'b1;
				ALUOp[1:0]	<= 2'b00; 
				MemWrite	<= 1'b0;
				ALUSrc		<= 1'b1;	
				RegWrite	<= 1'b1;
			end

			6'b011101: //sw
			begin	
				Jump		<= 1'b0;
				Branch		<= 1'b0;
				MemRead		<= 1'b0;
				ALUOp[1:0]	<= 2'b00; 
				MemWrite	<= 1'b1;
				ALUSrc		<= 1'b1;	
				RegWrite	<= 1'b0;
			end

			6'b100000: //beq
			begin	
				Jump		<= 1'b0;
				Branch		<= 1'b1;
				MemRead		<= 1'b0;
				ALUOp[1:0]	<= 2'b01; 
				MemWrite	<= 1'b0;
				ALUSrc		<= 1'b0;	
				RegWrite	<= 1'b0;
			end

			6'b101000: //bne
			begin	
				Jump		<= 1'b0;
				Branch		<= 1'b1;
				MemRead		<= 1'b0;
				ALUOp[1:0]	<= 2'b01; 
				MemWrite	<= 1'b0;
				ALUSrc		<= 1'b0;	
				RegWrite	<= 1'b0;
			end
		endcase
	end

endmodule
