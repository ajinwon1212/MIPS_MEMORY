module ALU (
    input CLK,
    input signed [31:0] ALU_IN_1, ALU_IN_2,
    input [3:0] ALU_control,
    input [4:0] Shampt,
    output reg ALU_zero,
    output reg signed [31:0] ALU_result,
    output reg signed [31:0] Hi, Lo
);

reg signed [31:0] ALU_Result;

assign ALU_zero = (ALU_Result == 0) ? ((ALU_control[0] == 1) ? 0 : 1 ) : ((ALU_control[0] == 1) ? 1 : 0 ); 
assign ALU_result = ALU_Result;

always @(*) begin
    ALU_Result = 32'sd0;
    case (ALU_control)
        4'b0000: ALU_Result = ALU_IN_1 + ALU_IN_2; // ADD
        4'b1000: ALU_Result = ALU_IN_1 & ALU_IN_2; // AND
        4'b0100: ALU_Result = ALU_IN_1 - ALU_IN_2; // SUB
        4'b0110: ALU_Result = ALU_IN_1 - ALU_IN_2; // SUB
        4'b1100: ALU_Result = ~(ALU_IN_1 | ALU_IN_2); // NOR
        4'b1010: ALU_Result = ALU_IN_1 | ALU_IN_2; // OR
        4'b0101: ALU_Result = (ALU_IN_1 < ALU_IN_2) ? 1 : 0; // SLT
        4'b0010: ALU_Result = ALU_IN_1 << Shampt; // SHIFT_LEFT
        4'b0011: ALU_Result = ALU_IN_1 >> Shampt; // SHIFT_RIGHT
        4'b1011: begin // DIV
            Lo = ALU_IN_1 / ALU_IN_2;
            Hi = ALU_IN_1 % ALU_IN_2;
        end
        4'b1101: begin // MULT
            reg [63:0] product;
            product = ALU_IN_1 * ALU_IN_2;
            Lo = product[31:0];
            Hi = product[63:32];
        end
        4'b1001: ALU_Result = ALU_IN_1 * ALU_IN_2; // MUL
        4'b1111: ALU_Result = 31'b0; // Do nothing
        default: ALU_Result = 32'sd0; // Default case
    endcase
end

endmodule