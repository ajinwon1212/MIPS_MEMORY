/*
2 way associative cache
Replacement policy: replace not recent used > need 'recent' bit

<set>       PC            PC
 00     [~ 00 00]      [~ 00 00]
 01     [~ 01 00]      [~ 01 00]
 10     [~ 10 00]      [~ 10 00]
 11     [~ 11 00]      [~ 11 00]

*/
module Cache_Fully(CLK, RESET, PC, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS);
        input CLK;
        input RESET;
        input [31:0] PC;
        input Access_MM;
        input [31:0] Data_MM;
        output reg HitWrite;
        output reg [31:0] Data_Cache;
        output reg [19:0] CNT_HIT, CNT_MISS;
        
        reg [1:0] set;
        reg [60:0] cache1 [3:0]; 
        reg [60:0] cache2 [3:0];
        //Data: [31:0], Valid: [32], Tag: [59:33], Recent: [60]
        
        always@(posedge CLK) begin
                set <= PC[3:2];
                if (!RESET) begin
                        set <= 2'd0;
                        cache1[0] <= 61'd0;
                        cache1[1] <= 61'd0;
                        cache1[2] <= 61'd0;
                        cache1[3] <= 61'd0;
                        cache2[0] <= 61'd0;
                        cache2[1] <= 61'd0;
                        cache2[2] <= 61'd0;
                        cache2[3] <= 61'd0;
                end
                else begin
                        if(Access_MM) begin
                                ;
                        end
                        else if(!Access_MM) begin
                                if(PC[31:5] == cache1[set][59:33]) begin
                                        if(cache1[set][32] == 1'b1) begin
                                           HitWrite <= 1'b1;
                                                Data_Cache <= cache1[set][31:0];
                                                CNT_HIT <= CNT_HIT + 1;
                                        end
                                        else begin
                                                HitWrite <= 1'b0;
                                                CNT_MISS <= CNT_MISS + 1;
                                                Data_Cache <= 32'd0;
                                        end
                                end
                                else if(PC[31:5] == cache2[set][59:33]) begin
                                        
                                end
                                else begin
                                        
                                end
                        end
                end

        end
  
  
endmodule
