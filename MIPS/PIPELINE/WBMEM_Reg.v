module WBMEM_Reg (
    input CLK,
    input RESET,
    input [4:0] WB_MEM,
    input [5:0] MEM_Opcode,
    input signed [31:0] MEM_ALU_RESULT,
    input signed [31:0] MEM_RD_DATA,
    input [4:0] MEM_RD,
    input [31:0] MEM_PC_4,
    output reg [1:0] WB,
    output reg [5:0] WB_Opcode,
    output reg signed [31:0] WB_ALU_RESULT,
    output reg signed [31:0] WB_RD_Data,
    output reg [4:0] WB_RD,
    output reg [31:0] WB_PC_4
);

always @(posedge CLK or posedge RESET) begin
    if (RESET) begin
        // Reset all registers
        WB <= 2'b0;
        WB_Opcode <= 6'b0;
        WB_ALU_RESULT <= 32'sd0;
        WB_RD_Data <= 32'sd0;
        WB_RD <= 5'b0;
        WB_PC_4 <= 32'd0;
    end else begin
        // Transfer values from input to output registers
        WB <= WB_MEM[4:3];
        WB_Opcode <= MEM_Opcode;
        WB_ALU_RESULT <= MEM_ALU_RESULT;
        WB_RD_Data <= MEM_RD_DATA;
        WB_RD <= MEM_RD;
        WB_PC_4 <= MEM_PC_4;
    end
end

endmodule
