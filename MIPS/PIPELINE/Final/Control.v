/*Control Control_top(
		.CLK(CLK),			//IN
		.RESET(RESET),			//IN
		.opcode(ID_Instruction[31:26]), //IN
		.funct(ID_Instruction[5:0]),	//IN
		.RegDst(RegDst),		//OUT
		.Jump(Jump),			//OUT @@TIming Issue
		.WB(WB),			//OUT 3bit
		.MEM(MEM),			//OUT 2bit
		.EX(EX)				//OUT 6bit

	);
*/
	//	21	/   2    /   1    /   1   /   1    /  3  /  1   /  2 /
	//	0	/MemtoReg/RegWrite/MemRead/MemWrite/ALUOP/ALUSrc/HiLo/

module Control( CLK, RESET, opcode, funct, FLUSH, RegDst, Jump, WB_CONT, MEM_CONT, EX_CONT);
	input CLK, RESET;
	input [5:0] opcode;
	input [5:0] funct;
	input FLUSH;

	output reg [1:0] RegDst; // Write register select // 00: rd[25:21], 01: rd[15:11] , 10: ra
	output reg [1:0] Jump;
	output reg [2:0] WB_CONT;
	output reg [1:0] MEM_CONT;
	output reg [5:0] EX_CONT;

	always @(opcode, funct, FLUSH) 
	begin //R formmat 000000  is default
		RegDst		<= 2'b01;
		Jump		<= 2'b00;
		EX_CONT 	<= 6'b001000;
		MEM_CONT	<= 2'b00;
		WB_CONT		<= 3'b001;
		
		//$display("______Control.v______");
		casex (opcode)
			/* R format */
			6'b000000: //R 
			begin	
				if (FLUSH == 1'b1)
				begin
					RegDst		<= 2'b00;
					Jump		<= 2'b00;
					EX_CONT 	<= 6'b000000;
					MEM_CONT	<= 2'b00;
					WB_CONT		<= 3'b000;
				end
				else if (funct == 6'b001000) //jr
				begin 
					Jump <= 2'b10;  
					//$display("jr: %b", opcode); 
				end
				else if (funct == 6'b011000) //mult
				begin
					WB_CONT[0] <= 1'b0;
					//$display("mult: %b", opcode); 
				end
				else if (funct == 6'b011010) //div
				begin
					WB_CONT[0] <= 1'b0;
					//$display("div: %b", opcode); 
				end
				else if (funct == 6'b010000) //mfhi
				begin
					EX_CONT[1:0] <= 2'b10;
					//$display("mfhi: %b", opcode); 
				end
				else if (funct == 6'b010010) //mflo
				begin
					EX_CONT[1:0] <= 2'b01;
					//$display("mflo: %b", opcode); 
				end
				else begin 
				//$display("R format: %b", opcode);
				end
			end
			
			/* J format */
			6'b000010: // j
			begin	
				//RegDst	<= 2'b10;
				Jump		<= 2'b01; //@
				//Branch	<= 1'b0;
				MEM_CONT[1]		<= 1'b0;
				//MemtoReg	<= 2'b10;
				EX_CONT[5:3]		<= 3'b111; //@ 
				MEM_CONT[0]		<= 1'b0; //@
				//ALUSrc	<= 1'b0;	
				WB_CONT[0]		<= 1'b0; //@
				//$display("j: %b", opcode); 
			end
			
			6'b00001x: // jal
			begin	
				RegDst		<= 2'b10; //@
				Jump		<= 2'b01; //@
				//Branch	<= 1'b0;
				MEM_CONT[1]		<= 1'b0;
				WB_CONT[2:1]		<= 2'b10; //@
				EX_CONT[5:3]		<= 3'b111; //@ 
				MEM_CONT[0]		<= 1'b0; 
				//ALUSrc	<= 1'b0;	
				WB_CONT[0]		<= 1'b1;
				//$display("jal: %b", opcode); 
			end
			
			/* I format */
			6'b001000: // addi
			begin	
				RegDst		<= 2'b00; //@
				Jump		<= 2'b00; 
				//Branch		<= 1'b0;
				MEM_CONT[1]		<= 1'b0;
				WB_CONT[2:1]		<= 2'b00; 
				EX_CONT[5:3]		<= 3'b000; //@
				MEM_CONT[0]		<= 1'b0; 
				EX_CONT[2]		<= 1'b1; //@	
				WB_CONT[0]		<= 1'b1;
				//$display("addi: %b", opcode); 
			end
			
			6'b001100: // andi
			begin	
				RegDst		<= 2'b00; //@
				Jump		<= 2'b00; 
				//Branch		<= 1'b0;
				MEM_CONT[1]		<= 1'b0;
				WB_CONT[2:1]		<= 2'b00; 
				EX_CONT[5:3]		<= 3'b010; //@ 
				MEM_CONT[0]		<= 1'b0; 
				EX_CONT[2]		<= 1'b1; //@	
				WB_CONT[0]		<= 1'b1;
				//$display("andi: %b", opcode); 
			end
			
			6'b001101: // ori
			begin	
				RegDst		<= 2'b00; //@ 
				Jump		<= 2'b00; 
				//Branch	<= 1'b0;
				MEM_CONT[1]		<= 1'b0;
				WB_CONT[2:1]		<= 2'b00; 
				EX_CONT[5:3]		<= 3'b011; //@ 
				MEM_CONT[0]		<= 1'b0; 
				EX_CONT[2]		<= 1'b1; //@	
				WB_CONT[0]		<= 1'b1;
				//$display("ori: %b", opcode); 
			end
			
			6'b000100: // beq
			begin	
				//RegDst	<= 2'b10; 
				Jump		<= 2'b00; 
				//Branch	<= 1'b1; //@
				MEM_CONT[1]		<= 1'b0;
				//MemtoReg	<= 2'b10; 
				EX_CONT[5:3]		<= 3'b100; //@ 
				MEM_CONT[0]		<= 1'b0; 
				EX_CONT[2]		<= 1'b0;	
				WB_CONT[0]		<= 1'b0; //@
				//$display("beq: %b", opcode); 
			end
			
			6'b000101: // bne
			begin	
				//RegDst	<= 2'b10; /0@
				Jump		<= 2'b00; 
				//Branch	<= 1'b1; //@
				MEM_CONT[1]		<= 1'b0;
				//MemtoReg	<= 2'b10; 
				EX_CONT[5:3]		<= 3'b101; //@
				MEM_CONT[0]		<= 1'b0; 
				EX_CONT[2]		<= 1'b0;	
				WB_CONT[0]		<= 1'b0; //@
				//$display("bne: %b", opcode); 
			end
			
			6'b100011: // lw
			begin	
				RegDst		<= 2'b00; //Immediate
				Jump		<= 2'b00; 
				//Branch	<= 1'b0;
				MEM_CONT[1]		<= 1'b1; //Data memory read
				WB_CONT[2:1]		<= 2'b01; // Write data from data memory
				EX_CONT[5:3]		<= 3'b000; //@ 
				MEM_CONT[0]		<= 1'b0; 
				EX_CONT[2]		<= 1'b1; // Immediate	
				WB_CONT[0]		<= 1'b1;
				//$display("lw: %b", opcode); 
			end
			
			6'b101011: // sw
			begin	
				//RegDst		<= 2'b10; 
				Jump		<= 2'b00; 
				//Branch		<= 1'b0;
				MEM_CONT[1]		<= 1'b0;
				//MemtoReg	<= 2'b10; 
				EX_CONT[5:3]		<= 3'b000; //@ 
				MEM_CONT[0]		<= 1'b1; //Data memory write
				EX_CONT[2]		<= 1'b1; // Immediate
				WB_CONT[0]		<= 1'b0; // No register memory write
				//$display("sw: %b", opcode); 
			end
			
			6'b001010: // slti
			begin	
				RegDst		<= 2'b00; //Immediate
				Jump		<= 2'b00; 
				//Branch	<= 1'b0;
				MEM_CONT[1]		<= 1'b0;
				WB_CONT[2:1]		<= 2'b00; 
				EX_CONT[5:3]		<= 3'b110; //@ 
				MEM_CONT[0]		<= 1'b0; 
				EX_CONT[2]		<= 1'b1; //Immediate	
				WB_CONT[0]		<= 1'b1;
				//$display("slti: %b", opcode); 
			end
			
		endcase
	end

endmodule
