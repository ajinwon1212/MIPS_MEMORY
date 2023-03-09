
module Register_module (clk, rst, Regwrite, WBID_RegDst_out, MEMWB_RegWrite_out, RegDst, ALUSrc, WBID_mux_out, //IFID_PCnext_out, 
IDEX_opcode_in, IDEX_rs_in, IDEX_rt_in, IDEX_rd_in, IDEX_shamt_in, IDEX_funct_in, IDEX_offset_in, MEMWB_destination_out,
IDEX_readata1_in, IDEX_readata2_in, IDEX_sign_extend_in, IDEX_SWDATA_in);// test); IDEX_PCnext_in, 
        
	input clk, rst, Regwrite,  WBID_RegDst_out, MEMWB_RegWrite_out, RegDst, ALUSrc;
	//input [31:0] IFID_PCnext_out;
	input [31:0] WBID_mux_out;
	input [5:0] IDEX_opcode_in, IDEX_funct_in;
	input [4:0] IDEX_rs_in, IDEX_rt_in, IDEX_rd_in, IDEX_shamt_in, MEMWB_destination_out;
	input [15:0] IDEX_offset_in;
	
	//output reg test;
	output [31:0] IDEX_readata1_in, IDEX_readata2_in, IDEX_sign_extend_in, IDEX_SWDATA_in;//IDEX_PCnext_in, 
	reg [31:0] Registers[31:0];
	//reg [4:0] write_register;
	
	
	assign IDEX_readata1_in = Registers[IDEX_rs_in];
	assign IDEX_readata2_in = (ALUSrc == 1'b1) ? IDEX_offset_in : Registers[IDEX_rt_in];
	assign IDEX_sign_extend_in = IDEX_offset_in;
	assign IDEX_SWDATA_in = Registers[IDEX_rt_in];
	
	
	always @(negedge rst or posedge clk) begin
		if (rst == 1'b0) begin 
		Registers[0] <= 32'b000000_00000_00000_00000_00000_000000;    // 0 
		Registers[1] <= 32'b000000_00000_00000_00000_00000_000001;    // 1
    	  	Registers[2] <= 32'b000000_00000_00000_00000_00000_000000;    // $v0
     	 	Registers[3] <= 32'b000000_00000_00000_00000_00000_000000;    // &v1
		Registers[4] <= 32'b000000_00000_00000_00000_00000_000000;    // $a0
		Registers[5] <= 32'b000000_00000_00000_00000_00000_000000;    // $a1
		Registers[6] <= 32'b000000_00000_00000_00000_00000_000000;    // $a2
		Registers[7] <= 32'b000000_00000_00000_00000_00000_000000;    // $a3
		Registers[8] <= 32'b000000_00000_00000_00000_00000_000000;    // $t0
		Registers[9] <= 32'b000000_00000_00000_00000_00000_000001;    // $t1
		Registers[10] <= 32'b000000_00000_00000_00000_00000_000010;   // $t2
		Registers[11] <= 32'b000000_00000_00000_00000_00000_000011;   // $t3
		Registers[12] <= 32'b000000_00000_00000_00000_00000_000100;   // $t4
		Registers[13] <= 32'b000000_00000_00000_00000_00000_000101;   // $t5
		Registers[14] <= 32'b000000_00000_00000_00000_00000_000110;   // $t6
		Registers[15] <= 32'b000000_00000_00000_00000_00000_000111;   // $t7
		Registers[16] <= 32'b000000_00000_00000_00000_00000_000000;   // $s0
		Registers[17] <= 32'b000000_00000_00000_00000_00000_000001;   // $s1
		Registers[18] <= 32'b000000_00000_00000_00000_00000_000010;   // $s2
		Registers[19] <= 32'b000000_00000_00000_00000_00000_000011;   // $s3
		Registers[20] <= 32'b000000_00000_00000_00000_00000_000100;   // $s4
		Registers[21] <= 32'b000000_00000_00000_00000_00000_000101;   // $s5
		Registers[22] <= 32'b000000_00000_00000_00000_00000_000110;   // $s6
		Registers[23] <= 32'b000000_00000_00000_00000_00000_000111;   // $s7
		Registers[24] <= 32'b000000_00000_00000_00000_00000_001000;   // $t8
		Registers[25] <= 32'b000000_00000_00000_00000_00000_001001;   // $t9
		Registers[26] <= 32'b000000_00000_00000_00000_00000_001000;   // $s8 
		Registers[27] <= 32'b000000_00000_00000_00000_00000_001001;   // $s9
		Registers[28] <= 32'b000000_00000_00000_00000_00000_000000;   // $gp
		Registers[29] <= 32'b000000_00000_00000_00000_00000_000000;   // &sp
		Registers[30] <= 32'b000000_00000_00000_00000_00000_000000;   // &fp
		Registers[31] <= 32'b000000_00000_00000_00000_00000_000000;   // $ra
		end
		else begin
			Registers[0]	<=	Registers[0]	;
			Registers[1]	<=	Registers[1]	;
    	  		Registers[2]	<=	Registers[2]	;
     	 		Registers[3]	<=	Registers[3]	;
			Registers[4]	<=	Registers[4]	;
			Registers[5]	<=	Registers[5]	;
			Registers[6]	<=	Registers[6]	;
			Registers[7]	<=	Registers[7]	;
			Registers[8]	<=	Registers[8]	;
			Registers[9]	<=	Registers[9]	;
			Registers[10]	<=	Registers[10]	;
			Registers[11]	<=	Registers[11]	;
			Registers[12]	<=	Registers[12]	;
			Registers[13]	<=	Registers[13]	;
			Registers[14]	<=	Registers[14]	;
			Registers[15]	<=	Registers[15]	;
			Registers[16]	<=	Registers[16]	;
			Registers[17]	<=	Registers[17]	;
			Registers[18]	<=	Registers[18]	;
			Registers[19]	<=	Registers[19]	;
			Registers[20]	<=	Registers[20]	;
			Registers[21]	<=	Registers[21]	;
			Registers[22]	<=	Registers[22]	;
			Registers[23]	<=	Registers[23]	;
			Registers[24]	<=	Registers[24]	;
			Registers[25]	<=	Registers[25]	;
			Registers[26]	<=	Registers[26]	;
			Registers[27]	<=	Registers[27]	;
			Registers[28]	<=	Registers[28]	;
			Registers[29]	<=	Registers[29]	;
			Registers[30]	<=	Registers[30]	;
			Registers[31]	<=	Registers[31]	;
			//update - if write enable
			if (MEMWB_RegWrite_out == 1'b1) begin
				Registers[MEMWB_destination_out] <= WBID_mux_out;
			end
		end
	end
endmodule
	/*
	
	
	//read
	always @(rst, IFID_PCnext_out,IDEX_opcode_in, IDEX_funct_in, IDEX_rs_in, IDEX_rt_in, IDEX_rd_in, IDEX_shamt_in, IDEX_offset_in, ALUSrc)
	begin
	if(rst==0) begin //fixed to logic 0
		IDEX_PCnext_in = 32'b0;
		IDEX_readata1_in = 32'b0;
		IDEX_readata2_in = 32'b0;
		IDEX_sign_extend_in = 32'b0;
	end
	else begin
		IDEX_PCnext_in = IFID_PCnext_out;
		IDEX_readata1_in = Registers[IDEX_rs_in];
		IDEX_sign_extend_in = 32'b0 + IDEX_offset_in;
		IDEX_SWDATA_in = Registers[IDEX_rt_in]; 
		if(ALUSrc==0) begin
			IDEX_readata2_in <= Registers[IDEX_rt_in];
		end
	        else if(ALUSrc==1) begin
			IDEX_readata2_in <= 32'b0 + IDEX_offset_in;
		end
	end
	end

	//write
	always @(MEMWB_RegWrite_out, MEMWB_destination_out, WBID_mux_out)
	begin
		if (MEMWB_RegWrite_out == 1'b1) begin 
			Registers[MEMWB_destination_out] <= WBID_mux_out; 
			test <= 1'b1;
		end
	end

	//register
	always @(posedge rst)
	begin
		Registers[0] <= 32'b000000_00000_00000_00000_00000_000000;    // 0 
		Registers[1] <= 32'b000000_00000_00000_00000_00000_000001;    // 1
    	  	Registers[2] <= 32'b000000_00000_00000_00000_00000_000000;    // $v0
     	 	Registers[3] <= 32'b000000_00000_00000_00000_00000_000000;    // &v1
		Registers[4] <= 32'b000000_00000_00000_00000_00000_000000;    // $a0
		Registers[5] <= 32'b000000_00000_00000_00000_00000_000000;    // $a1
		Registers[6] <= 32'b000000_00000_00000_00000_00000_000000;    // $a2
		Registers[7] <= 32'b000000_00000_00000_00000_00000_000000;    // $a3
		Registers[8] <= 32'b000000_00000_00000_00000_00000_000000;    // $t0
		Registers[9] <= 32'b000000_00000_00000_00000_00000_000001;    // $t1
		Registers[10] <= 32'b000000_00000_00000_00000_00000_000010;   // $t2
		Registers[11] <= 32'b000000_00000_00000_00000_00000_000011;   // $t3
		Registers[12] <= 32'b000000_00000_00000_00000_00000_000100;   // $t4
		Registers[13] <= 32'b000000_00000_00000_00000_00000_000101;   // $t5
		Registers[14] <= 32'b000000_00000_00000_00000_00000_000110;   // $t6
		Registers[15] <= 32'b000000_00000_00000_00000_00000_000111;   // $t7
		Registers[16] <= 32'b000000_00000_00000_00000_00000_000000;   // $s0
		Registers[17] <= 32'b000000_00000_00000_00000_00000_000001;   // $s1
		Registers[18] <= 32'b000000_00000_00000_00000_00000_000010;   // $s2
		Registers[19] <= 32'b000000_00000_00000_00000_00000_000011;   // $s3
		Registers[20] <= 32'b000000_00000_00000_00000_00000_000100;   // $s4
		Registers[21] <= 32'b000000_00000_00000_00000_00000_000101;   // $s5
		Registers[22] <= 32'b000000_00000_00000_00000_00000_000110;   // $s6
		Registers[23] <= 32'b000000_00000_00000_00000_00000_000111;   // $s7
		Registers[24] <= 32'b000000_00000_00000_00000_00000_001000;   // $t8
		Registers[25] <= 32'b000000_00000_00000_00000_00000_001001;   // $t9
		Registers[26] <= 32'b000000_00000_00000_00000_00000_001000;   // $s8 
		Registers[27] <= 32'b000000_00000_00000_00000_00000_001001;   // $s9
		Registers[28] <= 32'b000000_00000_00000_00000_00000_000000;   // $gp
		Registers[29] <= 32'b000000_00000_00000_00000_00000_000000;   // &sp
		Registers[30] <= 32'b000000_00000_00000_00000_00000_000000;   // &fp
		Registers[31] <= 32'b000000_00000_00000_00000_00000_000000;   // $ra
	end
endmodule
*/