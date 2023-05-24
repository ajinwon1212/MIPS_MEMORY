//Direct mapped Multiword Cache
//Size = 8
//Blocks = 4, Words = 2

//  0000    0000    0000    0000    0000    0000    0000    0000
//                                         tag        /index /00
//                                                            /valid
//Change valid bit as 0 when processing Data_Cache

//module cache_memory(clk,address,read,dataIn,dataOut,hit);
module Cache_Direct_Multiword(CLK, RESET, PC, index, Access_MM, Data_MM, HitWrite, Data_Cache, CNT_HIT, CNT_MISS
,CONT);

	input CLK;
	input RESET;
	input [31:0] PC;
	input [1:0] index;
	input block_offset;
	input Access_MM; //0: Read Data from MM sig
	input [63:0] Data_MM; //Read Data from MM

	output reg HitWrite; //Hit, PCWrite, IFIDWrite
	output reg [31:0] Data_Cache;
	output reg [19:0] CNT_HIT, CNT_MISS; //Counter for Checking
	//output [60:0] CACHE;
	output reg [1:0] CONT;

	//output reg [2:0] index;
	reg [91:0] cache [3:0]; 
	//Data: [31:0], Valid: [32], Tag: [59:33]
 	//wire CACHE;

	always@(posedge CLK, posedge RESET)
	begin
		//index <= PC[4:3];
		//block_offset <= PC[2];
		if (RESET) begin
			//index <= 3'd0;
			cache[0] <= 92'd0;
			cache[1] <= 92'd0;
			cache[2] <= 92'd0;
			cache[3] <= 92'd0;
			CNT_HIT <= 20'd0;
			CNT_MISS <= 20'd0;
			HitWrite <= 1'b1; 
        	end
        	else begin
			if(Access_MM) begin
				cache[index][32] <= 1'b1; //Valid =1
				cache[index][31:0] <= Data_MM;
				cache[index][59:33] <= PC[31:5]; //Tag
				Data_Cache <= Data_MM;
				HitWrite <= 1'b1;
				CONT <= 2'd0;
			end
			else if (!Access_MM) begin
				if(PC[31:5] == cache[index][59:33]) begin
					if (cache[index][32] == 1'b1) begin
						HitWrite <= 1'b1;
						Data_Cache <= cache[index][31:0];
						CNT_HIT <= CNT_HIT+1;
						CONT <= 2'd1;
					end
					else begin
						HitWrite <= 1'b0;
						CNT_MISS <= CNT_MISS +1;
						Data_Cache <= 32'd0;  
						CONT <= 2'd2;                      
					end
				end
                		else begin 
					HitWrite <= 1'b0;
					CNT_MISS <= CNT_MISS +1;
					Data_Cache <= 32'd0;
					CONT <= 2'd3;
               			end
			end
		end
	end

endmodule
