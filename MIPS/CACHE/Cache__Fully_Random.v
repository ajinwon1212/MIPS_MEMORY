//Fully associative Cache
//Replacement policy: First IN First OUT
//Size = 8
//Blocks = 8, Words = 1

//  0000    0000    0000    0000    0000    0000    0000    0000
//                                         tag                /00

//module cache_memory(clk,address,read,dataIn,dataOut,hit);
module Cache__Fully_Random(CLK, RESET, PC, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS, CCLK, rand_num);

    input CLK;
    input RESET;
    input [31:0] PC;
    input Access_MM; //0: Read Data from MM sig
    input [31:0] Data_MM; //Read Data from MM

    output reg HitWrite; //Hit, PCWrite, IFIDWrite
    output reg [31:0] Data_Cache;
    output reg [19:0] CNT_HIT, CNT_MISS; //Counter for Checking
//----------------------------------------
	reg [62:0] cache [7:0]; //SIZE 8
	//reg [62:0] cache [15:0]; //SIZE 16
	//reg [62:0] cache [31:0]; //SIZE 32
//----------------------------------------
    //Data: [31:0], Valid: [32], Tag: [62:33]
	output reg CCLK;

//----------------------------------------
	//SIZE 8
	output reg [2:0] rand_num; // Random number for cache line selection
	//SIZE 16
	//output reg [3:0] rand_num;
	//SIZE 32
	//output reg [4:0] rand_num;
//----------------------------------------  
    always@(posedge CLK or posedge RESET)
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
            HitWrite <= 1'd1;
	CCLK <= 1'b0; 
        end
        else begin
            if(Access_MM) begin
                // when reading from memory
//--------------------------------------------------------
//Size8
                rand_num = $urandom % 8;
//Size16
                //rand_num = $urandom % 16;
//Size32
                //rand_num = $urandom % 32;
//--------------------------------------------------------
                cache[rand_num][32] <= 1'b1; // Valid =1
                cache[rand_num][31:0] <= Data_MM; // Data
                cache[rand_num][62:33] <= PC[31:2]; // Tag
                Data_Cache <= Data_MM;
                HitWrite <= 1'b1;
            end
            else if (!Access_MM) begin
                // when not reading from memory
//----------------------------------------------------------------------------------------
//Size8
                //Cache[0]
                if(cache[0][32] == 1'b1 && PC[31:2] == cache[0][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[0][31:0];
                    CNT_HIT <= CNT_HIT+1;
                end
                //Cache[1]
                else if(cache[1][32] == 1'b1 && PC[31:2] == cache[1][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[1][31:0];
                    CNT_HIT <= CNT_HIT+1;
                end
                //Cache[2]
                else if(cache[2][32] == 1'b1 && PC[31:2] == cache[2][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[2][31:0];
                    CNT_HIT <= CNT_HIT+1;
                end
                //Cache[3]
                else if(cache[3][32] == 1'b1 && PC[31:2] == cache[3][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[3][31:0];
                    CNT_HIT <= CNT_HIT+1;
                end
                //Cache[4]
                else if(cache[4][32] == 1'b1 && PC[31:2] == cache[4][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[4][31:0];
                    CNT_HIT <= CNT_HIT+1;
                end        
                //Cache[5]
                else if(cache[5][32] == 1'b1 && PC[31:2] == cache[5][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[5][31:0];
                    CNT_HIT <= CNT_HIT+1;
                end      
                //Cache[6]
                else if(cache[6][32] == 1'b1 && PC[31:2] == cache[6][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[6][31:0];
                    CNT_HIT <= CNT_HIT+1;
                end
                //Cache[7]
                else if(cache[7][32] == 1'b1 && PC[31:2] == cache[7][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[7][31:0];
                    CNT_HIT <= CNT_HIT+1;
                end 
//----------------------------------------------------------------------------------------
//Size16
/*
                //Cache[8]
                else if(cache[8][32] == 1'b1 && PC[31:2] == cache[8][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[8][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[9]
                else if(cache[9][32] == 1'b1 && PC[31:2] == cache[9][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[9][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[10]
                else if(cache[10][32] == 1'b1 && PC[31:2] == cache[10][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[10][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[11]
                else if(cache[11][32] == 1'b1 && PC[31:2] == cache[11][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[11][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[12]
                else if(cache[12][32] == 1'b1 && PC[31:2] == cache[12][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[12][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[13]
                else if(cache[13][32] == 1'b1 && PC[31:2] == cache[13][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[13][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[14]
                else if(cache[14][32] == 1'b1 && PC[31:2] == cache[14][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[14][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[15]
                else if(cache[15][32] == 1'b1 && PC[31:2] == cache[15][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[15][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
*/
//----------------------------------------------------------------------------------------
//Size32
/*
                //Cache[16]
                else if(cache[16][32] == 1'b1 && PC[31:2] == cache[16][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[16][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[17]
                else if(cache[17][32] == 1'b1 && PC[31:2] == cache[17][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[17][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[18]
                else if(cache[18][32] == 1'b1 && PC[31:2] == cache[18][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[18][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[19]
                else if(cache[19][32] == 1'b1 && PC[31:2] == cache[19][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[19][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[20]
                else if(cache[20][32] == 1'b1 && PC[31:2] == cache[20][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[20][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[21]
                else if(cache[21][32] == 1'b1 && PC[31:2] == cache[21][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[21][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[22]
                else if(cache[22][32] == 1'b1 && PC[31:2] == cache[22][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[22][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[23]
                else if(cache[23][32] == 1'b1 && PC[31:2] == cache[23][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[23][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[24]
                else if(cache[24][32] == 1'b1 && PC[31:2] == cache[24][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[24][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[25]
                else if(cache[25][32] == 1'b1 && PC[31:2] == cache[25][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[25][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[26]
                else if(cache[26][32] == 1'b1 && PC[31:2] == cache[26][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[26][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[27]
                else if(cache[27][32] == 1'b1 && PC[31:2] == cache[27][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[27][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[28]
                else if(cache[28][32] == 1'b1 && PC[31:2] == cache[28][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[28][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[29]
                else if(cache[29][32] == 1'b1 && PC[31:2] == cache[29][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[29][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[30]
                else if(cache[30][32] == 1'b1 && PC[31:2] == cache[30][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[30][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end 
                //Cache[31]
                else if(cache[31][32] == 1'b1 && PC[31:2] == cache[31][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[31][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
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
