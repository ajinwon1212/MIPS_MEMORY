module Forwarding_Unit_EX (
    input [5:0] opcode_EX,
    input [4:0] EX_RS, EX_RT,
    input [4:0] MEM_RD, WB_RD,
    input MEM_FW, WB_FW,
    output [1:0] FW_sig1, 
    output [1:0] FW_sig2
);

wire MEM_Read_EX = (opcode_EX == 6'b100011); // LW instruction
wire MEM_RegWrite_EX = (opcode_EX != 6'b000100) && (opcode_EX != 6'b101011) && (opcode_EX != 6'b000000 || EX_RT != 5'b00000);
wire WB_RegWrite = (opcode_EX != 6'b000100) && (opcode_EX != 6'b101011) && (opcode_EX != 6'b000000 || EX_RT != 5'b00000);

assign FW_sig1 = ((EX_RS == MEM_RD) && (EX_RS != 5'b0) && !MEM_Read_EX && MEM_RegWrite_EX && MEM_FW) ? 2'b10 : 
                ((EX_RS == WB_RD) && (EX_RS != 5'b0) && WB_RegWrite && WB_FW && !((EX_RS == MEM_RD) && MEM_RegWrite_EX && MEM_FW)) ? 2'b01 : 2'b00;

assign FW_sig2 = ((EX_RT == MEM_RD) && (EX_RT != 5'b0) && !MEM_Read_EX && MEM_RegWrite_EX && MEM_FW) ? 2'b10 : 
                ((EX_RT == WB_RD) && (EX_RT != 5'b0) && WB_RegWrite && WB_FW && !((EX_RT == MEM_RD) && MEM_RegWrite_EX && MEM_FW)) ? 2'b01 : 2'b00;

endmodule


// https://gofo-coding.tistory.com/entry/Data-Hazard
