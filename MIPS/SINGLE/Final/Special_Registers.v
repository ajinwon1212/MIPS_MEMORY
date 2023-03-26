module Special_Registers( CLK, RESET, Hi, Lo, ALU_control, HI, LO);

	input CLK, RESET;
	input [31:0] Hi, Lo;
	input [3:0] ALU_control; //Save on;y when div, mult
	output [31:0] HI, LO;

	reg signed [31:0] Register[1:0]; //This can be bigger if use float instructions
	
	assign	HI = Register[1];
	assign	LO = Register[0];
	
	always @(posedge RESET or posedge CLK) //exclude RegWrite?
	begin
		if (RESET)
		begin
			Register[0]  <= 32'h00000000;    // Lo
			Register[1]  <= 32'h00000000;    // Hi
			$display("RESET MODE");	
		end

		else 
		begin 
			Register[0]	<=	Register[0]	;
			Register[1]	<=	Register[1]	;
		
			if ((ALU_control == 4'b1011)|(ALU_control == 4'b1101))
			begin 
				Register[0] <= Lo;
				Register[1] <= Hi;
			end
		end
	end

endmodule

