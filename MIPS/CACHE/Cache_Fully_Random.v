//Fully associative Cache
//Replacement policy: First IN First OUT
//Size = 8
//Blocks = 8, Words = 1

//  0000    0000    0000    0000    0000    0000    0000    0000
//                                         tag                /00

//module cache_memory(clk,address,read,dataIn,dataOut,hit);
module Cache__Fully_Random(CLK, RESET, PC, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS, rand_num);

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

    integer i;
    reg hit;
    output reg [2:0] rand_num; // Random number for cache line selection
    
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
            HitWrite <= 1'd0;
        end
        else begin
            if(Access_MM) begin
                // when reading from memory
                rand_num = $urandom % 8;
                cache[rand_num][32] <= 1'b1; // Valid =1
                cache[rand_num][31:0] <= Data_MM; // Data
                cache[rand_num][62:33] <= PC[31:2]; // Tag
                Data_Cache <= Data_MM;
                HitWrite <= 1'b1;
            end
            else if (!Access_MM) begin
                // when not reading from memory
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
