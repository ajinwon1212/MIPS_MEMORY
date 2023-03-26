module Data_memory(CLK, RESET, Address, Write_Data, MemWrite, MemRead, Read_data); 

	input CLK, RESET;
	input [31:0] Address; 	// Input Address 
	input signed [31:0] Write_Data; // Data that needs to be written into the address 
	input MemWrite; 		// Control signal for memory write 
	input MemRead; 			// Control signal for memory read 

	output reg signed [31:0] Read_data; // Contents of memory location at Address

	reg 	[31:0] 	Data_memory[0:63]; // 
      
   	always 	@(posedge RESET or posedge CLK) // When a signal is received from control, the process starts.
		if (RESET)
		begin
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
			$display("RESET MODE");	
		end   	
	
		else
		begin
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

   			$display("Data_mem_Address: %d", Address);
			if (MemWrite==1) begin
				Data_memory[Address>>2] <= Write_Data;
				$display("Write_data: %d", Write_Data);
			end
   			else if	(MemRead == 1) begin
                		Read_data <= Data_memory[Address>>2];
				$display("Read_data: %d", Read_data);
   			end 
			else Read_data <= 32'h00000000;
   		end
   		/*
   		always @(Address or MemRead)
   		begin	
   			if	(MemRead == 1) begin
                		Read_data <= Memory[Address>>2];
				$display("Read_data: %d", Read_data);
   			end 
			else Read_data <= 32'h00000000;
			
			//$display("______Data_memory.v______")
			
			//$display("%h",Memory[Address]);
   		end 
   		
			// initial begin
			// 	$readmemh("test_data.txt",Memory);
			
			// end	
		*/
endmodule
