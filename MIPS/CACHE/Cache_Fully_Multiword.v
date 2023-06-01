//Fully associative 2word Cache
//Replacement policy: Random
//Size = 8
//Blocks = 4, Words = 2


module Cache_Fully_Multiword(CLK, RESET, NOT_JUMPED, PC, block_offset, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS, CCLK, rand_num);

    input CLK;
    input RESET;
    input [31:0] PC;
	input NOT_JUMPED;
   	input block_offset;
    input Access_MM; //0: Read Data from MM sig
    input [63:0] Data_MM; //Read Data from MM

    output reg HitWrite; //Hit, PCWrite, IFIDWrite
    output reg [31:0] Data_Cache;
    output reg [19:0] CNT_HIT, CNT_MISS; //Counter for Checking
//----------------------------------------
	reg [93:0] cache [3:0]; //SIZE 8
	//reg [93:0] cache [7:0]; //SIZE 16
	//reg [93:0] cache [15:0]; //SIZE 32
//----------------------------------------
    //Data: [63:0] [31:0], Valid: [64], Tag: [93:65]
	output reg CCLK;

   	reg [31:0] Data_Cache_0,Data_Cache_1;
  	assign Data_Cache = (block_offset == 1'b0) ? Data_Cache_0 : Data_Cache_1;

	reg [31:0] PC_REG;
//----------------------------------------
	//SIZE 8
	output reg [1:0] rand_num; // Random number for cache line selection
	//SIZE 16
	//output reg [2:0] rand_num;
	//SIZE 32
	//output reg [3:0] rand_num;
//----------------------------------------  
    	always@(posedge CLK or posedge RESET)
    	begin
        	if (RESET) begin
//Size8
			cache[0] <= 94'd0;
			cache[1] <= 94'd0;
			cache[2] <= 94'd0;
			cache[3] <= 94'd0;

//Size16
/*
			cache[4] <= 94'd0;
			cache[5] <= 94'd0;
			cache[6] <= 94'd0;
			cache[7] <= 94'd0;


//size32
/*
			cache[8] <= 94'd0;
			cache[9] <= 94'd0;
			cache[10] <= 94'd0;
			cache[11] <= 94'd0;
			cache[12] <= 94'd0;
			cache[13] <= 94'd0;
			cache[14] <= 94'd0;
			cache[15] <= 94'd0;
*/
            		CNT_HIT <= 20'd0;
            		CNT_MISS <= 20'd0; 
            		HitWrite <= 1'd1;
			CCLK <= 1'b0; 
			PC_REG <= 32'd0;
        	end
        	else begin
			PC_REG <= PC;
            		if(NOT_JUMPED && Access_MM) begin
                // when reading from memory
//--------------------------------------------------------
//Size8
                		rand_num = $urandom % 4;
//Size16
                		//rand_num = $urandom % 8;
//Size32
              			//rand_num = $urandom % 16;
//--------------------------------------------------------
                		cache[rand_num][64] <= 1'b1; // Valid =1
                		cache[rand_num][63:0] <= Data_MM; // Data
                		cache[rand_num][93:65] <= PC[31:3]; // Tag
               			Data_Cache_0 <= Data_MM[63:32];
               			Data_Cache_1 <= Data_MM[31:0];
                		HitWrite <= 1'b1;
				if (PC != PC_REG) CNT_MISS <= CNT_MISS +1;
            		end
            		else begin
                // when not reading from memory
//----------------------------------------------------------------------------------------
//Size8
                //Cache[0]
                	if(cache[0][64] == 1'b1 && PC[31:3] == cache[0][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[0][63:32];
                  		Data_Cache_1 <= cache[0][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
                //Cache[1]
                	else if(cache[1][64] == 1'b1 && PC[31:3] == cache[1][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[1][63:32];
                  		Data_Cache_1 <= cache[1][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
                //Cache[2]
                	else if(cache[2][64] == 1'b1 && PC[31:3] == cache[2][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[2][63:32];
                  		Data_Cache_1 <= cache[2][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
                //Cache[3]
                	else if(cache[3][64] == 1'b1 && PC[31:3] == cache[3][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[3][63:32];
                  		Data_Cache_1 <= cache[3][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
//----------------------------------------------------------------------------------------
//Size16
/*
                //Cache[4]
                	else if(cache[4][64] == 1'b1 && PC[31:3] == cache[4][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[4][63:32];
                  		Data_Cache_1 <= cache[4][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end       
                //Cache[5]
                	else if(cache[5][64] == 1'b1 && PC[31:3] == cache[5][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[5][63:32];
                  		Data_Cache_1 <= cache[5][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end      
                //Cache[6]
                	else if(cache[6][64] == 1'b1 && PC[31:3] == cache[6][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[6][63:32];
                  		Data_Cache_1 <= cache[6][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
                //Cache[7]
                	else if(cache[7][64] == 1'b1 && PC[31:3] == cache[7][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[7][63:32];
                  		Data_Cache_1 <= cache[7][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
//----------------------------------------------------------------------------------------
//Size32
/*
                //Cache[8]
                	else if(cache[8][64] == 1'b1 && PC[31:3] == cache[8][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[8][63:32];
                  		Data_Cache_1 <= cache[8][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
                //Cache[9]
                	else if(cache[9][64] == 1'b1 && PC[31:3] == cache[9][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[9][63:32];
                  		Data_Cache_1 <= cache[9][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end 
                //Cache[10]
                	else if(cache[10][64] == 1'b1 && PC[31:3] == cache[10][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[10][63:32];
                  		Data_Cache_1 <= cache[10][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
                //Cache[11]
                	else if(cache[11][64] == 1'b1 && PC[31:3] == cache[11][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[11][63:32];
                  		Data_Cache_1 <= cache[11][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
                //Cache[12]
                	else if(cache[12][64] == 1'b1 && PC[31:3] == cache[12][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[12][63:32];
                  		Data_Cache_1 <= cache[12][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
                //Cache[13]
                	else if(cache[13][64] == 1'b1 && PC[31:3] == cache[13][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[13][63:32];
                  		Data_Cache_1 <= cache[13][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
                //Cache[14]
                	else if(cache[14][64] == 1'b1 && PC[31:3] == cache[14][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[14][63:32];
                  		Data_Cache_1 <= cache[14][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
                //Cache[15]
                	else if(cache[15][64] == 1'b1 && PC[31:3] == cache[15][93:65]) begin
                    		HitWrite <= 1'd1;
                  		Data_Cache_0 <= cache[15][63:32];
                  		Data_Cache_1 <= cache[15][31:0];
		    		if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                	end
*/
//----------------------------------------------------------------------------------------
                //ELSE
                	else begin 
                        		HitWrite <= 1'd0;
                        		CNT_MISS <= CNT_MISS +1;
                        		Data_Cache <= 32'd0;
                	end
            	end
        	end
    	end


always@(CLK) begin CCLK <= (!CCLK); end
endmodule
