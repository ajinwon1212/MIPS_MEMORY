`timescale 1ns / 1ns  
//RUN 150ns
//Delete /* */ in Register.v file

module Registers_TB;

	reg CLK, RESET;
	reg RegWrite;
	reg [4:0] Read_reg_1, Read_reg_2, Write_reg;
	reg [31:0] Write_Data;
	wire [31:0] Read_data_1, Read_data_2;

	Registers Registers_top(
		.CLK(CLK),					//IN
		.RESET(RESET),					//IN
		.RegWrite(RegWrite),				//IN
		.Read_register_1(Read_reg_1),			//IN
		.Read_register_2(Read_reg_2),			//IN
		.Write_register(Write_reg),			//IN
		.Write_Data(Write_Data),			//IN
		.Read_data_1(Read_data_1),			//OUT
		.Read_data_2(Read_data_2)			//OUT
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
		#20 RESET = 1'b0; 
		//Read and Write
		#20 Read_reg_1 = 5'd1 ; Read_reg_2 = 5'd4; 
		    Write_reg = 5'd2; RegWrite = 1'd1; Write_Data = 32'hFFFFFFFF;
		//Read and Write
		#20 Read_reg_1 = 5'd2 ; Read_reg_2 = 5'd2; 
		    Write_reg = 5'd1; RegWrite = 1'd1; Write_Data = 32'hFFFFFFFF;
		//Read only
		#20 Read_reg_1 = 5'd1 ; Read_reg_2 = 5'd0; 
		    Write_reg = 5'd4; RegWrite = 1'd0; Write_Data = 32'hFFFFFFFF;
		//Read and Write
		#20 Read_reg_1 = 5'd1 ; Read_reg_2 = 5'd4; 
		    Write_reg = 5'd31; RegWrite = 1'd0; Write_Data = 32'hFFFFFFFF;
		// Read address and Write address is the same
		// Read data proceeds when clk is posedge
		// Write data proceeds when clk is negedge
		// Therefore there is no problem
		#20 Read_reg_1 = 5'd31 ; Read_reg_2 = 5'd4; 
		    Write_reg = 5'd31; RegWrite = 1'd1; Write_Data = 32'hFFFF;
	end


endmodule
