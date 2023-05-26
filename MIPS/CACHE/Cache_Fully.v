/*
//Fully associative Cache
//Replacement policy: First IN First OUT
//Size = 8
//Blocks = 8, Words = 1

//  0000    0000    0000    0000    0000    0000    0000    0000
//                                         tag                /00

//module cache_memory(clk,address,read,dataIn,dataOut,hit);
module Cache_Fully(CLK, RESET, PC, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS
,FIFO);

    input CLK;
    input RESET;
    input [31:0] PC;
    input Access_MM; //0: Read Data from MM sig
    input [31:0] Data_MM; //Read Data from MM

    output reg HitWrite; //Hit, PCWrite, IFIDWrite
    output reg [31:0] Data_Cache;
    output reg [19:0] CNT_HIT, CNT_MISS; //Counter for Checking

    reg [62:0] cache [7:0];
    //Data: [31:0], Valid: [32], Tag: [62:33]
    output reg [2:0] FIFO; //First in First out
 
    always@(posedge CLK or posedge RESET)
    begin
        if (RESET) begin
            cache[0] <= 63'd0;
            cache[1] <= 63'd0;
            cache[2] <= 63'd0;
            cache[3] <= 63'd0;
            cache[4] <= 63'd0;
            cache[5] <= 63'd0;
            cache[6] <= 63'd0;
            cache[7] <= 63'd0;
            CNT_HIT <= 20'd0;
            CNT_MISS <= 20'd0; 
            FIFO <= 3'd0;
        end
        else begin
            FIFO <= FIFO;
            if(Access_MM) begin
                cache[FIFO][32] <= 1'b1; //Valid =1
                cache[FIFO][31:0] <= Data_MM;
                cache[FIFO][62:33] <= PC[31:2]; //Tag
                Data_Cache <= Data_MM;
                HitWrite <= 1'b1;
                FIFO <= FIFO + 1; //Fill cache[0] > [1] > ... > [7] > [0] > ...
            end
            else if (!Access_MM) begin
                //Cache[0]
                        if(PC[31:2] == cache[0][62:33]) begin
                            if (cache[1][32] == 1'b1) begin
                                        HitWrite <= 1;
                                        Data_Cache <= cache[0][31:0];
                                        CNT_HIT <= CNT_HIT+1;
                                end
                             else begin 
                                HitWrite <= 0;
                                CNT_MISS <= CNT_MISS +1;
                                Data_Cache <= 32'd0;
                                end
                         end
                //Cache[1]
                         else if(PC[31:2] == cache[1][62:33]) begin
                             if (cache[1][32] == 1'b1) begin
                                        HitWrite <= 1;
                                        Data_Cache <= cache[1][31:0];
                                        CNT_HIT <= CNT_HIT+1;
                                end
                             else begin 
                                HitWrite <= 0;
                                CNT_MISS <= CNT_MISS +1;
                                Data_Cache <= 32'd0;
                                end
                         end
                //Cache[2]
                         else if(PC[31:2] == cache[2][62:33]) begin
                            if (cache[2][32] == 1'b1) begin
                                        HitWrite <= 1;
                                        Data_Cache <= cache[2][31:0];
                                        CNT_HIT <= CNT_HIT+1;
                                end
                             else begin 
                                HitWrite <= 0;
                                CNT_MISS <= CNT_MISS +1;
                                Data_Cache <= 32'd0;
                                end
                         end
                //Cache[3]
                         else if(PC[31:2] == cache[3][62:33]) begin
                            if (cache[3][32] == 1'b1) begin
                                        HitWrite <= 1;
                                        Data_Cache <= cache[3][31:0];
                                        CNT_HIT <= CNT_HIT+1;
                                end
                             else begin 
                                HitWrite <= 0;
                                CNT_MISS <= CNT_MISS +1;
                                Data_Cache <= 32'd0;
                                end
                         end
                //Cache[4]
                         else if(PC[31:2] == cache[4][62:33]) begin
                             if (cache[4][32] == 1'b1) begin
                                        HitWrite <= 1;
                                         Data_Cache <= cache[4][31:0];
                                        CNT_HIT <= CNT_HIT+1;
                                end
                            else begin 
                                HitWrite <= 0;
                                CNT_MISS <= CNT_MISS +1;
                                Data_Cache <= 32'd0;
                                end
                       end           
                //Cache[5]
                       else if(PC[31:2] == cache[5][62:33]) begin
                           if (cache[5][32] == 1'b1) begin
                                        HitWrite <= 1;
                                        Data_Cache <= cache[5][31:0];
                                        CNT_HIT <= CNT_HIT+1;
                                end
                            else begin 
                                HitWrite <= 0;
                                CNT_MISS <= CNT_MISS +1;
                                Data_Cache <= 32'd0;
                                end
                      end       
                //Cache[6]
                      else if(PC[31:2] == cache[6][62:33]) begin
                            if (cache[6][32] == 1'b1) begin
                                        HitWrite <= 1;
                                        Data_Cache <= cache[6][31:0];
                                        CNT_HIT <= CNT_HIT+1;
                                end
                         else begin 
                                HitWrite <= 0;
                                CNT_MISS <= CNT_MISS +1;
                                Data_Cache <= 32'd0;
                                end
                    end      
                //Cache[7]
                    else if(PC[31:2] == cache[7][62:33]) begin
                        if (cache[7][32] == 1'b1) begin
                                        HitWrite <= 1;
                                        Data_Cache <= cache[7][31:0];
                                        CNT_HIT <= CNT_HIT+1;
                                end
                         else begin 
                                HitWrite <= 0;
                                CNT_MISS <= CNT_MISS +1;
                                Data_Cache <= 32'd0;
                                end
                    end      
                 //ELSE
                    else begin 
                         HitWrite <= 0;
                         CNT_MISS <= CNT_MISS +1;
                         Data_Cache <= 32'd0;
                    end
            end
        end
    end

endmodule
*/
//Fully associative Cache
//Replacement policy: First IN First OUT
//Size = 8
//Blocks = 8, Words = 1

