module Registers( CLK, RESET, RegWrite, Read_register_1, Read_register_2, Write_register, Write_Data, Read_data_1, Read_data_2);

	input CLK, RESET;
	input RegWrite;
	input [4:0] Read_register_1, Read_register_2, Write_register; //rs, rt, rd
	input [31:0] Write_Data;
	output [31:0] Read_data_1, Read_data_2;

	reg [31:0] Register[31:0];
	
	assign	Read_data_1 = Register[Read_register_1];
	assign	Read_data_2 = Register[Read_register_2];
	
	always @(posedge RESET or posedge CLK) //exclude RegWrite?
	begin
		if (RESET)
		begin
			Register[0]  <= 32'h00000000;    // $zero
			Register[1]  <= 32'h00000000;    // reserved
    	  		Register[2]  <= 32'h00000000;    // $v0
     	 		Register[3]  <= 32'h00000000;    // &v1
			Register[4]  <= 32'h00000000;    // $a0
			Register[5]  <= 32'h00000000;    // $a1
			Register[6]  <= 32'h00000000;    // $a2
			Register[7]  <= 32'h00000000;    // $a3
			Register[8]  <= 32'h00000000;    // $t0
			Register[9]  <= 32'h00000000;    // $t1
			Register[10] <= 32'h00000000;   // $t2
			Register[11] <= 32'h00000000;   // $t3
			Register[12] <= 32'h00000000;   // $t4
			Register[13] <= 32'h00000000;   // $t5
			Register[14] <= 32'h00000000;   // $t6
			Register[15] <= 32'h00000000;   // $t7
			Register[16] <= 32'h00000000;   // $s0
			Register[17] <= 32'h00000000;   // $s1
			Register[18] <= 32'h00000000;   // $s2
			Register[19] <= 32'h00000000;   // $s3
			Register[20] <= 32'h00000000;   // $s4
			Register[21] <= 32'h00000000;   // $s5
			Register[22] <= 32'h00000000;   // $s6
			Register[23] <= 32'h00000000;   // $s7
			Register[24] <= 32'h00000000;   // $t8
			Register[25] <= 32'h00000000;   // $t9
			Register[26] <= 32'h00000000;   // reserved
			Register[27] <= 32'h00000000;   // reserved
			Register[28] <= 32'h10008000;   // $gp
			Register[29] <= 32'h70000180;   // &sp
			Register[30] <= 32'h00000000;   // &fp
			Register[31] <= 32'h00000000;   // $ra		
		end

		else 
		begin 
			Register[0]	<=	Register[0]	;
			Register[1]	<=	Register[1]	;
    	  		Register[2]	<=	Register[2]	;
     	 		Register[3]	<=	Register[3]	;
			Register[4]	<=	Register[4]	;
			Register[5]	<=	Register[5]	;
			Register[6]	<=	Register[6]	;
			Register[7]	<=	Register[7]	;
			Register[8]	<=	Register[8]	;
			Register[9]	<=	Register[9]	;
			Register[10]	<=	Register[10]	;
			Register[11]	<=	Register[11]	;
			Register[12]	<=	Register[12]	;
			Register[13]	<=	Register[13]	;
			Register[14]	<=	Register[14]	;
			Register[15]	<=	Register[15]	;
			Register[16]	<=	Register[16]	;
			Register[17]	<=	Register[17]	;
			Register[18]	<=	Register[18]	;
			Register[19]	<=	Register[19]	;
			Register[20]	<=	Register[20]	;
			Register[21]	<=	Register[21]	;
			Register[22]	<=	Register[22]	;
			Register[23]	<=	Register[23]	;
			Register[24]	<=	Register[24]	;
			Register[25]	<=	Register[25]	;
			Register[26]	<=	Register[26]	;
			Register[27]	<=	Register[27]	;
			Register[28]	<=	Register[28]	;
			Register[29]	<=	Register[29]	;
			Register[30]	<=	Register[30]	;
			Register[31]	<=	Register[31]	;
			
			if (RegWrite == 1'b1) 
			begin 
				Register[Write_register] <= Write_Data;
			end
		end
		
		$display("______Registers.v______);
		$display("Read_reg_1	: %d, Read_data_1	: %h", Read_register_1,Register[Read_register_1]);
		$display("Read_reg_1	: %d, Read_data_2	: %h", Read_register_2,Register[Read_register_2]);
		$display("Write_reg	: %d, Wrtie_Data	: %h", Write_register,Write_Data);
/*
		$display($time);
		$display("Read_reg_1 : %d, Read_data_1 : %h", Read_register_1,Register[Read_register_1]);
		$display("Read_reg_1 : %d, Read_data_2 : %h", Read_register_2,Register[Read_register_2]);
		$display("Write_reg : %d, Wrtie_Data: %h", Write_register,Write_Data);
		$display(" ");
*/
	end
endmodule
