module Forwarding_Unit_EX (
    input [5:0] opcode_EX,
    input [4:0] EX_RS, EX_RT,
    input [4:0] MEM_RD, WB_RD,
    input ALUSrc,
    input MEM_FW, WB_FW,
    output [1:0] FW_sig1, 
    output [1:0] FW_sig2
);

assign FW_sig1 = ((EX_RS == MEM_RD) && MEM_FW) ? 2'b01 :(
                ((EX_RS == WB_RD) && WB_FW) ? 2'b10 : 2'b00);

assign FW_sig2 = ((EX_RT == MEM_RD) && !(opcode_EX == 6'b100011) && MEM_FW) ? 2'b10 : (
                 ((EX_RT == WB_RD) && WB_FW && (opcode_EX == 6'b000000)) ? 2'b11 : ((ALUSrc == 1'b0) ? 2'b00 : 2'b01 ));

endmodule


// https://gofo-coding.tistory.com/entry/Data-Hazard