//32bits (4bytes) size instruction
//4byte = address >> mem[PC_next>>2] used!
//How many registers to use? 64. This can be changed.

//R type
//	op	rs	rt	rd	shampt	funct
//	6	5	5	5	5	6

//I Type
//	op	rs	rt	constant or address
//	6	5	5	16

//J Type
//	op	address
//	6	26


module Instruction_memory (CLK, RESET, PC, IF_Instruction);
	input CLK, RESET;
	input [31:0] PC;
   	output [31:0] IF_Instruction;
	
	reg [31:0] inst_mem[0:63];


	initial
	begin
		$readmemb("code.txt",inst_mem);
	end

	always@(posedge CLK, posedge RESET)
	begin
		if (RESET) 
		begin 
			$readmemb("reset.txt",inst_mem); 
			$display("RESET MODE");	
		end

		else 
		begin 
			$readmemb("code.txt",inst_mem); 
			$display("Current Instruction: %b", inst_mem[PC>>2]);	
		end
		
	end

	assign IF_Instruction = inst_mem[PC>>2];	
	
/*
	initial 
	begin
	$monitor($time, " inst_mem = %b", IF_Instruction);
	end
*/
endmodule
