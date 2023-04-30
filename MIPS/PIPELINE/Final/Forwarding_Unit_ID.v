module Forwarding_Unit_ID (
    input [5:0] opcode,
    input [4:0] ID_RS, ID_RT,
    input [4:0] MEM_RD, WB_RD,
    input [31:0] MEM_RD_DATA_I, WB_RD_DATA_I,
    output reg [31:0] MEM_RD_DATA_O_RS, MEM_RD_DATA_O_RT,
    output reg [31:0] WB_RD_DATA_O_RS, WB_RD_DATA_O_RT,
    output reg FW_sig1_RS, FW_sig2_RS,
    output reg FW_sig1_RT, FW_sig2_RT
);

  // Forwarding conditions
  wire MEM_to_ID_RS = (ID_RS == MEM_RD) && (ID_RS != 5'b0) && (opcode != 6'b000000);
  wire WB_to_ID_RS = (ID_RS == WB_RD) && (ID_RS != 5'b0) && (opcode != 6'b000000);
  wire MEM_to_ID_RT = (ID_RT == MEM_RD) && (ID_RT != 5'b0) && (opcode != 6'b000000);
  wire WB_to_ID_RT = (ID_RT == WB_RD) && (ID_RT != 5'b0) && (opcode != 6'b000000);

  // Forwarding signals
  assign FW_sig1_RS = MEM_to_ID_RS;
  assign FW_sig2_RS = WB_to_ID_RS && !MEM_to_ID_RS;
  assign FW_sig1_RT = MEM_to_ID_RT;
  assign FW_sig2_RT = WB_to_ID_RT && !MEM_to_ID_RT;

  // Forwarding logic for MEM_RD_DATA (RS)
  always @(*) begin
    if (MEM_to_ID_RS)
      MEM_RD_DATA_O_RS = MEM_RD_DATA_I;
    else if (WB_to_ID_RS)
      MEM_RD_DATA_O_RS = WB_RD_DATA_I;
    else
      MEM_RD_DATA_O_RS = 32'b0;
  end

  // Forwarding logic for MEM_RD_DATA (RT)
  always @(*) begin
    if (MEM_to_ID_RT)
      MEM_RD_DATA_O_RT = MEM_RD_DATA_I;
    else if (WB_to_ID_RT)
      MEM_RD_DATA_O_RT = WB_RD_DATA_I;
    else
      MEM_RD_DATA_O_RT = 32'b0;
  end

  // Forwarding logic for WB_RD_DATA (RS)
  always @(*) begin
    if (WB_to_ID_RS)
      WB_RD_DATA_O_RS = WB_RD_DATA_I;
    else
      WB_RD_DATA_O_RS = 32'b0;
  end

  // Forwarding logic for WB_RD_DATA (RT)
  always @(*) begin
    if (WB_to_ID_RT)
      WB_RD_DATA_O_RT = WB_RD_DATA_I;
    else
      WB_RD_DATA_O_RT = 32'b0;
  end

endmodule