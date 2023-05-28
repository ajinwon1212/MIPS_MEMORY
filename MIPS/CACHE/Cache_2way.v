/*
2 way associative cache
Replacement policy: replace not recent used > need 'recent' bit

<set>       PC            PC
 00     [~ 00 00]      [~ 00 00]
 01     [~ 01 00]      [~ 01 00]
 10     [~ 10 00]      [~ 10 00]
 11     [~ 11 00]      [~ 11 00]

*/
/*
module Cache_2way(CLK, RESET, PC, set, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS
,recent1, recent2);
        input CLK;
        input RESET;
        input [31:0] PC;
	input [1:0] set;
        input Access_MM;
        input [31:0] Data_MM;
        output reg HitWrite;
        output reg [31:0] Data_Cache;
        output reg [19:0] CNT_HIT, CNT_MISS;

	output reg recent1, recent2;
        
        //reg [1:0] set;
        reg [61:0] cache1 [3:0]; 
        reg [61:0] cache2 [3:0];
        //Data: [31:0], Valid: [32], Tag: [60:33], Recent: [61]
        
        always@(posedge CLK or posedge RESET) begin
                //set <= PC[3:2];
                if (RESET) begin
                        //set <= 2'd0;
                        cache1[0] <= 62'd0;
                        cache1[1] <= 62'd0;
                        cache1[2] <= 62'd0;
                        cache1[3] <= 62'd0;
                        cache2[0] <= 62'd0;
                        cache2[1] <= 62'd0;
                        cache2[2] <= 62'd0;
                        cache2[3] <= 62'd0;
			CNT_HIT <= 20'd0;
			CNT_MISS <= 20'd0;
			HitWrite <= 1'b1; 
                end
                else begin
                        //cache1 <= cache1; //@
                        //cache2 <= cache2; //@
                        
                        if(Access_MM) begin
                                if(cache1[set][61] == 1'b0) begin //Cache1 recently not used
                                        cache1[set][32] <= 1'b1; //Valid     
                                        cache1[set][31:0] <= Data_MM;
                                        cache1[set][61] <= 1'b1; //Recent
                                        cache2[set][61] <= 1'b0; //Recent
					recent1 <= 1'b1;
					recent2 <= 1'b0;
                                        cache1[set][60:33] <= PC[31:4]; //Tag
                                        Data_Cache <= Data_MM;
                                        HitWrite <= 1'b1;                                                     
                                end
                                else if(cache2[set][61] == 1'b0) begin //Cache2 recently not used
                                        cache2[set][32] <= 1'b1; //Valid     
                                        cache2[set][31:0] <= Data_MM;
                                        cache2[set][61] <= 1'b1; //Recent
                                        cache1[set][61] <= 1'b0; //Recent
					recent1 <= 1'b0;
					recent2 <= 1'b1;
                                        cache2[set][60:33] <= PC[31:4]; //Tag
                                        Data_Cache <= Data_MM;
                                        HitWrite <= 1'b1;         
                                end
                        end
                        else if(!Access_MM) begin
                                if(PC[31:4] == cache1[set][60:33]) begin
                                        if(cache1[set][32] == 1'b1) begin
                                           HitWrite <= 1'b1;
                                                Data_Cache <= cache1[set][31:0];
                                                cache1[set][61] <= 1'b1;
                                                cache2[set][61] <= 1'b0;
						recent1 <= 1'b1;
						recent2 <= 1'b0;
                                                CNT_HIT <= CNT_HIT + 1;
                                        end
                                        else begin
                                                HitWrite <= 1'b0;
                                                CNT_MISS <= CNT_MISS + 1;
                                                Data_Cache <= 32'd0;
                                        end
                                end
                                else if(PC[31:4] == cache2[set][60:33]) begin
                                        if(cache2[set][32] == 1'b1) begin
                                           HitWrite <= 1'b1;
                                                Data_Cache <= cache2[set][31:0];
                                                cache1[set][61] <= 1'b0;
                                                cache2[set][61] <= 1'b1;
						recent1 <= 1'b0;
						recent2 <= 1'b1;
                                                CNT_HIT <= CNT_HIT + 1;
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
                end

        end
  
  
endmodule
*/

module Cache_2way(CLK, RESET, PC, set, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS
,CCLK,recent1, recent2);
        input CLK;
        input RESET;
        input [31:0] PC;
//----------------------------------------
	input [1:0] set; //size8
	//input [2:0] set; //size16
	//input [3:0] set; //size32
//----------------------------------------
        input Access_MM;
        input [31:0] Data_MM;
        output reg HitWrite;
        output reg [31:0] Data_Cache;
        output reg [19:0] CNT_HIT, CNT_MISS;
	output reg CCLK;
	output reg recent1, recent2;
        
//----------------------------------------
	//size8
        reg [61:0] cache1 [3:0]; 
        reg [61:0] cache2 [3:0];
	//size16
        //reg [61:0] cache1 [7:0]; 
        //reg [61:0] cache2 [7:0];
	//size32
        //reg [61:0] cache1 [15:0]; 
        //reg [61:0] cache2 [15:0];
//----------------------------------------
        //Data: [31:0], Valid: [32], Tag: [60:33], Recent: [61]
        
        always@(posedge CLK or posedge RESET) begin
                if (RESET) begin
//size8
                        cache1[0] <= 62'd0;
                        cache1[1] <= 62'd0;
                        cache1[2] <= 62'd0;
                        cache1[3] <= 62'd0;
                        cache2[0] <= 62'd0;
                        cache2[1] <= 62'd0;
                        cache2[2] <= 62'd0;
                        cache2[3] <= 62'd0;
