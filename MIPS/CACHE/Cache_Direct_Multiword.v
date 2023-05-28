//Direct mapped Multiword Cache
//Size = 8
//Blocks = 4, Words = 2

//  0000    0000    0000    0000    0000    0000    0000    0000
//                                         tag        /index /00
//                                                            /valid
//Change valid bit as 0 when processing Data_Cache

//module cache_memory(clk,address,read,dataIn,dataOut,hit);
module Cache_Direct_Multiword(CLK, RESET, PC, index, block_offset, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS
,CCLK ,CONT);

	input CLK;
	input RESET;
	input [31:0] PC;
//-----------------------------------------------
	input [1:0] index; //Size8
	//input [2:0] index; //Size16
	//input [3:0] index; //Size32
//-----------------------------------------------
	input block_offset;
	input Access_MM; //0: Read Data from MM sig
	input [63:0] Data_MM; //Read Data from MM

	output reg HitWrite; //Hit, PCWrite, IFIDWrite
	output reg [31:0] Data_Cache;
	output reg [19:0] CNT_HIT, CNT_MISS; //Counter for Checking
	output reg CCLK;
	output reg [1:0] CONT;
//-----------------------------------------------
	reg [91:0] cache [3:0]; //Size8
	//reg [91:0] cache [7:0]; //Size16
	//reg [91:0] cache [15:0]; //Size32
//-----------------------------------------------
	reg [31:0] Data_Cache_0,Data_Cache_1;
	assign Data_Cache = (block_offset == 1'b0) ? Data_Cache_0 : Data_Cache_1;

	always@(posedge CLK, posedge RESET)
	begin
		if (RESET) begin
//Size8
			cache[0] <= 92'd0;
			cache[1] <= 92'd0;
			cache[2] <= 92'd0;
			cache[3] <= 92'd0;
//Size16
/*
			cache[4] <= 92'd0;
			cache[5] <= 92'd0;
			cache[6] <= 92'd0;
			cache[7] <= 92'd0;
*/
//size32
/*
			cache[8] <= 92'd0;
			cache[9] <= 92'd0;
			cache[10] <= 92'd0;
			cache[11] <= 92'd0;
			cache[12] <= 92'd0;
			cache[13] <= 92'd0;
			cache[14] <= 92'd0;
			cache[15] <= 92'd0;
*/
			CNT_HIT <= 20'd0;
			CNT_MISS <= 20'd0;
			HitWrite <= 1'b1; 
			CCLK <= 1'b0; 
        	end
        	else begin
			if(Access_MM) begin
				cache[index][64] <= 1'b1; //Valid =1
				cache[index][63:0] <= Data_MM;
//----------------------------------------------------------------------------------------
				//Size8
				cache[index][91:65] <= PC[31:5]; //Tag
				//Size16
				//cache[index][91:65] <= PC[31:6]; //Tag
				//Size32
				//cache[index][91:65] <= PC[31:7]; //Tag
//----------------------------------------------------------------------------------------
				Data_Cache_0 <= Data_MM[63:32];
				Data_Cache_1 <= Data_MM[31:0];
				HitWrite <= 1'b1;
				CONT <= 2'd0;
			end
			else if (!Access_MM) begin
				if(cache[index][64] == 1'b0) begin
					HitWrite <= 1'b0;
					CNT_MISS <= CNT_MISS +1;
					Data_Cache_0 <= 32'd0;
					Data_Cache_1 <= 32'd0;  
					CONT <= 2'd2; 
				end
				else begin
//----------------------------------------------------------------------------------------
					//Size8
					if (PC[31:5] == cache[index][91:65]) begin
					//Size16
					//if (PC[31:6] == cache[index][91:65]) begin
					//Size32
					//if (PC[31:7] == cache[index][91:65]) begin
//----------------------------------------------------------------------------------------
						HitWrite <= 1'b1;
						CNT_HIT <= CNT_HIT+1;
						CONT <= 2'd1;
						//if (block_offset == 1'b0) 
						//	Data_Cache <= cache[index][63:32];
						//else
						//	Data_Cache <= cache[index][31:0];
						Data_Cache_0 <= cache[index][63:32];
						Data_Cache_1 <= cache[index][31:0];
					end
					else begin
						HitWrite <= 1'b0;
						CNT_MISS <= CNT_MISS +1;
						Data_Cache_0 <= 32'd0;
						Data_Cache_1 <= 32'd0;
						CONT <= 2'd3;            
					end
				end
                		
			end
		end
	end
always@(CLK) begin CCLK <= (!CCLK); end
endmodule
