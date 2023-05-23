//Fully associative Cache
//Replacement policy: First IN First OUT
//Size = 8
//Blocks = 8, Words = 1

//  0000    0000    0000    0000    0000    0000    0000    0000
//                                         tag                /00

//module cache_memory(clk,address,read,dataIn,dataOut,hit);
module Cache_Fully(CLK, RESET, PC, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS);

    input CLK;
    input RESET;
    input [31:0] PC;
    input Access_MM; //0: Read Data from MM sig
    input [31:0] Data_MM; //Read Data from MM

    output reg HitWrite; //Hit, PCWrite, IFIDWrite
    output reg [31:0] Data_Cache;
    output reg [19:0] CNT_HIT, CNT_MISS; //Counter for Checking

    reg [59:0] cache [7:0];
    //Data: [31:0], Valid: [32], Tag: [59:33]
    reg [2:0] FIFO; //First in First out
 
    always@(posedge clk)
    begin
        if (!RESET) begin
            index <= 3'd0;
            cache[0] <= 60'd0;
            cache[1] <= 60'd0;
            cache[2] <= 60'd0;
            cache[3] <= 60'd0;
            cache[4] <= 60'd0;
            cache[5] <= 60'd0;
            cache[6] <= 60'd0;
            cache[7] <= 60'd0;
            CNT_HIT <= 20'd0;
            CNT_MISS <= 20'd0; 
            FIFO <= 3'd0;
        end
        else begin
            FIFO <= FIFO;
            if(Access_MM) begin
                cache[FIFO][32] <= 1'b1; //Valid =1
                cache[FIFO][31:0] <= Data_MM;
                cache[FIFO][59:33] <= PC[31:5]; //Tag
                Data_Cache <= Data_MM;
                HitWrite <= 1'b1;
                FIFO <= FIFO + 1; //Fill cache[0] > [1] > ... > [7] > [0] > ...
            end
            else if (!Access_MM) begin
                //Cache[0]
                        if(PC[31:5] == cache[0][59:33]) begin
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
                         else if(PC[31:5] == cache[1][59:33]) begin
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
                         else if(PC[31:5] == cache[2][59:33]) begin
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
                         else if(PC[31:5] == cache[3][59:33]) begin
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
                         else if(PC[31:5] == cache[4][59:33]) begin
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
                       else if(PC[31:5] == cache[5][59:33]) begin
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
                      else if(PC[31:5] == cache[6][59:33]) begin
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
                    else if(PC[31:5] == cache[7][59:33]) begin
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
