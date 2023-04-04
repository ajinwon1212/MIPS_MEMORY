module EXMEM_Reg (
    input CLK,
    input RESET,
    input [10:0] WB_MEM_EX,
    input [5:0] EX_Opcode,
    input signed [31:0] EX_ALU_RESULT,
    input signed [31:0] EX_RT_DATA,
    input [4:0] EX_RD,
    input [31:0] EX_PC_4,
    output reg [2:0] WB_MEM,
    output reg [5:0] MEM_Opcode,
    output reg signed [31:0] MEM_ALU_RESULT,
    output reg signed [31:0] MEM_RT_DATA,
    output reg [4:0] MEM_RD,
    output reg [31:0] MEM_PC_4
);

always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        WB_MEM <= 3'b0;
        MEM_Opcode <= 6'b0;
        MEM_ALU_RESULT <= 32'sd0;
        MEM_RT_DATA <= 32'sd0;
        MEM_RD <= 5'b0;
        MEM_PC_4 <= 32'b0;
    end else begin
        WB_MEM <= WB_MEM_EX[10:8];
        MEM_Opcode <= EX_Opcode;
        MEM_ALU_RESULT <= EX_ALU_RESULT;
        MEM_RT_DATA <= EX_RT_DATA;
        MEM_RD <= EX_RD;
        MEM_PC_4 <= EX_PC_4;
    end
end

endmodule
