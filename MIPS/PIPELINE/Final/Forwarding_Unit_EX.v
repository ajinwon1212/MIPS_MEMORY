module Forwarding_Unit_EX (
    input [5:0] opcode,
    input [4:0] EX_RS, EX_RT,
    input [4:0] MEM_RD, WB_RD,
    input [31:0] MEM_RD_DATA_I, WB_RD_DATA_I,
    input ALUSrc,
    output reg [31:0] MEM_RD_DATA_O, WB_RD_DATA_O,
    output reg FW_sig1, FW_sig2
);

  // Forwarding conditions
  wire MEM_to_EX = (EX_RS == MEM_RD) && (EX_RS != 5'b0) && (opcode != 6'b000000) && !ALUSrc; // opcode all 0 represents R-type, R-type instructions use the 'EX_RS' register as a source operand so forwarding unit does not needed.
  wire WB_to_EX = (EX_RS == WB_RD) && (EX_RS != 5'b0) && (opcode != 6'b000000);

  // Forwarding signals
  assign FW_sig1 = MEM_to_EX;
  assign FW_sig2 = WB_to_EX && !MEM_to_EX;

  // Forwarding logic for MEM_RD_DATA
  always @(*) begin
    if (MEM_to_EX)
      MEM_RD_DATA_O = MEM_RD_DATA_I;
    else if (WB_to_EX)
      MEM_RD_DATA_O = WB_RD_DATA_I;
    else
      MEM_RD_DATA_O = 32'b0;
  end

  // Forwarding logic for WB_RD_DATA
  always @(*) begin
    if (WB_to_EX)
      WB_RD_DATA_O = WB_RD_DATA_I;
    else
      WB_RD_DATA_O = 32'b0;
  end

endmodule



// MEM_to_EX condition:
// (EX_RS == MEM_RD): checks if the source register EX_RS is equal to the destination register MEM_RD from the MEM stage. If true, this means that the data produced in the MEM stage is required in the current instruction's EX stage.
// (EX_RS != 5'b0): In MIPS, register 0 is hardwired to zero and should not be involved in forwarding.
// (opcode != 6'b000000): checks if the current instruction is not an R-type instruction.
// !ALUSrc: checks if the ALUSrc control signal is not asserted. ALUSrc determines if the second ALU operand comes from the EX_RT register or an immediate value. If ALUSrc is not asserted, the second operand comes from the EX_RT register and forwarding should be considered.

// WB_to_EX condition:
// (EX_RS == WB_RD): checks if the source register EX_RS is equal to the destination register WB_RD from the WB stage. If true, this means that the data produced in the WB stage is required in the current instruction's EX stage.
// (EX_RS != 5'b0): same as in the MEM_to_EX case, ensure that the source register EX_RS is not equal to zero.
// (opcode != 6'b000000): This condition is also the same as in the MEM_to_EX case, checking if the current instruction is not an R-type instruction.