//Consider double data hazard!
//Only Branch forwarding > ALL need!! because WB timing is later than ID
module Forwarding_Unit_ID (
	input [5:0] opcode_ID,
	input [4:0] ID_RS, ID_RT,
	input [4:0] MEM_RD, WB_RD,
	input MEM_FW, WB_FW,
	output [1:0] FW_sig1,
	output [1:0] FW_sig2
);
	//assign FW_sig1 = ((opcode_ID == 6'b000100)||(opcode_ID ==6'b000101)) ? ((MEM_FW &&(MEM_RD == ID_RS)) ? (2'b01) : (
	//	(WB_FW&&(WB_RD == ID_RS)) ? (2'b10) : (2'b00))) : (WB_FW&&(WB_RD == ID_RT) ? 2'b10 : 2'b00);
	//assign FW_sig2 = ((opcode_ID == 6'b000100)||(opcode_ID ==6'b000101)) ? ((MEM_FW &&(MEM_RD == ID_RT)) ? (2'b01) : (
	//	(WB_FW&&(WB_RD == ID_RT)) ? (2'b10) : (2'b00))) : (WB_FW&&(WB_RD == ID_RT) ? 2'b10 : 2'b00);

	assign FW_sig1 = (MEM_FW &&(MEM_RD == ID_RS)) ? (2'b01) : (
		(WB_FW&&(WB_RD == ID_RS)) ? 2'b10 : 2'b00 );

	assign FW_sig2 = ((opcode_ID==6'b000000)||(opcode_ID==6'b000100)||(opcode_ID==6'b000101)||(opcode_ID==6'b101011)) ? (
	(MEM_FW &&(MEM_RD == ID_RT)) ? (2'b01) : ( (WB_FW&&(WB_RD == ID_RT)) ? 2'b10 : 2'b00 )) : (2'b00) ;


	//assign FW_sig2 = (MEM_FW &&(MEM_RD == ID_RT)&&FW_sig2) ? (2'b01) : (
		//(WB_FW&&(WB_RD == ID_RT)&&((opcode_ID=6'b000000)||(opcode_ID=6'b000100)||(opcode_ID=6'b000101))) ? 2'b10 : 2'b00 );

	//Register Saving timing(WB) is later than Reading Resister(ID)
	//Therefore need WB forwarding
endmodule
