module Forwarding_Unit_EX (
    input [5:0] opcode_EX,
    input [4:0] EX_RS, EX_RT,
    input [4:0] MEM_RD, WB_RD,
    input MEM_FW, WB_FW,
    output [1:0] FW_sig1, 
    output [1:0] FW_sig2
);


assign FW_sig1 = ((EX_RS == MEM_RD) && (EX_RS != 5'b0) && (opcode_EX != 6'b000000) && MEM_FW) ? 2'b01 : 
                ((EX_RS == WB_RD) && (EX_RS != 5'b0) && (opcode_EX != 6'b000000) && WB_FW) ? 2'b10 : 2'b00;

assign FW_sig2 = (opcode_EX == 6'b000100) || (opcode_EX == 6'b000101) && (MEM_RD == EX_RT) ? ((MEM_FW) ? 2'b01 : 2'b00) : 
                (opcode_EX == 6'b000100) || (opcode_EX == 6'b000101) && (WB_RD == EX_RT) ? ((WB_FW) ? 2'b10 : 2'b00) : 2'b00;

endmodule