//size16
/*
                        cache1[4] <= 62'd0;
                        cache1[5] <= 62'd0;
                        cache1[6] <= 62'd0;
                        cache1[7] <= 62'd0;
                        cache2[4] <= 62'd0;
                        cache2[5] <= 62'd0;
                        cache2[6] <= 62'd0;
                        cache2[7] <= 62'd0;
*/
//size32
/*
                        cache1[8] <= 62'd0;
                        cache1[9] <= 62'd0;
                        cache1[10] <= 62'd0;
                        cache1[11] <= 62'd0;
                        cache2[8] <= 62'd0;
                        cache2[9] <= 62'd0;
                        cache2[10] <= 62'd0;
                        cache2[11] <= 62'd0;
                        cache1[12] <= 62'd0;
                        cache1[13] <= 62'd0;
                        cache1[14] <= 62'd0;
                        cache1[15] <= 62'd0;
                        cache2[12] <= 62'd0;
                        cache2[13] <= 62'd0;
                        cache2[14] <= 62'd0;
                        cache2[15] <= 62'd0;
*/
			CNT_HIT <= 20'd0;
			CNT_MISS <= 20'd0;
			HitWrite <= 1'b1; 
			CCLK <= 1'b0;
                end
                else begin                      
                        if(Access_MM) begin
                                if(cache1[set][61] == 1'b0) begin //Cache1 recently not used
                                        cache1[set][32] <= 1'b1; //Valid     
                                        cache1[set][31:0] <= Data_MM;
                                        cache1[set][61] <= 1'b1; //Recent
                                        cache2[set][61] <= 1'b0; //Recent
					recent1 <= 1'b1;
					recent2 <= 1'b0;
//----------------------------------------------------------------------------------------
					//Size8
                                        cache1[set][60:33] <= PC[31:4]; //Tag
					//Size16
                                        //cache1[set][60:33] <= PC[31:5]; //Tag
					//Size32
                                        //cache1[set][60:33] <= PC[31:6]; //Tag
//----------------------------------------------------------------------------------------
                                        Data_Cache <= Data_MM;
                                        HitWrite <= 1'b1;                                                     
                                end
                                else if(cache2[set][61] == 1'b0) begin //Cache2 recently not used
                                        cache2[set][32] <= 1'b1; //Valid     
                                        cache2[set][31:0] <= Data_MM;
                                        cache2[set][61] <= 1'b1; //Recent
                                        cache1[set][61] <= 1'b0; //Recent
					recent1 <= 1'b0;
					recent2 <= 1'b1;
//----------------------------------------------------------------------------------------
					//Size8
                                        cache2[set][60:33] <= PC[31:4]; //Tag
					//Size16
                                        //cache2[set][60:33] <= PC[31:5]; //Tag					
					//Size32
                                        //cache2[set][60:33] <= PC[31:6]; //Tag
//---------------------------------------------------------------------------------------- 
                                        Data_Cache <= Data_MM; 
                                        HitWrite <= 1'b1;         
                                end
                        end
                        else if(!Access_MM) begin
                                if(cache1[set][32] == 1'b1) begin
//---------------------------------------------------------------------------------------- 
					//Size8
                                        if(PC[31:4] == cache1[set][60:33]) begin
					//Size16
                                        //if(PC[31:5] == cache1[set][60:33]) begin
					//Size32
                                        //if(PC[31:6] == cache1[set][60:33]) begin
//---------------------------------------------------------------------------------------- 
                                           HitWrite <= 1'b1;
                                                Data_Cache <= cache1[set][31:0];
                                                cache1[set][61] <= 1'b1;
                                                cache2[set][61] <= 1'b0;
						recent1 <= 1'b1;
						recent2 <= 1'b0;
                                                CNT_HIT <= CNT_HIT + 1;
                                        end
					else if(cache2[set][32] == 1'b1) begin
//---------------------------------------------------------------------------------------- 
						//Size8
						if(PC[31:4] == cache2[set][60:33]) begin
						//Size16
						//if(PC[31:5] == cache2[set][60:33]) begin
						//Size32
						//if(PC[31:6] == cache2[set][60:33]) begin
//---------------------------------------------------------------------------------------- 
							HitWrite <= 1'b1;
                                  	              	Data_Cache <= cache2[set][31:0];
                                  	              	cache1[set][61] <= 1'b0;
                                   	             	cache2[set][61] <= 1'b1;
							recent1 <= 1'b0;
							recent2 <= 1'b1;
                                       	        	CNT_HIT <= CNT_HIT + 1;
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
				else if(cache2[set][32] == 1'b1) begin
//---------------------------------------------------------------------------------------- 
					//Size8
					if(PC[31:4] == cache2[set][60:33]) begin
					//Size16
					//if(PC[31:5] == cache2[set][60:33]) begin
					//Size32
					//if(PC[31:6] == cache2[set][60:33]) begin
//---------------------------------------------------------------------------------------- 
						HitWrite <= 1'b1;
                                                Data_Cache <= cache2[set][31:0];
                                                cache1[set][61] <= 1'b0;
                                                cache2[set][61] <= 1'b1;
						recent1 <= 1'b0;
						recent2 <= 1'b1;
                                                CNT_HIT <= CNT_HIT + 1;
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
                end

        end
  always@(CLK) begin CCLK <= (!CCLK); end
  
endmodule