//  0000    0000    0000    0000    0000    0000    0000    0000
//                                         tag                /00

module Cache_Fully(CLK, RESET, PC, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS, FIFO);

    input CLK;
    input RESET;
    input [31:0] PC;
    input Access_MM; //0: Read Data from MM sig
    input [31:0] Data_MM; //Read Data from MM

    output reg HitWrite; //Hit, PCWrite, IFIDWrite
    output reg [31:0] Data_Cache;
    output reg [19:0] CNT_HIT, CNT_MISS; //Counter for Checking

    reg [62:0] cache [7:0]; //Data: [31:0], Valid: [32], Tag: [62:33]
    output reg [2:0] FIFO; //First in First out
    //reg hit_flag; // Flag to indicate cache hit

    always @(posedge CLK or posedge RESET)
    begin
        if (RESET) begin
            // initialize the cache to zeros
            cache[0] <= 63'd0;
            cache[1] <= 63'd0;
            cache[2] <= 63'd0;
            cache[3] <= 63'd0;
            cache[4] <= 63'd0;
            cache[5] <= 63'd0;
            cache[6] <= 63'd0;
            cache[7] <= 63'd0;
            CNT_HIT <= 20'd0;
            CNT_MISS <= 20'd0; 
            FIFO <= 3'd0;
            HitWrite <= 1'd0;
        end
        else begin
            FIFO <= FIFO;
            //hit_flag <= 0;
            if(Access_MM) begin
                // when reading from memory
                cache[FIFO][32] <= 1'b1; //Valid =1
                cache[FIFO][31:0] <= Data_MM;
                cache[FIFO][62:33] <= PC[31:2]; //Tag
                Data_Cache <= Data_MM;
                HitWrite <= 1'b1;
                FIFO <= FIFO + 1; //Fill cache[0] > [1] > ... > [7] > [0] > ...
            end
            else if (!Access_MM) begin
                // when not reading from memory
                //Cache[0]
                if(cache[0][32] == 1'b1 && PC[31:2] == cache[0][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[0][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end
                //Cache[1]
                else if(cache[1][32] == 1'b1 && PC[31:2] == cache[1][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[1][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end
                //Cache[2]
                else if(cache[2][32] == 1'b1 && PC[31:2] == cache[2][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[2][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end
                //Cache[3]
                else if(cache[3][32] == 1'b1 && PC[31:2] == cache[3][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[3][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end
                //Cache[4]
                else if(cache[4][32] == 1'b1 && PC[31:2] == cache[4][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[4][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end        
                //Cache[5]
                else if(cache[5][32] == 1'b1 && PC[31:2] == cache[5][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[5][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end      
                //Cache[6]
                else if(cache[6][32] == 1'b1 && PC[31:2] == cache[6][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[6][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end
                //Cache[7]
                else if(cache[7][32] == 1'b1 && PC[31:2] == cache[7][62:33]) begin
                    HitWrite <= 1'd1;
                    Data_Cache <= cache[7][31:0];
                    CNT_HIT <= CNT_HIT+1;
                    //hit_flag <= 1;
                end     
                //ELSE
                else begin 
                        HitWrite <= 1'd0;
                        CNT_MISS <= CNT_MISS +1;
                        Data_Cache <= 32'd0;
                end
            end
        end
    end

endmodule
