module PC (
	input CLK, RESET, PCWrite,
	input [31:0] PC_next,
	output reg [31:0] PC,
	output reg PCLK
	);

always @(posedge RESET or posedge CLK)
begin
	if (RESET == 1'b1) begin
		PC <= 32'hfffffffc;
		PCLK <= 1'b0;
	end
	else
	begin 
		if (PCWrite == 1'b1)
		begin
			PC <= PC_next;
		end
		else
		begin
			PC <= PC;
		end
	end
end

always@(CLK) begin 
	if (RESET == 1'b1) begin
		PCLK <= 1'b0;
	end
	else begin
		PCLK <= (!PCLK); 
	end
end

endmodule
