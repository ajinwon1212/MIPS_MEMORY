module Data_Memory(Address, WriteData, MemWrite, MemRead, Read_data); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 

    output reg[31:0] Read_data; // Contents of memory location at Address

    reg 	[31:0] 	Memory[0:255]; // 256 32-bit memory
      
   		always 	@(Address or WriteData) // When a signal is received from control, the process starts.
   		begin
   		
			if (MemWrite==1) begin
                Memory[Address>>2] = WriteData[31:0];
			end
   		end
   		
   		always @(Address or MemRead)
   		begin	
   			if	(MemRead == 1) begin
                Read_data <= Memory[Address>>2];
   			end else 
   				Read_data <= 32'h00000000;
					
					//$display("%h",Memory[Address]);
   		end 
   		
			// initial begin
			// 	$readmemh("test_data.txt",Memory);
			
			// end	

endmodule
