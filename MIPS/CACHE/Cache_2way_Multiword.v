module Cache_2way_Multiword(CLK, RESET, NOT_JUMPED, PC, set, block_offset, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS
,CONT, CCLK, recent1, recent2);

	input CLK;
	input RESET;
	input [31:0] PC;
	input NOT_JUMPED;
//-----------------------------------------------
	input set; //Size8
	//input [1:0] set; //Size16
	//input [2:0] set; //Size32
//-----------------------------------------------
   	input block_offset;
	input Access_MM; //0: Read Data from MM sig
   	input [63:0] Data_MM; //Read Data from MM

	output reg HitWrite; //Hit, PCWrite, IFIDWrite
   	output reg [31:0] Data_Cache;
   	output reg [19:0] CNT_HIT, CNT_MISS; //Counter for Checking

   	output reg [1:0] CONT;
   	output reg CCLK;
   	output reg recent1, recent2;

//-----------------------------------------------
   	reg [93:0] cache1 [1:0]; //Size8
   	reg [93:0] cache2 [1:0]; //Size8
   	//reg [93:0] cache1 [3:0]; //Size16
   	//reg [93:0] cache2 [3:0]; //Size16
   	//reg [93:0] cache1 [7:0]; //Size32
   	//reg [93:0] cache2 [7:0]; //Size32
