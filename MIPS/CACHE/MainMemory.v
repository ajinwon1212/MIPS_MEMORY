//32bits (4bytes) size instruction
//4byte = address >> mem[PC_next>>2] used!
//How many registers to use? 64. This can be changed.

module MainMemory (CLK, RESET, PC, Access_MM, Data_MM);
	input CLK, RESET;
	input [31:0] PC;
    input Access_MM;
    output [31:0] Data_MM;
	
	reg [31:0] inst_mem[0:127];


	initial
	begin
		//$readmemb("fact.txt",inst_mem);
		//$readmemb("code.txt",inst_mem);
		$readmemb("prime.txt",inst_mem);
	end

	always@(posedge CLK, posedge RESET)
	begin
		if (RESET) 
		begin 
			$readmemb("reset.txt",inst_mem); 	
		end

		else 
		begin 
			//$readmemb("code.txt",inst_mem, 0, 127); 
			//$readmemb("fact.txt",inst_mem, 0, 127); 
			$readmemb("prime.txt",inst_mem, 0, 127);
		end
		
	end

    assign Data_MM = (Access_MM==1'b1) ? inst_mem[PC>>2] : 32'd0 ;	
	

endmodule
