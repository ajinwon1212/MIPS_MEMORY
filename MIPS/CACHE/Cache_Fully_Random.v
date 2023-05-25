//Fully associative Cache
//Replacement policy: First IN First OUT
//Size = 8
//Blocks = 8, Words = 1

//  0000    0000    0000    0000    0000    0000    0000    0000
//                                         tag                /00

//module cache_memory(clk,address,read,dataIn,dataOut,hit);
module Cache__Fully_Random(CLK, RESET, PC, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS);

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
    reg [2:0] rand_num; // Random number for cache line selection
    
    always@(posedge CLK or posedge RESET)
    begin
        if (RESET) begin
            for (i = 0; i < 8; i = i + 1) begin
                cache[i] <= 63'd0;
            end
            CNT_HIT <= 20'd0;
            CNT_MISS <= 20'd0; 
        end
        else begin
            hit = 0;
            for(i = 0; i < 8; i = i + 1) begin
                if(cache[i][32] == 1'b1 && PC[31:2] == cache[i][62:33]) begin
                    hit = 1;
                    Data_Cache <= cache[i][31:0];
                    CNT_HIT <= CNT_HIT + 1;
                    // break;
                end
            end
            
            if(!hit && Access_MM) begin
                rand_num = $urandom % 8;
                cache[rand_num][32] <= 1'b1; // Valid =1
                cache[rand_num][31:0] <= Data_MM; // Data
                cache[rand_num][62:33] <= PC[31:2]; // Tag
                Data_Cache <= Data_MM;
                CNT_MISS <= CNT_MISS + 1;
            end
        end
    end

    always @ (hit)
    begin 
        HitWrite <= hit;
    end

endmodule