//-----------------------------------------------
	reg [31:0] PC_REG;

   	reg [31:0] Data_Cache_0,Data_Cache_1;
   	assign Data_Cache = (block_offset == 1'b0) ? Data_Cache_0 : Data_Cache_1;

   	always@(posedge CLK, posedge RESET)
   	begin
      		if (RESET) begin
//Size8
         		cache1[0] <= 94'd0;
         		cache1[1] <= 94'd0;
        		cache2[0] <= 94'd0;
         		cache2[1] <= 94'd0;
//Size16
/*
        		cache1[2] <= 94'd0;
        		cache1[3] <= 94'd0;
         		cache2[2] <= 94'd0;
         		cache2[3] <= 94'd0;
//*/
//size32
/*
                        cache1[4] <= 94'd0;
                        cache1[5] <= 94'd0;
                        cache1[6] <= 94'd0;
                        cache1[7] <= 94'd0;
                        cache2[4] <= 94'd0;
                        cache2[5] <= 94'd0;
                        cache2[6] <= 94'd0;
                        cache2[7] <= 94'd0;
*/
         		CNT_HIT <= 20'd0;
         		CNT_MISS <= 20'd0;
         		HitWrite <= 1'b1; 
         		CCLK <= 1'b0;
			PC_REG <= 32'd0;
           	end
		
           	else begin
			PC_REG <= PC; 
         		if(NOT_JUMPED && Access_MM) begin
                                if(cache1[set][93] == 1'b0) begin //Cache1 recently not used
                                        cache1[set][64] <= 1'b1; //Valid     
                                        cache1[set][63:0] <= Data_MM;
                                        cache1[set][93] <= 1'b1; //Recent
                                        cache2[set][93] <= 1'b0; //Recent
               				recent1 <= 1'b1;
               				recent2 <= 1'b0;
//----------------------------------------------------------------------------------------
				//Size8
                                        cache1[set][92:65] <= PC[31:4]; //Tag
				//Size16
                                        //cache1[set][92:65] <= PC[31:5]; //Tag
				//Size32
					//cache1[set][92:65] <= PC[31:6]; //Tag
//----------------------------------------------------------------------------------------
               				Data_Cache_0 <= Data_MM[63:32];
               				Data_Cache_1 <= Data_MM[31:0];
                                        HitWrite <= 1'b1;  
					if (PC != PC_REG) CNT_MISS <= CNT_MISS +1;                                                   
                                end
                                else if(cache2[set][93] == 1'b0) begin //Cache2 recently not used
                                        cache2[set][64] <= 1'b1; //Valid     
                                        cache2[set][63:0] <= Data_MM;
                                        cache2[set][93] <= 1'b1; //Recent
                                        cache1[set][93] <= 1'b0; //Recent
               				recent1 <= 1'b0;
               				recent2 <= 1'b1;
//----------------------------------------------------------------------------------------
				//Size8
                                        cache2[set][92:65] <= PC[31:4]; //Tag
				//Size16
                                        //cache2[set][92:65] <= PC[31:5]; //Tag
				//Size32
					//cache2[set][92:65] <= PC[31:6]; //Tag
//----------------------------------------------------------------------------------------
               				Data_Cache_0 <= Data_MM[63:32];
               				Data_Cache_1 <= Data_MM[31:0];
                                        HitWrite <= 1'b1;     
					if (PC != PC_REG) CNT_MISS <= CNT_MISS +1;    
                                end
         		end
         		else begin
                                if(cache1[set][64] == 1'b1) begin
//----------------------------------------------------------------------------------------
					//Size8
                                        if(PC[31:4] == cache1[set][92:65]) begin	
					//Size16
                                        //if(PC[31:5] == cache1[set][92:65]) begin	
					//Size32
                                        //if(PC[31:6] == cache1[set][92:65]) begin	
//----------------------------------------------------------------------------------------
						HitWrite <= 1'b1;
                                                cache1[set][93] <= 1'b1;
                                                cache2[set][93] <= 1'b0;
                  				recent1 <= 1'b1;
                  				recent2 <= 1'b0;
						if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                                                //CNT_HIT <= CNT_HIT + 1;
                  				Data_Cache_0 <= cache1[set][63:32];
                  				Data_Cache_1 <= cache1[set][31:0];
                                        end
               				else if(cache2[set][64] == 1'b1) begin
//----------------------------------------------------------------------------------------
						//Size8
                  				if(PC[31:4] == cache2[set][92:65]) begin
						//Size16
                  				//if(PC[31:5] == cache2[set][92:65]) begin
						//Size32
                  				//if(PC[31:6] == cache2[set][92:65]) begin
//----------------------------------------------------------------------------------------
                  				HitWrite <= 1'b1;
                                                cache1[set][93] <= 1'b0;
                                                cache2[set][93] <= 1'b1;
                  				recent1 <= 1'b0;
                  				recent2 <= 1'b1;
						if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                                                //CNT_HIT <= CNT_HIT + 1;
                  				Data_Cache_0 <= cache2[set][63:32];
                  				Data_Cache_1 <= cache2[set][31:0];
                  				end
                                        	else begin
                                                	HitWrite <= 1'b0;
                                                	CNT_MISS <= CNT_MISS + 1;
                                                	Data_Cache <= 32'd0;
                                        	end  
					end
                                        else begin
                                                 HitWrite <= 1'b0;
                                                 CNT_MISS <= CNT_MISS + 1;
                                                 Data_Cache <= 32'd0;
                                        end
               			end
            			else if(cache2[set][64] == 1'b1) begin
//----------------------------------------------------------------------------------------
					//Size8
                                	if(PC[31:4] == cache2[set][92:65]) begin
					//Size16
                                	//if(PC[31:5] == cache2[set][92:65]) begin
					//Size32
                               		//if(PC[31:6] == cache2[set][92:65]) begin
//----------------------------------------------------------------------------------------
                  				HitWrite <= 1'b1;
                                        	cache1[set][93] <= 1'b0;
                                        	cache2[set][93] <= 1'b1;
                  				recent1 <= 1'b0;
                  				recent2 <= 1'b1;
						if (PC != PC_REG) CNT_HIT <= CNT_HIT +1;
                                        	//CNT_HIT <= CNT_HIT + 1;
                  				Data_Cache_0 <= cache2[set][63:32];
                  				Data_Cache_1 <= cache2[set][31:0];
               				end
                                	else begin
                                        	HitWrite <= 1'b0;
                                        	CNT_MISS <= CNT_MISS + 1;
                                        	Data_Cache <= 32'd0;
                                	end  
                        	end
                        	else begin
                                	HitWrite <= 1'b0;
                                	CNT_MISS <= CNT_MISS + 1;
                                	Data_Cache <= 32'd0;
                        	end   
         		end
   			//end
		end
	end
  always@(CLK) begin CCLK <= (!CCLK); end
endmodule