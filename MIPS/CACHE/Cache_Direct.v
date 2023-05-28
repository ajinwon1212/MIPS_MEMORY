//Direct mapped Cache
//Size = 8
//Blocks = 8, Words = 1

//  0000    0000    0000    0000    0000    0000    0000    0000
//                                         tag        /index /00
//                                                            /valid
//Change valid bit as 0 when processing Data_Cache

//module cache_memory(clk,address,read,dataIn,dataOut,hit);
module Cache_Direct(CLK, RESET, PC, index, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS
,CCLK,CONT);

	input CLK;
	input RESET;
	input [31:0] PC;
//----------------------------------------
	input [2:0] index; //SIZE 8
	//input [3:0] index; //SIZE 16
	//input [4:0] index; //SIZE 32
//----------------------------------------
	input Access_MM; //0: Read Data from MM sig
	input [31:0] Data_MM; //Read Data from MM

	output reg HitWrite; //Hit, PCWrite, IFIDWrite
	output reg [31:0] Data_Cache;
	output reg [19:0] CNT_HIT, CNT_MISS; //Counter for Checking
	output reg CCLK;
	output reg [1:0] CONT;
//----------------------------------------
	reg [59:0] cache [7:0]; //SIZE 8
	//reg [59:0] cache [15:0]; //SIZE 16
	//reg [59:0] cache [31:0]; //SIZE 32
//----------------------------------------
	//Data: [31:0], Valid: [32], Tag: [59:33]

	always@(posedge CLK, posedge RESET)
	begin
		if (RESET) begin
//Size8
			cache[0] <= 60'd0;
			cache[1] <= 60'd0;
			cache[2] <= 60'd0;
			cache[3] <= 60'd0;
			cache[4] <= 60'd0;
			cache[5] <= 60'd0;
			cache[6] <= 60'd0;
			cache[7] <= 60'd0;
//Size16
/*
			cache[8] <= 60'd0;
			cache[9] <= 60'd0;
			cache[10] <= 60'd0;
			cache[11] <= 60'd0;
			cache[12] <= 60'd0;
			cache[13] <= 60'd0;
			cache[14] <= 60'd0;
			cache[15] <= 60'd0;
*/
//size32
/*
			cache[16] <= 60'd0;
			cache[17] <= 60'd0;
			cache[18] <= 60'd0;
			cache[19] <= 60'd0;
			cache[20] <= 60'd0;
			cache[21] <= 60'd0;
			cache[22] <= 60'd0;
			cache[23] <= 60'd0;
			cache[24] <= 60'd0;
			cache[25] <= 60'd0;
			cache[26] <= 60'd0;
			cache[27] <= 60'd0;
			cache[27] <= 60'd0;
			cache[28] <= 60'd0;
			cache[29] <= 60'd0;
			cache[30] <= 60'd0;
			cache[31] <= 60'd0;
*/
			CNT_HIT <= 20'd0;
			CNT_MISS <= 20'd0;
			HitWrite <= 1'b1;
			CCLK <= 1'b0; 
        	end
        	else begin
			if(Access_MM) begin
				cache[index][32] <= 1'b1; //Valid =1
				cache[index][31:0] <= Data_MM;
//----------------------------------------------------------------------------------------
				//Size8
				cache[index][59:33] <= PC[31:5]; //Tag
				//Size16
				//cache[index][59:33] <= PC[31:6]; //Tag
				//Size32
				//cache[index][59:33] <= PC[31:7]; //Tag
//----------------------------------------------------------------------------------------
				Data_Cache <= Data_MM;
				HitWrite <= 1'b1;
				CONT <= 2'd0;
			end
			else if (!Access_MM) begin
				if(cache[index][32] == 1'b0) begin
					HitWrite <= 1'b0;
					CNT_MISS <= CNT_MISS +1;
					Data_Cache <= 32'd0;  
					CONT <= 2'd2;
				end
				else begin
					//size8
					if (PC[31:5] == cache[index][59:33]) begin
					//size16
					//if (PC[31:6] == cache[index][59:33]) begin
					//size32
					//if (PC[31:7] == cache[index][59:33]) begin
						HitWrite <= 1'b1;
						Data_Cache <= cache[index][31:0];
						CNT_HIT <= CNT_HIT+1;
						CONT <= 2'd1;
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

always@(CLK) begin CCLK <= (!CCLK); end

endmodule

