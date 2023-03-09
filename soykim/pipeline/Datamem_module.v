
module Datamem_module(clk, rst, EXMEM_MemtoReg_out, EXMEM_RegWrite_out, EXMEM_ALUSrc_out, EXMEM_MemRead_out, EXMEM_MemWrite_out,
EXMEM_ALUresult_out, EXMEM_ALUinput2_out, EXMEM_readata2_out, EXMEM_destination_out,
MEMWB_MemtoReg_in, MEMWB_RegWrite_in, MEMWB_ALUSrc_in,
MEMWB_Readata_in, MEMWB_ALUresult_in, MEMWB_destination_in);
//EXMEM_PCnext_out, ,  //MEMWB_MemRead_in, MEMWB_MemWrite_in, //MEMWB_PCnext_in, 
	input clk, rst, EXMEM_MemtoReg_out, EXMEM_RegWrite_out, EXMEM_ALUSrc_out, EXMEM_MemRead_out, EXMEM_MemWrite_out; 
	input [31:0] EXMEM_ALUresult_out, EXMEM_ALUinput2_out, EXMEM_readata2_out;//EXMEM_PCnext_out, 
	input [4:0] EXMEM_destination_out; 
	output MEMWB_MemtoReg_in, MEMWB_RegWrite_in, MEMWB_ALUSrc_in; //MEMWB_MemRead_in, MEMWB_MemWrite_in;
	output reg [31:0] MEMWB_Readata_in;
	output [31:0] MEMWB_ALUresult_in; //MEMWB_PCnext_in, 
	output [4:0] MEMWB_destination_in;
	
	reg [31:0] Address, writedata;
	reg [31:0] Data_memory [63:0];//revised size
	
	
	assign MEMWB_MemtoReg_in = EXMEM_MemtoReg_out;
	assign MEMWB_RegWrite_in = EXMEM_RegWrite_out;
	assign MEMWB_ALUSrc_in = EXMEM_ALUSrc_out;
	assign MEMWB_ALUresult_in = EXMEM_ALUresult_out;
	assign MEMWB_destination_in = EXMEM_destination_out;
	
	always @(negedge rst or posedge clk) begin
		if (rst == 1'b0) begin
			Data_memory[0]  <= 32'd1; 
			Data_memory[1]  <= 32'd10; 
			Data_memory[2]  <= 32'd200; 
			Data_memory[3]  <= 32'd300; 
			Data_memory[4]  <= 32'd400; 
			Data_memory[5]  <= 32'd500; 
			Data_memory[6]  <= 32'd600; 
			Data_memory[7]  <= 32'd700; 
			Data_memory[8]  <= 32'd800; 
			Data_memory[9]  <= 32'd900; 
			Data_memory[10] <= 32'd1000; 
			Data_memory[11] <= 32'd1100; 
			Data_memory[12] <= 32'd1200; 
			Data_memory[13] <= 32'd1300; 
			Data_memory[14] <= 32'd1400; 
			Data_memory[15] <= 32'd1500; 
			Data_memory[16] <= 32'd1600; 
			Data_memory[17] <= 32'd1700; 
			Data_memory[18] <= 32'd1800; 
			Data_memory[19] <= 32'd1900; 
			Data_memory[20] <= 32'd2000; 
			Data_memory[21] <= 32'd2100; 
			Data_memory[22] <= 32'd2200; 
			Data_memory[23] <= 32'd2300; 
			Data_memory[24] <= 32'd2400; 
			Data_memory[25] <= 32'd2500; 
			Data_memory[26] <= 32'd2600; 
			Data_memory[27] <= 32'd2700; 
			Data_memory[28] <= 32'd0; 
			Data_memory[29] <= 32'd0; 
			Data_memory[30] <= 32'd0; 
			Data_memory[31] <= 32'd0; 
			Data_memory[32] <= 32'd0; 
			Data_memory[33] <= 32'd0; 
			Data_memory[34] <= 32'd0; 
			Data_memory[35] <= 32'd0; 
			Data_memory[36] <= 32'd0; 
			Data_memory[37] <= 32'd0; 
			Data_memory[38] <= 32'd0; 
			Data_memory[39] <= 32'd0; 
			Data_memory[40] <= 32'd0; 
			Data_memory[41] <= 32'd0; 
			Data_memory[42] <= 32'd0; 
			Data_memory[43] <= 32'd0; 
			Data_memory[44] <= 32'd0; 
			Data_memory[45] <= 32'd0; 
			Data_memory[46] <= 32'd0; 
			Data_memory[47] <= 32'd0; 
			Data_memory[48] <= 32'd0; 
			Data_memory[49] <= 32'd0; 
			Data_memory[50] <= 32'd0; 
			Data_memory[51] <= 32'd0; 
			Data_memory[52] <= 32'd0; 
			Data_memory[53] <= 32'd0; 
			Data_memory[54] <= 32'd0; 
			Data_memory[55] <= 32'd0; 
			Data_memory[56] <= 32'd0; 
			Data_memory[57] <= 32'd0; 
			Data_memory[58] <= 32'd0; 
			Data_memory[59] <= 32'd0; 
			Data_memory[60] <= 32'd0; 
			Data_memory[61] <= 32'd0; 
			Data_memory[62] <= 32'd0; 
			Data_memory[63] <= 32'd0; 
		end
		else begin
			Data_memory[0] <=	Data_memory[0]	;
			Data_memory[1] <=	Data_memory[1]	;
			Data_memory[2] <=	Data_memory[2]	;
			Data_memory[3] <=	Data_memory[3]	;
			Data_memory[4] <=	Data_memory[4]	;
			Data_memory[5] <=	Data_memory[5]	;
			Data_memory[6] <=	Data_memory[6]	;
			Data_memory[7] <=	Data_memory[7]	;
			Data_memory[8] <=	Data_memory[8]	;
			Data_memory[9] <=	Data_memory[9]	;
			Data_memory[10] <= 	Data_memory[10]	;
			Data_memory[11] <=	Data_memory[11]	;
			Data_memory[12] <=	Data_memory[12]	;
			Data_memory[13] <=	Data_memory[13]	;
			Data_memory[14] <=	Data_memory[14]	;
			Data_memory[15] <=	Data_memory[15]	;
			Data_memory[16] <=	Data_memory[16]	;
			Data_memory[17] <=	Data_memory[17]	;
			Data_memory[18] <=	Data_memory[18]	;
			Data_memory[19] <=	Data_memory[19]	;
			Data_memory[20] <=	Data_memory[20]	;
			Data_memory[21] <=	Data_memory[21]	;
			Data_memory[22] <=	Data_memory[22]	;
			Data_memory[23] <=	Data_memory[23]	;
			Data_memory[24] <=	Data_memory[24]	;
			Data_memory[25] <=	Data_memory[25]	;
			Data_memory[26] <=	Data_memory[26]	;
			Data_memory[27] <=	Data_memory[27]	;
			Data_memory[28] <=	Data_memory[28]	;
			Data_memory[29] <=	Data_memory[29]	;
			Data_memory[30] <=	Data_memory[30]	;
			Data_memory[31] <=	Data_memory[31]	;
			Data_memory[32] <=	Data_memory[32]	;
			Data_memory[33] <=	Data_memory[33]	;
			Data_memory[34] <=	Data_memory[34]	;
			Data_memory[35] <=	Data_memory[35]	;
			Data_memory[36] <=	Data_memory[36]	;
			Data_memory[37] <=	Data_memory[37]	;
			Data_memory[38] <=	Data_memory[38]	;
			Data_memory[39] <=	Data_memory[39]	;
			Data_memory[40] <=	Data_memory[40]	;
			Data_memory[41] <=	Data_memory[41]	;
			Data_memory[42] <=	Data_memory[42]	;
			Data_memory[43] <=	Data_memory[43]	;
			Data_memory[44] <=	Data_memory[44]	;
			Data_memory[45] <=	Data_memory[45]	;
			Data_memory[46] <=	Data_memory[46]	;
			Data_memory[47] <=	Data_memory[47]	;
			Data_memory[48] <=	Data_memory[48]	;
			Data_memory[49] <=	Data_memory[49]	;
			Data_memory[50] <=	Data_memory[50]	;
			Data_memory[51] <=	Data_memory[51]	;
			Data_memory[52] <=	Data_memory[52]	;
			Data_memory[53] <=	Data_memory[53]	;
			Data_memory[54] <=	Data_memory[54]	;
			Data_memory[55] <=	Data_memory[55]	;
			Data_memory[56] <=	Data_memory[56]	;
			Data_memory[57] <=	Data_memory[57]	;
			Data_memory[58] <=	Data_memory[58]	;
			Data_memory[59] <=	Data_memory[59]	;
			Data_memory[60] <=	Data_memory[60]	;
			Data_memory[61] <=	Data_memory[61]	;
			Data_memory[62] <=	Data_memory[62]	;
			Data_memory[63] <=	Data_memory[63]	;
			if (EXMEM_MemRead_out == 1'b0 && EXMEM_MemWrite_out == 1'b1) begin
				Data_memory[EXMEM_ALUresult_out] <= EXMEM_readata2_out;
			end
			MEMWB_Readata_in <= Data_memory[EXMEM_ALUresult_out];
		end
	end
endmodule
	/*
	
	
	integer i;
	assign MEMWB_ALUresult_in = EXMEM_ALUresult_out;
	assign MEMWB_destination_in = EXMEM_destination_out;

	always @(EXMEM_MemRead_out,EXMEM_MemWrite_out,EXMEM_ALUresult_out,EXMEM_readata2_out,EXMEM_ALUresult_out, //EXMEM_PCnext_out,
 	EXMEM_MemtoReg_out,EXMEM_RegWrite_out,EXMEM_ALUSrc_out,EXMEM_MemRead_out,EXMEM_MemWrite_out,EXMEM_ALUresult_out,EXMEM_destination_out )
	begin
		if (EXMEM_MemRead_out == 1'b1 && EXMEM_MemWrite_out == 1'b0) begin     // lw
			MEMWB_Readata_in <= Data_memory[EXMEM_ALUresult_out];
		end
		else if (EXMEM_MemRead_out == 1'b0 && EXMEM_MemWrite_out == 1'b1) begin	// sw
			MEMWB_Readata_in <= 32'bx;
			Data_memory[EXMEM_ALUresult_out] <= EXMEM_readata2_out;
		end
		else if (EXMEM_MemRead_out == 1'bx && EXMEM_MemWrite_out == 1'bx) begin
			MEMWB_Readata_in <= 32'bx;
		end
		
		MEMWB_MemtoReg_in <= EXMEM_MemtoReg_out;
		MEMWB_RegWrite_in <= EXMEM_RegWrite_out;
		MEMWB_ALUSrc_in <= EXMEM_ALUSrc_out;
		//MEMWB_MemRead_in <= EXMEM_MemRead_out;  
		//MEMWB_MemWrite_in <= EXMEM_MemWrite_out;
		//MEMWB_PCnext_in <= EXMEM_PCnext_out;
		MEMWB_ALUresult_in <= EXMEM_ALUresult_out;
		//MEMWB_destination_in <= EXMEM_destination_out;

	end


	always @(posedge rst)
	begin	
		Data_memory[0] = 32'b001000_00000_01000_00000_00000_100000; 
		Data_memory[1] = 32'b001000_00000_01001_00000_00000_110111; 
		Data_memory[2] = 32'b000000_01000_01001_10000_00000_100000; 
		Data_memory[3] = 32'b000000_01000_01001_10001_00000_100010; 
		Data_memory[4] = 32'b000000_01000_01001_10010_00000_100100; 
		Data_memory[5] = 32'b000000_01000_01001_10011_00000_100101; 
		Data_memory[6] = 32'b000000_01000_01001_10100_00000_101010; 
		Data_memory[7] = 32'b000100_10100_00000_00000_00000_000110; 
		Data_memory[8] = 32'b000000_01000_01001_01010_00000_100000; 
		Data_memory[9] = 32'b000000_01010_01001_01010_00000_100000; 
       		Data_memory[10] = 32'b000000_01010_01000_01011_00000_100000; 
		Data_memory[11] = 32'b100011_00000_10101_00000_00000_000100;
		Data_memory[12] = 32'b000000_01010_10101_10110_00000_100000; 
		Data_memory[13] = 32'b000000_10101_01011_10111_00000_100000; 
		Data_memory[14] = 32'b101011_00000_10101_00000_00000_001000; 
		Data_memory[15] = 32'b000010_00000_00000_00000_00000_000110; 
		Data_memory[16] = 32'b001000_00000_01000_00000_00000_100000; 
		Data_memory[17] = 32'b001000_00000_01001_00000_00000_110111; 
		Data_memory[18] = 32'b000000_01000_01001_10000_00000_100000; 
		Data_memory[19] = 32'b000000_01000_01001_10001_00000_100010; 
		Data_memory[20] = 32'b000000_01000_01001_10010_00000_100100; 
		Data_memory[21] = 32'b000000_01000_01001_10011_00000_100101; 
		Data_memory[22] = 32'b000000_01000_01001_10100_00000_101010; 
		Data_memory[23] = 32'b000100_10100_00000_00000_00000_000110; 
		Data_memory[24] = 32'b000000_01000_01001_01010_00000_100000; 
		Data_memory[25] = 32'b000000_01010_01001_01010_00000_100000; 
       		Data_memory[26] = 32'b000000_01010_01000_01011_00000_100000; 
		Data_memory[27] = 32'b100011_00000_10101_00000_00000_000100;
		Data_memory[28] = 32'b000000_01010_10101_10110_00000_100000; 
		Data_memory[29] = 32'b000000_10101_01011_10111_00000_100000; 
		Data_memory[30] = 32'b101011_00000_10101_00000_00000_001000; 
		Data_memory[31] = 32'b000010_00000_00000_00000_00000_000110; 
	end
endmodule
*/