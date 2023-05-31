module Cache_2way_Multiword(CLK, RESET, PC, set, block_offset, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS
,CONT, recent1, recent2);

   input CLK;
   input RESET;
   input [31:0] PC;
   input [1:0] set;
   input block_offset;
   input Access_MM; //0: Read Data from MM sig
   input [63:0] Data_MM; //Read Data from MM

   output reg HitWrite; //Hit, PCWrite, IFIDWrite
   output reg [31:0] Data_Cache;
   output reg [19:0] CNT_HIT, CNT_MISS; //Counter for Checking

   output reg [1:0] CONT;
   output reg recent1, recent2;

   reg [92:0] cache1 [3:0]; 
   reg [92:0] cache2 [3:0];

   always@(posedge CLK, posedge RESET)
   begin
      if (RESET) begin
         cache1[0] <= 93'd0;
         cache1[1] <= 93'd0;
         cache1[2] <= 93'd0;
         cache1[3] <= 93'd0;
         cache2[0] <= 93'd0;
         cache2[1] <= 93'd0;
         cache2[2] <= 93'd0;
         cache2[3] <= 93'd0;
         CNT_HIT <= 20'd0;
         CNT_MISS <= 20'd0;
         HitWrite <= 1'b1; 
           end
           else begin
         if(Access_MM) begin
                                if(cache1[set][93] == 1'b0) begin //Cache1 recently not used
                                        cache1[set][64] <= 1'b1; //Valid     
                                        cache1[set][63:0] <= Data_MM;
                                        cache1[set][93] <= 1'b1; //Recent
                                        cache2[set][93] <= 1'b0; //Recent
               recent1 <= 1'b1;
               recent2 <= 1'b0;
                                        cache1[set][91:65] <= PC[31:4]; //Tag
                                        Data_Cache <= Data_MM;
                                        HitWrite <= 1'b1;                                                     
                                end
                                else if(cache2[set][61] == 1'b0) begin //Cache2 recently not used
                                        cache2[set][64] <= 1'b1; //Valid     
                                        cache2[set][63:0] <= Data_MM;
                                        cache2[set][93] <= 1'b1; //Recent
                                        cache1[set][93] <= 1'b0; //Recent
               recent1 <= 1'b0;
               recent2 <= 1'b1;
                                        cache2[set][91:65] <= PC[31:4]; //Tag
                                        Data_Cache <= Data_MM;
                                        HitWrite <= 1'b1;         
                                end
         end
         else if (!Access_MM) begin
                                if(cache1[set][64] == 1'b1) begin
                                        if(PC[31:4] == cache1[set][91:65]) begin
                                              HitWrite <= 1'b1;
                                                cache1[set][93] <= 1'b1;
                                                cache2[set][93] <= 1'b0;
                  recent1 <= 1'b1;
                  recent2 <= 1'b0;
                                                CNT_HIT <= CNT_HIT + 1;
                  if (block_offset == 1'b0) 
                     Data_Cache <= cache1[set][63:32];
                  else
                     Data_Cache <= cache1[set][31:0];
                                        end
               else if(cache2[set][64] == 1'b1) begin
                  if(PC[31:4] == cache2[set][91:65]) begin
                  HitWrite <= 1'b1;
                                                cache1[set][93] <= 1'b0;
                                                cache2[set][93] <= 1'b1;
                  recent1 <= 1'b0;
                  recent2 <= 1'b1;
                                                CNT_HIT <= CNT_HIT + 1;
                  if (block_offset == 1'b0) 
                     Data_Cache <= cache2[set][63:32];
                  else
                     Data_Cache <= cache2[set][31:0];
                  end
               end
            end
            else if(cache2[set][64] == 1'b1) begin
                                        if(PC[31:4] == cache2[set][91:65]) begin
                  HitWrite <= 1'b1;
                                                cache1[set][93] <= 1'b0;
                                                cache2[set][93] <= 1'b1;
                  recent1 <= 1'b0;
                  recent2 <= 1'b1;
                                                CNT_HIT <= CNT_HIT + 1;
                  if (block_offset == 1'b0) 
                     Data_Cache <= cache2[set][63:32];
                  else
                     Data_Cache <= cache2[set][31:0];
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
