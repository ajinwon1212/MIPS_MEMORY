
module Cache_TB;

	reg CLK, RESET;
        reg [31:0] PC;
	//For direct
        //wire [1:0] CONT; 

	wire HitWrite;
        wire [31:0] Data_Cache;
        wire Access_MM;
        wire [31:0] Data_MM;
        wire [19:0] CNT_HIT, CNT_MISS;

	//For 2 way associative
	//wire recent1, recent2;

	//For fully associative
	wire [2:0] FIFO;

/*
        Cache_Direct Direct(
                .CLK(CLK),                      //IN
                .RESET(RESET),                  //IN
                .PC(PC),                        //IN
		.index(PC[4:2]),		//IN
                .Access_MM(Access_MM),          //IN
                .Data_MM(Data_MM),              //IN
                .HitWrite(HitWrite),            //OUT
                .Data_Cache(Data_Cache),        //OUT
                .CNT_HIT(CNT_HIT),              //OUT
                .CNT_MISS(CNT_MISS),            //OUT
		.CONT(CONT)			//OUT

        );
 */
/*
	Cache_2way two(
		.CLK(CLK),			//IN 
		.RESET(RESET),			//IN 
		.PC(PC),			//IN 
		.set(PC[3:2]),			//IN
		.Access_MM(Access_MM), 		//IN
		.Data_MM(Data_MM), 		//IN
		.HitWrite(HitWrite), 		//OUT
		.Data_Cache(Data_Cache), 	//OUT
		.CNT_HIT(CNT_HIT), 		//OUT
		.CNT_MISS(CNT_MISS),		//OUT
		.recent1(recent1),
		.recent2(recent2)
	);
*/
	Cache_Fully Fully(
		.CLK(CLK), 			//IN
		.RESET(RESET),			//IN 
		.PC(PC),			//IN 
		.Access_MM(Access_MM), 		//IN
		.Data_MM(Data_MM), 		//IN
		.HitWrite(HitWrite), 		//OUT
		.Data_Cache(Data_Cache), 	//OUT
		.CNT_HIT(CNT_HIT), 		//OUT
		.CNT_MISS(CNT_MISS),		//OUT
		.FIFO(FIFO)			//OUT
	);

        MainMemory MM(
                .CLK(CLK),                      //IN
                .RESET(RESET),                  //IN
                .PC(PC),                        //IN
                .Access_MM(Access_MM),          //IN
                .Data_MM(Data_MM)               //IN
        );
        
        cache_controller Cache_CONT(
                .CLK(CLK),                      //IN
		.RESET(RESET),			//IN
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
                #20 PC = 32'd16;
		#40 PC = 32'd0;
		#20 PC = 32'd16;
		#40 PC = 32'd20;
		#40 PC = 32'd24;
		#40 PC = 32'd28;
		#40 PC = 32'd32;
		#40 PC = 32'd36;
		#40 PC = 32'd20;
		#20 PC = 32'd4;
		#40 PC = 32'd0;
		#40 PC = 32'd8;
		
	end


endmodule
