
module Hazard_detection_unit (rst, IDEX_opcode_in, IDEX_rt_out, IDEX_rs_in, IDEX_rt_in, IDEX_MemRead_out, IDEX_readata1_in, IDEX_readata2_in,
PCmux_in, PCmodule_PCWrite_in, IFID_Write_in, ID_mux1_in, ID_Flush_lwstall);
	input rst;
	input [5:0] IDEX_opcode_in;
	input [4:0] IDEX_rt_out, IDEX_rs_in, IDEX_rt_in;
	input IDEX_MemRead_out;
	input [31:0] IDEX_readata1_in, IDEX_readata2_in;
	output PCmux_in, PCmodule_PCWrite_in, IFID_Write_in, ID_mux1_in, ID_Flush_lwstall;
	
	wire rs_equal, rt_equal;
	assign rs_equal = (IDEX_rt_out == IDEX_rs_in) ? 1'b1 : 1'b0;
	assign rt_eqaul = (IDEX_rt_out == IDEX_rt_in) ? 1'b1 : 1'b0;
	
	
	assign PCmux_in = (rst == 1'b0) ? 1'b1 : (
		(IDEX_opcode_in == 6'b000100) ? (
			((IDEX_readata1_in == IDEX_readata2_in) ? 1'b0 : (
			((IDEX_MemRead_out & (rs_equal | rt_equal)) == 1'b1) ? 1'b0 : 1'b1)
			)
		) : (
		((IDEX_MemRead_out & (rs_equal | rt_equal)) == 1'b1) ? 1'b0 : 1'b1) );
	assign PCmodule_PCWrite_in = (rst == 1'b0) ? 1'b1 : (
		(IDEX_opcode_in == 6'b000100) ? (
			((IDEX_readata1_in == IDEX_readata2_in) ? 1'b1 : (
			((IDEX_MemRead_out & (rs_equal | rt_equal)) == 1'b1) ? 1'b0 : 1'b1)
			)
		) : (
		((IDEX_MemRead_out & (rs_equal | rt_equal)) == 1'b1) ? 1'b0 : 1'b1) );
	assign IFID_Write_in = (rst == 1'b0) ? 1'b1 : (
		(IDEX_opcode_in == 6'b000100) ? (
			((IDEX_readata1_in == IDEX_readata2_in) ? 1'b1 : (
			((IDEX_MemRead_out & (rs_equal | rt_equal)) == 1'b1) ? 1'b0 : 1'b1)
			)
		) : (
		((IDEX_MemRead_out & (rs_equal | rt_equal)) == 1'b1) ? 1'b0 : 1'b1) );
	assign ID_mux1_in = (rst == 1'b0) ? 1'b0 : (
		(IDEX_opcode_in == 6'b000100) ? (
			((IDEX_readata1_in == IDEX_readata2_in) ? 1'b1 : (
			((IDEX_MemRead_out & (rs_equal | rt_equal)) == 1'b1) ? 1'b1 : 1'b0)
			)
		) : (
		((IDEX_MemRead_out & (rs_equal | rt_equal)) == 1'b1) ? 1'b1 : 1'b0) );
	assign ID_Flush_lwstall = (rst == 1'b0) ? 1'b0 : (
		(IDEX_opcode_in == 6'b000100) ? (
			((IDEX_readata1_in == IDEX_readata2_in) ? 1'b1 : (
			((IDEX_MemRead_out & (rs_equal | rt_equal)) == 1'b1) ? 1'b1 : 1'b0)
			)
		) : (
		((IDEX_MemRead_out & (rs_equal | rt_equal)) == 1'b1) ? 1'b1 : 1'b0) );
	
	/*
	always@(rst, IDEX_MemRead_out, rs_equal, rt_equal,IDEX_opcode_in,IDEX_readata1_in, IDEX_readata2_in )
	begin
		if (IDEX_opcode_in == 6'b000100) begin
			if(IDEX_readata1_in == IDEX_readata2_in) begin
				PCmux_in <= 1'b0;
				PCmodule_PCWrite_in <= 1'b1;
			end
			else begin
				if (rst==0) begin
					PCmux_in <= 1'b1;
					PCmodule_PCWrite_in <= 1'b1;
					IFID_Write_in <= 1'b1;
					ID_mux1_in <= 1'b0; 
					ID_Flush_lwstall <= 1'b0;
				end
				else if(IDEX_MemRead_out & (rs_equal|rt_equal)) begin     //stall(o)
					PCmux_in <= 1'b0; 
					PCmodule_PCWrite_in <= 1'b0;
					IFID_Write_in <= 1'b0; 
					ID_mux1_in <= 1'b1; 
					ID_Flush_lwstall <= 1'b1;
				end
				else begin                                                //stall(x)
					PCmux_in <= 1'b1; 
					PCmodule_PCWrite_in <= 1'b1; 
					IFID_Write_in <= 1'b1; 
					ID_mux1_in <= 1'b0; 
					ID_Flush_lwstall <= 1'b0;
				end
			end
		end
		else begin
			if (rst==0) begin
				PCmux_in <= 1'b1;
				PCmodule_PCWrite_in <= 1'b1;
				IFID_Write_in <= 1'b1;
				ID_mux1_in <= 1'b0; 
				ID_Flush_lwstall <= 1'b0;
			end
			else if(IDEX_MemRead_out & (rs_equal|rt_equal)) begin     //stall(o)
				PCmux_in <= 1'b0; 
				PCmodule_PCWrite_in <= 1'b0;
				IFID_Write_in <= 1'b0; 
				ID_mux1_in <= 1'b1; 
				ID_Flush_lwstall <= 1'b1;
			end
			else begin                                                //stall(x)
				PCmux_in <= 1'b1; 
				PCmodule_PCWrite_in <= 1'b1; 
				IFID_Write_in <= 1'b1; 
				ID_mux1_in <= 1'b0; 
				ID_Flush_lwstall <= 1'b0;
			end
		end
end
*/
endmodule
