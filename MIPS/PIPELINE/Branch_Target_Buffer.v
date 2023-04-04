module Branch_Target_Buffer (
	input CLK, RESET,
	input [31:0] PC_4,
	input [31:0] IF_Instruction,	//IN
	output [31:0] Branch_Addr		//OUT
	);

wire [31:0] imm_se;
wire [31:0] B_WO_PC;
wire [31:0] ADD_out;
wire not_out1, not_out2, not_out3, not_out5;
wire and_out1, and_out2, and_out3;
wire m_sig;

Sign_extend se(.Sign_extend_in(IF_Instruction[15:0]), .Sign_extend(imm_se));
Shift_left_2 sl(.Shift_left_2_IN(imm_se), .Shift_left_2_OUT(B_WO_PC));
ADD add(.a(PC_4), .b(B_WO_PC), .out(ADD_out));

not_gate n1(.a(IF_Instruction[31]), .out(not_out1));
not_gate n2(.a(IF_Instruction[30]), .out(not_out2));
not_gate n3(.a(IF_Instruction[29]), .out(not_out3));
not_gate n5(.a(IF_Instruction[27]), .out(not_out5));

and_gate a1(.a(not_out1), .b(not_out2), .out(and_out1));
and_gate a2(.a(not_out3), .b(not_out5), .out(and_out2));
and_gate a3(.a(and_out1), .b(and_out2), .out(and_out3));
and_gate a4(.a(and_out3), .b(IF_Instruction[28]), .out(m_sig));

MUX2to1 muxb(.a(PC_4), .b(ADD_out), .sig(m_sig), .out(Branch_Addr));	// branch opcode : 00010X


endmodule
