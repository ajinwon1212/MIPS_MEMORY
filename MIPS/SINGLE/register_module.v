
module Register_module (clk, rst, rs, rt, rd, shamt, offset, outdata, Regwrite, RegDst, readata1, readata2, sign_extend, shift);
	input clk;
	input rst; 
	input [4:0] rs, rt, rd, shamt;
	input [15:0] offset;
	input [31:0] outdata;
	input Regwrite, RegDst;
	output [31:0] readata1, readata2, sign_extend;
	output [4:0] shift;
	
	wire [4:0] write_register;
	reg [31:0] Registers[31:0];
	assign write_register = RegDst ? rd : rt;
	
	assign readata1 = Registers[rs];
	assign readata2 = Registers[rt];
	assign sign_extend = {{16{offset[15]}}, offset};
	assign shift = shamt;
	
	always @(posedge rst or posedge clk) begin
		if (rst) begin 
			Registers[0]  <= 32'h00000000;    // $zero
			Registers[1]  <= 32'h00000000;    // reserved
    	  	Registers[2]  <= 32'h00000000;    // $v0
     	 	Registers[3]  <= 32'h00000000;    // &v1
			Registers[4]  <= 32'h00000000;    // $a0
			Registers[5]  <= 32'h00000000;    // $a1
			Registers[6]  <= 32'h00000000;    // $a2
			Registers[7]  <= 32'h00000000;    // $a3
			Registers[8]  <= 32'h00000000;    // $t0
			Registers[9]  <= 32'h00000000;    // $t1
			Registers[10] <= 32'h00000000;   // $t2
			Registers[11] <= 32'h00000000;   // $t3
			Registers[12] <= 32'h00000000;   // $t4
			Registers[13] <= 32'h00000000;   // $t5
			Registers[14] <= 32'h00000000;   // $t6
			Registers[15] <= 32'h00000000;   // $t7
			Registers[16] <= 32'h00000000;   // $s0
			Registers[17] <= 32'h00000000;   // $s1
			Registers[18] <= 32'h00000000;   // $s2
			Registers[19] <= 32'h00000000;   // $s3
			Registers[20] <= 32'h00000000;   // $s4
			Registers[21] <= 32'h00000000;   // $s5
			Registers[22] <= 32'h00000000;   // $s6
			Registers[23] <= 32'h00000000;   // $s7
			Registers[24] <= 32'h00000000;   // $t8
			Registers[25] <= 32'h00000000;   // $t9
			Registers[26] <= 32'h00000000;   // reserved
			Registers[27] <= 32'h00000000;   // reserved
			Registers[28] <= 32'h10008000;   // $gp
			Registers[29] <= 32'h7FFFEFFC;   // &sp
			Registers[30] <= 32'h00000000;   // &fp
			Registers[31] <= 32'h00000000;   // $ra
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
			
			if (Regwrite == 1'b1) begin 
				Registers[write_register] <= outdata;
			end
		end
		//$display("Regfile-space (t0) : %h", Registers[8]);
		//$display("Regfile-space (t1) : %h", Registers[9]);
	end
endmodule
