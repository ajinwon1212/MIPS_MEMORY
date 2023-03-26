module Control( CLK, RESET, opcode, funct, RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, HiLo);
	input CLK, RESET;
	input [5:0] opcode;
	input [5:0] funct;

	//Use reg for behavioral
	output reg [1:0] RegDst; // Write register select // 00: rd[25:21], 01: rd[15:11] , 10: ra
	output reg [1:0] Jump;
	output reg Branch;
	output reg MemRead; //Data memory read or not
	output reg [1:0] MemtoReg; //Select Write data input // 00: from ALU, 01: from Data memory, 10: from PC+4
	output reg [2:0] ALUOp;
	output reg MemWrite; //Data memory write or not
	output reg ALUSrc; //Immediate or not
	output reg RegWrite; //Register memory write or not
	output reg [1:0] HiLo; //Choose ALU result as itself, lo or hi

	always @(opcode, funct) 
	begin //R formmat 000000  is default
		RegDst		<= 2'b01;
		Jump		<= 2'b00;
		Branch		<= 1'b0;
		MemRead		<= 1'b0;
		MemtoReg	<= 2'b00;
		ALUOp		<= 3'b001; 
		MemWrite	<= 1'b0;
		ALUSrc		<= 1'b0;	
		RegWrite	<= 1'b1;
		HiLo		<= 2'b00;
		
		//$display("______Control.v______");
		casex (opcode)
			/* R format */
			6'b000000: //R 
			begin	
				if (funct == 6'b001000) //jr
				begin 
					Jump <= 2'b10;  
					$display("jr: %b", opcode); 
				end
				else if (funct == 6'b011000) //mult
				begin
					RegWrite <= 1'b0;
					$display("mult: %b", opcode); 
				end
				else if (funct == 6'b011010) //div
				begin
					RegWrite <= 1'b0;
					$display("div: %b", opcode); 
				end
				else if (funct == 6'b010000) //mfhi
				begin
					HiLo <= 2'b10;
					$display("mfhi: %b", opcode); 
				end
				else if (funct == 6'b010010) //mflo
				begin
					HiLo <= 2'b01;
					$display("mflo: %b", opcode); 
				end
				else begin 
				$display("R format: %b", opcode);
				end
			end
			
			/* J format */
			6'b000010: // j
			begin	
				//RegDst		<= 2'b10;
				Jump		<= 2'b01; //@
				//Branch		<= 1'b0;
				MemRead		<= 1'b0;
				//MemtoReg	<= 2'b10;
				ALUOp		<= 3'b111; //@ 
				MemWrite	<= 1'b0; //@
				//ALUSrc		<= 1'b0;	
				RegWrite	<= 1'b0; //@
				$display("j: %b", opcode); 
			end
			
			6'b00001x: // jal
			begin	
				RegDst		<= 2'b10; //@
				Jump		<= 2'b01; //@
				//Branch		<= 1'b0;
				MemRead		<= 1'b0;
				MemtoReg	<= 2'b10; //@
				ALUOp		<= 3'b111; //@ 
				MemWrite	<= 1'b0; 
				//ALUSrc		<= 1'b0;	
				RegWrite	<= 1'b1;
				$display("jal: %b", opcode); 
			end
			
			/* I format */
			6'b001000: // addi
			begin	
				RegDst		<= 2'b00; //@
				Jump		<= 2'b00; 
				Branch		<= 1'b0;
				MemRead		<= 1'b0;
				MemtoReg	<= 2'b00; 
				ALUOp		<= 3'b000; //@
				MemWrite	<= 1'b0; 
				ALUSrc		<= 1'b1; //@	
				RegWrite	<= 1'b1;
				$display("addi: %b", opcode); 
			end
			
			6'b001100: // andi
			begin	
				RegDst		<= 2'b00; //@
				Jump		<= 2'b00; 
				Branch		<= 1'b0;
				MemRead		<= 1'b0;
				MemtoReg	<= 2'b00; 
				ALUOp		<= 3'b010; //@ 
				MemWrite	<= 1'b0; 
				ALUSrc		<= 1'b1; //@	
				RegWrite	<= 1'b1;
				$display("andi: %b", opcode); 
			end
			
			6'b001101: // ori
			begin	
				RegDst		<= 2'b00; //@ 
				Jump		<= 2'b00; 
				Branch		<= 1'b0;
				MemRead		<= 1'b0;
				MemtoReg	<= 2'b00; 
				ALUOp		<= 3'b011; //@ 
				MemWrite	<= 1'b0; 
				ALUSrc		<= 1'b1; //@	
				RegWrite	<= 1'b1;
				$display("ori: %b", opcode); 
			end
			
			6'b000100: // beq
			begin	
				//RegDst		<= 2'b10; 
				Jump		<= 2'b00; 
				Branch		<= 1'b1; //@
				MemRead		<= 1'b0;
				//MemtoReg	<= 2'b10; 
				ALUOp		<= 3'b100; //@ 
				MemWrite	<= 1'b0; 
				ALUSrc		<= 1'b0;	
				RegWrite	<= 1'b0; //@
				$display("beq: %b", opcode); 
			end
			
			6'b000101: // bne
			begin	
				//RegDst		<= 2'b10; /0@
				Jump		<= 2'b00; 
				Branch		<= 1'b1; //@
				MemRead		<= 1'b0;
				//MemtoReg	<= 2'b10; 
				ALUOp		<= 3'b101; //@
				MemWrite	<= 1'b0; 
				ALUSrc		<= 1'b0;	
				RegWrite	<= 1'b0; //@
				$display("bne: %b", opcode); 
			end
			
			6'b100011: // lw
			begin	
				RegDst		<= 2'b00; //Immediate
				Jump		<= 2'b00; 
				Branch		<= 1'b0;
				MemRead		<= 1'b1; //Data memory read
				MemtoReg	<= 2'b01; // Write data from data memory
				ALUOp		<= 3'b000; //@ 
				MemWrite	<= 1'b0; 
				ALUSrc		<= 1'b1; // Immediate	
				RegWrite	<= 1'b1;
				$display("lw: %b", opcode); 
			end
			
			6'b101011: // sw
			begin	
				//RegDst		<= 2'b10; 
				Jump		<= 2'b00; 
				Branch		<= 1'b0;
				MemRead		<= 1'b0;
				//MemtoReg	<= 2'b10; 
				ALUOp		<= 3'b000; //@ 
				MemWrite	<= 1'b1; //Data memory write
				ALUSrc		<= 1'b1; // Immediate
				RegWrite	<= 1'b0; // No register memory write
				$display("sw: %b", opcode); 
			end
			
			6'b001010: // slti
			begin	
				RegDst		<= 2'b00; //Immediate
				Jump		<= 2'b00; 
				Branch		<= 1'b0;
				MemRead		<= 1'b0;
				MemtoReg	<= 2'b00; 
				ALUOp		<= 3'b110; //@ 
				MemWrite	<= 1'b0; 
				ALUSrc		<= 1'b1; //Immediate	
				RegWrite	<= 1'b1;
				$display("slti: %b", opcode); 
			end
			
		endcase
	end

endmodule
