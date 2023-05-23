`timescale 250ps / 250ps  

module Cache_TB;

	reg CLK, RESET;
        reg [31:0] PC;
        wire HitWrite;
        wire [31:0] Data_Cache;
        wire Access_MM;
        wire [31:0] Data_MM;
        wire [19:0] CNT_HIT, CNT_MISS;
        
        Cache_Direct(
                .CLK(CLK),                      //IN
                .RESET(RESET),                  //IN
                .PC(PC),                        //IN
                .Access_MM(Access_MM),          //IN
                .Data_MM(Data_MM),              //IN
                .HitWrite(HitWrite),            //OUT
                .Data_Cache(Data_Cache),        //OUT
                .CNT_HIT(CNT_HIT),              //OUT
                .CNT_MISS(CNT_MISS)             //OUT
        );
        
        MainMemory (
                .CLK(CLK),                      //IN
                .RESET(RESET),                  //IN
                .PC(PC),                        //IN
                .Access_MM(Access_MM),          //IN
                .Data_MM(Data_MM)               //IN
        );
        
        cache_controller(
                .CLK(CLK),                      //IN
                .HitWrite(HitWrite),            //IN
                .Access_MM(Access_MM)           //OUT
        );        

	initial
	begin
		CLK = 1'b0;
		forever
		begin
			#10 CLK = !CLK;
		end
	end

	initial
	begin
		RESET = 1'b1;
		#30 RESET = 1'b0; PC = 32'd0; 
                #40 PC = 32'd4;
                #40 PC = 32'd0;
                #20 PC = 32'd8;
                #40 PC = 32'd12;
                #40 PC = 32'd0;
                
	end


endmodule
