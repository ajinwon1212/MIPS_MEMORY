
module ID_adder (rst, IFID_instruction_out, IFID_PCnext_out, ID_mux2_out);
	input rst;
	input [31:0] IFID_instruction_out, IFID_PCnext_out;
	output [31:0] ID_mux2_out;
	//reg [15:0] signextend;
	//reg [31:0] signextend_shift;
	//assign signextend = IFID_instruction_out[15:0]; 
	//assign signextend_shift = signextend << 2;
	
	assign ID_mux2_out = (rst == 1'b0) ? 32'b0 : (IFID_PCnext_out + 32'd4 + (IFID_instruction_out[15:0] << 2));

/*
	always@ (rst, IFID_instruction_out, IFID_PCnext_out)
	begin
		if(rst==0) begin
			ID_mux2_out <= 32'bx;
		end
		else begin
			ID_mux2_out <= IFID_PCnext_out + 32'b100 + (IFID_instruction_out[15:0] << 2);
		end
	end
	*/
endmodule