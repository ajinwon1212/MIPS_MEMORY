//	<Module names>		<Editor>
// 1. TOP_single		AHJIN
// 2. PC			YUNSUNG
// 3. Add			YUNSUNG				Use 32bit input & output
// 4. Instruction_memory	AHJIN
// 5. Control			AHJIN
// 6. Mux			AHJIN, YUNSUNG, SEUNGWON	Use 32bit input & 1 bit select sig
// 7. Registers			AHJIN
// 8. Sign_extend		AHJIN
// 9. ALU			SEUNGWON
// 10. ALU_control		SEUNGWON
// 11. Shift_left_2		YUNSUNG
// 12. Data_memory		SEUNGWON
// 13. And			YUNSUNG				Use 1bit input & output
//
// ALL connections are standard MIPS 32bit
// Use postive "RESET", "CLK" instance name for module.


module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData,BHW,ExtendSign); 

    input [31:0] Address; 	// Input Address 
    input [31:0] WriteData; // Data that needs to be written into the address 
	input [1:0] BHW;		// decide byte, half word, word
    input Clk,ExtendSign;	// 
    input MemWrite; 		// Control signal for memory write 
    input MemRead; 			// Control signal for memory read 

    output reg[31:0] ReadData; // Contents of memory location at Address

    reg 	[31:0] 	Memory[0:63];	// stack pointer initialization depends on this
      
   		always 	@(posedge Clk)		   //Memory write
   		begin
   		
			if (MemWrite==1) begin
				case (BHW)
					0: begin
						case (Address[1:0]) // Write Data를 어느위치에 write할 것인지에 대한 코드이다. 0은 뒷부분에 저장한다는 것이고(동시에 기존에 있던 데이터는 버리지 않고 가지고있음) 3은 앞부분에 저장한다는 뜻.
							0: // 1:0의 값이 0이면,
								Memory[Address>>2] = {Memory[Address>>2][31:8],WriteData[7:0]}; // 입력으로 들어온 32비트의 주소를 1/4하여 8비트, 1byte로 만든다. 8비트의 256이라는 주소값이 들어왔다 했을 때, 4를 나누면 64인데, 주소값의 1/4값인 64라는 index에 byte정보를 넣는 이유는 뭐지?
							/* 메모리를 access하는 최소의 단위는 byte라고 함. 메모리를 access하는 최소의 단위가 byte라는 뜻은 메모리의 index가 8의 배수로 naming 되어있다는 뜻.
							   따라서 입력으로 들어온 주소값을 4로 나눠서(>>2를 하여) 나눈 몫을 구하면 그것이 메모리의 index가 되는 것. */
							1:
								Memory[Address>>2] = {Memory[Address>>2][31:16],WriteData[7:0],Memory[Address>>2][7:0]};
							2:
								Memory[Address>>2] = {Memory[Address>>2][31:24],WriteData[7:0],Memory[Address>>2][15:0]};
							3:
								Memory[Address>>2] = {WriteData[7:0],Memory[Address>>2][23:0]};
						endcase
					end
					1: begin
						case (Address[1])
							0:
								Memory[Address>>2] = {Memory[Address>>2][31:16],WriteData[15:0]};
							1:
								Memory[Address>>2] = {WriteData[15:0],Memory[Address>>2][15:0]};
						endcase
					end
					2: begin
						Memory[Address>>2] = WriteData;
					end
				endcase
   				// Memory[Address>>2] = WriteData;
			end
   		end
   		
   		always @(Address or MemRead)
   		begin	
   			if	(MemRead == 1) begin
				case (BHW)
					0: begin // BYTE
						case (Address[1:0]) // read 할 때도 뒤에서부터 읽음. 
							0: begin
								if (ExtendSign && Memory[Address>>2][7])
									ReadData <= {24'hffffff,Memory[Address>>2][7:0]}; // 24'hffffff를 2진법으로 바꾸면 24개의 1이 줄지어 있는 값.
								else // 6(f가 6개라서) * 4(16진법에서 2진법으로 바꾸려면 비트를 1개에서 4개로 늘려야됨)
									ReadData <= {24'b0,Memory[Address>>2][7:0]};
							end // 일단 기본적으로 2의 보수 체계를 따라서 signed num 인듯.
							1: begin
								if (ExtendSign && Memory[Address>>2][15])
									ReadData <= {24'hffffff,Memory[Address>>2][15:8]};
								else 
									ReadData <= {24'b0,Memory[Address>>2][15:8]};
							end
							2: begin
								if (ExtendSign && Memory[Address>>2][23])
									ReadData <= {24'hffffff,Memory[Address>>2][23:16]};
								else 
									ReadData <= {24'b0,Memory[Address>>2][23:16]};
							end
							3: begin
								if (ExtendSign && Memory[Address>>2][31])
									ReadData <= {24'hffffff,Memory[Address>>2][31:24]};
								else 
									ReadData <= {24'b0,Memory[Address>>2][31:24]};
							end
						endcase
					end
					1: begin // HALFWORD
						case (Address[1])
							0: begin
								if (ExtendSign && Memory[Address>>2][15])
									ReadData <= {16'hffff,Memory[Address>>2][15:0]};
								else 
									ReadData <= {16'b0,Memory[Address>>2][15:0]};
							end	
							1: begin
								if (ExtendSign && Memory[Address>>2][31])
									ReadData <= {16'hffff,Memory[Address>>2][31:16]};
								else 
									ReadData <= {16'b0,Memory[Address>>2][31:16]};
							end
						endcase
					end
					2: begin // WORD
						ReadData <= Memory[Address>>2];
					end
				endcase
   			end else 
   				ReadData <= 32'h00000000;
					
					//$display("%h",Memory[Address]);
   		end 
   		
			initial begin
				$readmemh("test_data.txt",Memory);
			
			end
            // initialize memory by reading hex values  
   	    // Input file must have the exact name "test_data.txt" with the following format:
            // first line is number of rows for frame data (i)
            // second line is number of columns for frame data (j)
            // third line is number of rows for window data (k)
            // fourth line is number of columns for window data (l)
            // followed by i*j number of pixel values for frame data
            // followed by k*l number of pixel values for window data
		//
            // Notes: 
            // 1-make sure to adjust the "Memory" size based on your test input
            //   for 16x16 and 8x8 test case your memory  will have 4 values for size 
            //   information, 256 for frame, 64 for window (total of 324). 
            //   Memory[0:323]
            // 2-watch out for wild characters at the end of the last entry in your test file

            // insert your code here for reading from test data ! Be careful, this step is done only once 
            // right before starting the vbsme code. 
            
/* 
The given code snippet defines a Verilog module named DataMemory that implements a memory component.

The module has the following input and output ports:

Address: a 32-bit input that specifies the memory address for either read or write operation.
WriteData: a 32-bit input that contains data to be written to memory.
BHW: a 2-bit input that specifies the size of the memory access, either byte (0), half-word (1), or word (2).
Clk: a clock input.
ExtendSign: a flag input that indicates whether the signed bit of the retrieved data should be extended or not.
MemWrite: a control input signal that enables the memory write operation.
MemRead: a control input signal that enables the memory read operation.
ReadData: a 32-bit output that contains the data retrieved from memory.
The module also defines an internal Memory variable, which is a 64-word memory array, with each word being 32 bits wide.

The module consists of two always blocks. The first always block is sensitive to the positive edge of the clock input Clk and performs memory write operation if the MemWrite control signal is asserted. The memory write operation writes the data in WriteData to the specified address based on the value of BHW. The data is stored in the appropriate byte, half-word or word memory location based on the least significant bits of the address. If BHW is 0 (byte access), the appropriate byte is updated by concatenating the least significant byte of the WriteData with the corresponding bytes in memory. If BHW is 1 (half-word access), the appropriate half-word is updated by concatenating the least significant half-word of the WriteData with the corresponding half-words in memory. If BHW is 2 (word access), the entire word in memory is overwritten by WriteData.

The second always block is sensitive to changes in either the Address or MemRead signals and performs the memory read operation when MemRead is asserted. The data retrieved from memory is placed in ReadData based on the value of BHW. If BHW is 0, the appropriate byte is retrieved and concatenated with either zeros or ones (depending on the value of ExtendSign). If BHW is 1, the appropriate half-word is retrieved and concatenated with either zeros or ones. If BHW is 2, the entire word is retrieved from memory. If MemRead is not asserted, ReadData is set to 0.

The module also includes an initial block that reads in initial data from a text file named test_data.txt and initializes the memory with that data.
*/
	    		

endmodule