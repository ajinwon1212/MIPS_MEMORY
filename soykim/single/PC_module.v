
module PC_module (rst, clk, sign_extend, PC_next, MemRead);
	input rst, clk;
	input [31:0] sign_extend;
	input MemRead;
	output [7:0] PC_next;
	
	wire [31:0] sign_extend_shift; 
	reg [7:0] PC_next_register;
	
	
	reg state_id;
	//if state_id == 0 && is_lw == 1      =>     state change to 1, pc = pc (stall)
	//if state_id == 1 && is_lw == dontcare =>   state change to 0, pc = pc + 4
	//is_lw == MemRead.
	wire state_wire;
	assign state_wire = state_id;
	
	
	//assign PCSrc = (Branch & zero);
	assign sign_extend_shift = sign_extend << 2;
	
	always @(posedge rst or posedge clk) begin
		if (rst == 1'b1) begin
			PC_next_register <= 8'b0;
			state_id <= 1'b0;
		end
		else begin 
			if (state_wire == 1'b0) begin
				if (MemRead == 1'b1) begin
					PC_next_register <= PC_next;
					state_id <= state_id + 1'b1;
				end
				else begin
					PC_next_register <= PC_next + 8'd4;
					state_id <= state_id;
					// beq eliminated
					/*
					if (PCSrc == 1'b1) begin
						PC_next_register <= PC_next + 8'd4 + sign_extend_shift[7:0];
						state_id <= state_id;
					end
					else begin
						PC_next_register <= PC_next + 8'd4;
						state_id <= state_id;
					end
					*/
				end
			end
			else begin
				PC_next_register <= PC_next + 8'd4;
				state_id <= state_id + 1'b1;
			end
		end
	end
	assign PC_next = PC_next_register;
endmodule
