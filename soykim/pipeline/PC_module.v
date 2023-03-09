
module PC_module (rst,clk,PCmux_in, PCmodule_PCWrite_in, beq_stall, ID_mux2_out, PCnext);
	input rst,clk,PCmux_in, PCmodule_PCWrite_in, beq_stall; 
	input [31:0] ID_mux2_out;
	output reg [31:0] PCnext; 

	always @(posedge clk or negedge rst) begin // rst should be negedge sensitive.
		if (rst == 1'b0) begin
			PCnext <= 32'b0;
		end
		else begin 
				if (PCmux_in == 1'b1) begin
					if(PCmodule_PCWrite_in == 1'b1) begin
						PCnext <= PCnext + 32'd4;
					end
					else begin
						PCnext <= PCnext;
					end
				end
				else if (PCmux_in == 1'b0) begin  
					if(PCmodule_PCWrite_in == 1'b1) begin 
						PCnext <= ID_mux2_out;
					end
					else begin
						PCnext <= PCnext;
					end
				end
		end
	end
endmodule