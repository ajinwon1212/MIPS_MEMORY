module HiLo_tb();

reg CLK, RESET;
reg [31:0] ALU_IN_1, ALU_IN_2;
reg [3:0] ALU_control;
reg [4:0] Shampt;

wire [31:0] ALU_result;
wire [31:0] Hi, Lo, HI, LO;

ALU ALU1( 
	.CLK(CLK),
	.ALU_IN_1(ALU_IN_1), 
	.ALU_IN_2(ALU_IN_2),
	.ALU_control(ALU_control),
	.Shampt(Shampt),
	//ALU_zero,
	.ALU_result(ALU_result),
	.Hi(Hi),
	.Lo(Lo)
);

Special_Registers SR1(.CLK(CLK),.RESET(RESET),.Hi(Hi),.Lo(Lo),.ALU_control(ALU_control),.HI(HI),.LO(LO));

initial
begin
	CLK = 1'b1;
	forever
	begin
		#10 CLK = !CLK;
	end
end

initial
begin
	RESET = 1'b0;
	ALU_IN_1 = 32'd1;
	ALU_IN_2 = 32'd3;
	ALU_control = 4'b1101;
	Shampt = 5'd0;

	#20
	ALU_IN_1 = 32'd2;
	ALU_IN_2 = 32'd3;
	ALU_control = 4'b0000;
	Shampt = 5'd0;

	#20
	ALU_IN_1 = 32'hffffffff;
	ALU_IN_2 = 32'd3;
	ALU_control = 4'b1101;
	Shampt = 5'd0;

	#20
	ALU_IN_1 = 32'h7fffffff;
	ALU_IN_2 = 32'd4;
	ALU_control = 4'b1101;
	Shampt = 5'd0;

	#20
	ALU_IN_1 = 32'h9fffffff;
	ALU_IN_2 = 32'd4;
	ALU_control = 4'b1101;
	Shampt = 5'd0;

	#20
	ALU_IN_1 = 32'h000fffff;
	ALU_IN_2 = 32'd50;
	ALU_control = 4'b1101;
	Shampt = 5'd0;
end

endmodule
