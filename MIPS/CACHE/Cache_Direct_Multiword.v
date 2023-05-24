//Direct mapped Multiword Cache
//Size = 8
//Blocks = 4, Words = 2

//  0000    0000    0000    0000    0000    0000    0000    0000
//                                         tag        /index /00
//                                                            /valid
//Change valid bit as 0 when processing Data_Cache

//module cache_memory(clk,address,read,dataIn,dataOut,hit);
module Cache_Direct_Multiword(CLK, RESET, PC, index, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS
,CONT);

	input CLK;
	input RESET;
	input [31:0] PC;
	input [1:0] index;
	input block_offset
	input Access_MM; //0: Read Data from MM sig
	input [63:0] Data_MM; //Read Data from MM

	output reg HitWrite; //Hit, PCWrite, IFIDWrite
	output reg [31:0] Data_Cache;
	output reg [19:0] CNT_HIT, CNT_MISS; //Counter for Checking

	output reg [1:0] CONT;

	reg [91:0] cache [3:0]; 


	always@(posedge CLK, posedge RESET)
	begin
		if (RESET) begin
			cache[0] <= 92'd0;
			cache[1] <= 92'd0;
			cache[2] <= 92'd0;
			cache[3] <= 92'd0;
			CNT_HIT <= 20'd0;
			CNT_MISS <= 20'd0;
			HitWrite <= 1'b1; 
        	end
        	else begin
			if(Access_MM) begin
				cache[index][64] <= 1'b1; //Valid =1
				cache[index][63:0] <= Data_MM;
				cache[index][91:65] <= PC[31:5]; //Tag
				Data_Cache <= Data_MM;
				HitWrite <= 1'b1;
				CONT <= 2'd0;
			end
			else if (!Access_MM) begin
				if(cache[index][64] == 1'b0) begin
					HitWrite <= 1'b0;
					CNT_MISS <= CNT_MISS +1;
					Data_Cache <= 32'd0;  
					CONT <= 2'd2; 
				end
				else begin
					if (PC[31:5] == cache[index][91:65]) begin
						HitWrite <= 1'b1;
						CNT_HIT <= CNT_HIT+1;
						CONT <= 2'd1;
						if (block_offset == 1'b0) 
							Data_Cache <= cache[index][63:32];
						else
							Data_Cache <= cache[index][31:0];
					end
					else begin
						HitWrite <= 1'b0;
						CNT_MISS <= CNT_MISS +1;
						Data_Cache <= 32'd0;  
						CONT <= 2'd3;            
					end
				end
                		
			end
		end
	end

endmodule
