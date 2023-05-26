
module Cache_TB;

	reg CLK, RESET;
        reg [31:0] PC;

	wire HitWrite_1, HitWrite_2, HitWrite_3, HitWrite_4, HitWrite_5, HitWrite_6;
        wire [31:0] Data_Cache_1, Data_Cache_2, Data_Cache_3, Data_Cache_4, Data_Cache_5, Data_Cache_6;
        wire Access_MM_1, Access_MM_2, Access_MM_3, Access_MM_4, Access_MM_5, Access_MM_6;
	wire Access_MM;
        wire [31:0] Data_MM;
	wire [63:0] Data_MM_MULT;
        wire [19:0] CNT_HIT_1, CNT_MISS_1;
	wire [19:0] CNT_HIT_2, CNT_MISS_2;
	wire [19:0] CNT_HIT_3, CNT_MISS_3;
	wire [19:0] CNT_HIT_4, CNT_MISS_4;
        wire [19:0] CNT_HIT_5, CNT_MISS_5;
	wire [19:0] CNT_HIT_6, CNT_MISS_6;
	wire w1,w2,w3;

	//---------------------------------------------
	//For direct 1word 
        //wire [1:0] CONT; 
	//wire CCLK;
	
	////wire [2:0] INDEX;
	////wire VALID;
	//---------------------------------------------
	//For direct 2word

	//---------------------------------------------
	//For 2 way associative RECENT
	//wire recent1, recent2;
	//---------------------------------------------
	//For 2 way associative RANDOM 

	//---------------------------------------------
	//For fully associative FIFO
	//wire [2:0] FIFO;
	//---------------------------------------------
	//For fully associative RANDOM 

	//---------------------------------------------
        Cache_Direct Direct(
                .CLK(CLK),                     //IN
                .RESET(RESET),                  //IN
                .PC(PC),                        //IN
		.index(PC[4:2]),		//IN
                .Access_MM(Access_MM_1),          //IN
                .Data_MM(Data_MM),              //IN
                .HitWrite(HitWrite_1),            //OUT
                .Data_Cache(Data_Cache_1),  	//OUT
                .CNT_HIT(CNT_HIT_1),              //OUT
                .CNT_MISS(CNT_MISS_1),            //OUT
		.CCLK(),			//OUT
		.CONT()				//OUT
		//.INDEX(INDEX),
		//.VALID(VALID)
        );
	Cache_Direct_Multiword Direct_MULT(
                .CLK(CLK),                     //IN
                .RESET(RESET),                  //IN
                .PC(PC),                        //IN
		.index(PC[4:3]),		//IN
		.block_offset(PC[2]),
                .Access_MM(Access_MM_2),          //IN
                .Data_MM(Data_MM_MULT),              //IN
                .HitWrite(HitWrite_2),            //OUT
                .Data_Cache(Data_Cache_2),  	//OUT
                .CNT_HIT(CNT_HIT_2),              //OUT
                .CNT_MISS(CNT_MISS_2),            //OUT	
		.CONT()
	);

	Cache_2way twoway(
		.CLK(CLK),			//IN 
		.RESET(RESET),			//IN 
		.PC(PC),			//IN 
		.set(PC[3:2]),			//IN
		.Access_MM(Access_MM_3), 		//IN
		.Data_MM(Data_MM), 		//IN
		.HitWrite(HitWrite_3), 		//OUT
		.Data_Cache(Data_Cache_3), 	//OUT
		.CNT_HIT(CNT_HIT_3), 		//OUT
		.CNT_MISS(CNT_MISS_3),		//OUT
		.recent1(),
		.recent2()
	);
	Cache_2way_Random twoway_random(
		.CLK(CLK),			//IN 
		.RESET(RESET),			//IN 
		.PC(PC),			//IN 
		.set(PC[3:2]),			//IN
		.Access_MM(Access_MM_4), 		//IN
		.Data_MM(Data_MM), 		//IN
		.HitWrite(HitWrite_4), 		//OUT
		.Data_Cache(Data_Cache_4), 	//OUT
		.CNT_HIT(CNT_HIT_4), 		//OUT
		.CNT_MISS(CNT_MISS_4)		//OUT
	);
    
	Cache_Fully Fully(
		.CLK(CLK), 			//IN
		.RESET(RESET),			//IN 
		.PC(PC),			//IN 
		.Access_MM(Access_MM_5), 		//IN
		.Data_MM(Data_MM), 		//IN
		.HitWrite(HitWrite_5), 		//OUT
		.Data_Cache(Data_Cache_5), 	//OUT
		.CNT_HIT(CNT_HIT_5), 		//OUT
		.CNT_MISS(CNT_MISS_5),		//OUT
		.FIFO()				//OUT
	);

	Cache__Fully_Random Fully_random(
		.CLK(CLK), 			//IN
		.RESET(RESET),			//IN 
		.PC(PC),			//IN 
		.Access_MM(Access_MM_6), 		//IN
		.Data_MM(Data_MM), 		//IN
		.HitWrite(HitWrite_6), 		//OUT
		.Data_Cache(Data_Cache_6), 	//OUT
		.CNT_HIT(CNT_HIT_6), 		//OUT
		.CNT_MISS(CNT_MISS_6),		//OUT
		.rand_num()
	);



	or_gate OR1(
		.a(Access_MM_1),
		.b(Access_MM_3),
		.out(w1)
	);
	or_gate OR2(
		.a(Access_MM_4),
		.b(Access_MM_5),
		.out(w2)
	);
	or_gate OR3(
		.a(Access_MM_6),
		.b(w1),
		.out(w3)
	);
	or_gate OR4(
		.a(w2),
		.b(w3),
		.out(Access_MM)
	);

        MainMemory MM(
                .CLK(CLK),                      //IN
                .RESET(RESET),                  //IN
                .PC(PC),                        //IN
                .Access_MM(Access_MM),          //IN
                .Data_MM(Data_MM)               //IN
        );

        MainMemory_Multiword MM_MULT(
                .CLK(CLK),                      //IN
                .RESET(RESET),                  //IN
                .PC(PC),                        //IN
                .Access_MM(Access_MM_2),          //IN
                .Data_MM(Data_MM_MULT)               //OUT
        );
        
        cache_controller Cache_CONT1(
                .CLK(CLK),                      //IN
		.RESET(RESET),			//IN
                .HitWrite(HitWrite_1),            //IN
                .Access_MM(Access_MM_1)           //OUT
        );  
        cache_controller Cache_CONT2(
                .CLK(CLK),                      //IN
		.RESET(RESET),			//IN
                .HitWrite(HitWrite_2),            //IN
                .Access_MM(Access_MM_2)           //OUT
        );
        cache_controller Cache_CONT3(
                .CLK(CLK),                      //IN
		.RESET(RESET),			//IN
                .HitWrite(HitWrite_3),            //IN
                .Access_MM(Access_MM_3)           //OUT
        );
        cache_controller Cache_CONT4(
                .CLK(CLK),                      //IN
		.RESET(RESET),			//IN
                .HitWrite(HitWrite_4),            //IN
                .Access_MM(Access_MM_4)           //OUT
        );
        cache_controller Cache_CONT5(
                .CLK(CLK),                      //IN
		.RESET(RESET),			//IN
                .HitWrite(HitWrite_5),            //IN
                .Access_MM(Access_MM_5)           //OUT
        );
        cache_controller Cache_CONT6(
                .CLK(CLK),                      //IN
		.RESET(RESET),			//IN
                .HitWrite(HitWrite_6),            //IN
                .Access_MM(Access_MM_6)           //OUT
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
                #40 PC = 32'd8;
                #40 PC = 32'd12;
                #40 PC = 32'd0;
                #40 PC = 32'd16;
		#40 PC = 32'd0;
		#40 PC = 32'd16;
		#40 PC = 32'd20;
		#40 PC = 32'd24;
		#40 PC = 32'd28;
		#40 PC = 32'd32;
		#40 PC = 32'd36;
		#40 PC = 32'd20;
		#40 PC = 32'd4;
		#40 PC = 32'd0;
		#40 PC = 32'd8;
		
	end


endmodule
