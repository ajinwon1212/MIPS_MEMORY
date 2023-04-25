//Control hazard
// : Rformat - Branch (1 bubble)	CONT_1
// : lw - Branch (2 bubbles) 		CONT_2a, CONT_2b
//Data hazard > Source duplicated
// : lw-Rformat (2 bubble) 		DATA_1a, DATA_1b
// : lw-lw,sw (2 bubble)		DATA_2a, DATA_2b
// : sw-lw (1 bubble)			DATA_3 X
//Branch taken
// (flush)
//Jump
// (flush)

module Hazard_detection_unit(CLK, RESET, IF_PC_4,
opcode_ID, opcode_EX, opcode_MEM, EX_RegWrite,MEM_RegWrite,
ID_RS, ID_RT, EX_RS, EX_RD, MEM_RD,
Branch,Jump,PCWrite, IFIDWrite, IF_Flush, Hazard_Ctrl
,CONT_1, CONT_2a, CONT_2b, DATA_1a, DATA_1b, DATA_2a, DATA_2b
);
//,Bub_CNT,Bub_CNT_1d, CONT_2a, CONT_2b);

//module Hazard_detection_unit(
//CLK, opcode_ID, opcode_EX, ID_RS, ID_RT, EX_RS, EX_RD, 
//Branch,Jump,
//CONT_1, CONT_2a, CONT_2b, DATA_1, DATA_2, DATA_3,
//NOT_EX_JUMP_LW_JP,
//PCWrite, IFIDWrite, IF_Flush, Hazard_Ctrl
//);

	input CLK, RESET;
	input [31:0] IF_PC_4;
	input [5:0] opcode_ID, opcode_EX, opcode_MEM;
	input EX_RegWrite, MEM_RegWrite;
	input [4:0] ID_RS, ID_RT, EX_RS, EX_RD, MEM_RD;
	input Branch;
	input [1:0] Jump;
	output reg PCWrite, IFIDWrite, Hazard_Ctrl;
	output reg IF_Flush;

	//reg CONT_2a_1d, CONT_2a_2d;

	output wire CONT_1, CONT_2a, CONT_2b, DATA_1a, DATA_1b, DATA_2a, DATA_2b;
	wire FLUS;

	assign CONT_1 =  
	((opcode_ID == 6'b000100) ||  (opcode_ID == 6'b000101)) ? (
	((opcode_EX != 6'b000100) && (opcode_EX != 6'b000101) && (opcode_EX != 6'b100011) && (opcode_EX != 6'b000010) && (opcode_EX != 6'b000011)) ? (
	 ((EX_RD == ID_RS) || (EX_RD == ID_RT)) ? 1'b1 : 1'b0 ) : 1'b0
	) : 1'b0;
				
	assign CONT_2a =  
	((opcode_ID == 6'b000100) ||  (opcode_ID == 6'b000101)) ? (
 	(opcode_EX == 6'b100011) ? (
	((EX_RD == ID_RS) || (EX_RD == ID_RT)) ? 1'b1: 1'b0 ) : 1'b0
	) : 1'b0 ;

	assign CONT_2b =  
	((opcode_ID == 6'b000100) ||  (opcode_ID == 6'b000101)) ? (
 	(opcode_MEM == 6'b100011) ? (
	((MEM_RD == ID_RS) || (MEM_RD == ID_RT)) ? 1'b1: 1'b0 ) : 1'b0
	) : 1'b0 ;

	//assign DATA_1 = 
	//(opcode_EX == 6'b100011) ? (
 	//((opcode_ID != 6'b000100) || (opcode_ID != 6'b000101) || (opcode_ID != 6'b000010) || !(opcode_ID != 6'b000011) || (opcode_ID != 6'b100011) || (opcode_ID != 6'b101011)) ? (
 	//((EX_RD == ID_RS) || (EX_RD == ID_RT)) ? 1'b1 : 1'b0 ) : 1'b0
	//) : 1'b0;

	assign DATA_1a = ((opcode_ID != 6'b000100) && (opcode_ID != 6'b000101) && (opcode_ID != 6'b000010) && (opcode_ID != 6'b000011) && (opcode_ID != 6'b100011) && (opcode_ID != 6'b101011)) ? (
 	(opcode_EX == 6'b100011) ? ( ((EX_RD == ID_RS) || (EX_RD == ID_RT)) ? 1'b1 : 1'b0 ) : 1'b0 
	) : 1'b0;

	//assign DATA_2 = 
	//(opcode_EX == 6'b100011) ? (
 	//((opcode_ID == 6'b100011) || (opcode_ID == 6'b101011)) ? (
 	//(EX_RD == ID_RS) ? 1'b1 : 1'b0 ) : 1'b0
	//) : 1'b0;
	assign DATA_1b = ((opcode_ID != 6'b000100) && (opcode_ID != 6'b000101) && (opcode_ID != 6'b000010) && (opcode_ID != 6'b000011) && (opcode_ID != 6'b100011) && (opcode_ID != 6'b101011)) ? (
 	(opcode_MEM == 6'b100011) ? ( ((MEM_RD == ID_RS) || (MEM_RD == ID_RT)) ? 1'b1 : 1'b0 ) : 1'b0 
	) : 1'b0;

	assign DATA_2a = ((opcode_ID == 6'b100011) || (opcode_ID == 6'b101011)) ? (
	((EX_RegWrite == 1'b1) && (opcode_EX == 6'b100011) && (EX_RD == ID_RS)) ? 1'b1 : 1'b0 ) : 1'b0 ;

	assign DATA_2b = ((opcode_ID == 6'b100011) || (opcode_ID == 6'b101011)) ? (
	((MEM_RegWrite == 1'b1) && (opcode_MEM == 6'b100011) && (MEM_RD == ID_RS)) ? 1'b1 : 1'b0 ) : 1'b0 ;

	//assign DATA_3 = 
	//(opcode_EX == 6'b101011) ? (
	// (opcode_ID == 6'b101011) ? ( 
	//(EX_RS == ID_RS) ? 1'b1 : 1'b0 ) : 1'b0
	//) : 1'b0 ;

	//assign DATA_3 = (opcode_ID == 6'b100011)  ? (                      
	//((opcode_EX == 6'b101011) ? ( (EX_RS == ID_RS) ? 1'b1 : 1'b0 ) : 1'b0 ) ) : 1'b0 ;

	assign FLUS = Branch || Jump[0] || Jump[1];

	assign PCWrite = (IF_PC_4 == 32'd0) ? 1'b1 : ( 
	(CONT_1 || CONT_2a|| CONT_2b || DATA_1a || DATA_1b || DATA_2a || DATA_2b) ? 1'b0 : 1'b1 );
	assign IFIDWrite= (IF_PC_4 == 32'd0) ? 1'b1 : ( 
	(CONT_1 || CONT_2a|| CONT_2b || DATA_1a || DATA_1b || DATA_2a || DATA_2b) ? 1'b0 : 1'b1 );
	//assign IF_Flush = (IF_PC_4 == 32'd0) ? 1'b0 : (
	//FLUS ? 1'b1 : 1'b0 );  //because of lw-lw
	assign IF_Flush = FLUS ? 1'b1 : 1'b0 ;  //because of lw-lw

	assign Hazard_Ctrl= (IF_PC_4 == 32'd0) ? 1'b0 : (
	(CONT_1 || CONT_2a || CONT_2b || DATA_1a || DATA_1b || DATA_2a || DATA_2b) ? 1'b1 : 1'b0 );


/*
	always@(*)
	begin
		if (RESET)begin 
		PCWrite <= 1'b1;
		IFIDWrite <= 1'b1;
		IF_Flush <= 1'b0;
		Hazard_Ctrl <= 1'b0;
		end

		else begin
		PCWrite <= PCWrite;
		IFIDWrite <= IFIDWrite;
		IF_Flush <= IF_Flush;
		Hazard_Ctrl <= Hazard_Ctrl;
		end
	end
*/

endmodule

