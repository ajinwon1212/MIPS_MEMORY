//IF_ID_Write, IF_Flush

module IFID_reg_module (rst, clk, IFID_Write_in, IFID_instruction_in, IFID_PCnext_in, IFID_PCnext_out, IFID_instruction_out,
IDEX_opcode_in, IDEX_rs_in, IDEX_rt_in, IDEX_rd_in, IDEX_shamt_in, IDEX_funct_in, IDEX_offset_in);
	
	input rst, clk, IFID_Write_in;
	input [31:0] IFID_instruction_in, IFID_PCnext_in;
	output reg [31:0] IFID_PCnext_out, IFID_instruction_out;
	output reg [5:0] IDEX_opcode_in, IDEX_funct_in;
	output reg [4:0] IDEX_rs_in, IDEX_rt_in, IDEX_rd_in, IDEX_shamt_in;
	output reg [15:0] IDEX_offset_in;

	always @(posedge clk or negedge rst)
	begin
		if (rst==1'b0)
		begin
			IFID_PCnext_out <= 32'b0;
			IFID_instruction_out <= 32'b0;
		end
		else if (IFID_Write_in == 1'b1)
		begin
			IFID_PCnext_out <= IFID_PCnext_in;
			IFID_instruction_out <= IFID_instruction_in;
		end
	end

	always @(posedge clk or negedge rst)
	begin
		if (rst==1'b0) begin
			IDEX_opcode_in <= 6'b0;
			IDEX_rs_in <= 5'b0;
			IDEX_rt_in <= 5'b0;
			IDEX_rd_in <= 5'b0;
			IDEX_shamt_in <= 5'b0;
			IDEX_funct_in <= 6'b0;
			IDEX_offset_in <= 16'b0;
		end
		else if (IFID_Write_in == 1'b1) begin
			IDEX_opcode_in <= IFID_instruction_in[31:26];
			IDEX_rs_in <= IFID_instruction_in[25:21];
			IDEX_rt_in <= IFID_instruction_in[20:16];
			IDEX_rd_in <= IFID_instruction_in[15:11];
			IDEX_shamt_in <= IFID_instruction_in[10:6];
			IDEX_funct_in <= IFID_instruction_in[5:0];
			IDEX_offset_in <= IFID_instruction_in[15:0];
        end
	end
endmodule


