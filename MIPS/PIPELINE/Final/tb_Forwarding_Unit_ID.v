`timescale 1ns / 1ps

module tb_Forwarding_Unit_ID();
    reg [5:0] opcode;
    reg [4:0] ID_RS, ID_RT;
    reg [4:0] MEM_RD, WB_RD;
    reg [31:0] MEM_RD_DATA_I, WB_RD_DATA_I;
    wire [31:0] MEM_RD_DATA_O_RS, MEM_RD_DATA_O_RT;
    wire [31:0] WB_RD_DATA_O_RS, WB_RD_DATA_O_RT;
    wire FW_sig1_RS, FW_sig2_RS;
    wire FW_sig1_RT, FW_sig2_RT;

    Forwarding_Unit_ID FWU_ID (
        .opcode(opcode),
        .ID_RS(ID_RS),
        .ID_RT(ID_RT),
        .MEM_RD(MEM_RD),
        .WB_RD(WB_RD),
        .MEM_RD_DATA_I(MEM_RD_DATA_I),
        .WB_RD_DATA_I(WB_RD_DATA_I),
        .MEM_RD_DATA_O_RS(MEM_RD_DATA_O_RS),
        .MEM_RD_DATA_O_RT(MEM_RD_DATA_O_RT),
        .WB_RD_DATA_O_RS(WB_RD_DATA_O_RS),
        .WB_RD_DATA_O_RT(WB_RD_DATA_O_RT),
        .FW_sig1_RS(FW_sig1_RS),
        .FW_sig2_RS(FW_sig2_RS),
        .FW_sig1_RT(FW_sig1_RT),
        .FW_sig2_RT(FW_sig2_RT)
    );

    initial begin
        $dumpfile("Forwarding_Unit_ID_tb.vcd");
        $dumpvars(0, tb_Forwarding_Unit_ID);

        // Initialize inputs
        opcode = 6'b000000;
        ID_RS = 5'b0;
        ID_RT = 5'b0;
        MEM_RD = 5'b0;
        WB_RD = 5'b0;
        MEM_RD_DATA_I = 32'b0;
        WB_RD_DATA_I = 32'b0;

        // Test case 1: No forwarding required
        #10 opcode = 6'b100011; // LW instruction
        ID_RS = 5'b00010;
        ID_RT = 5'b00011;
        MEM_RD = 5'b00001;
        WB_RD = 5'b00001;
        MEM_RD_DATA_I = 32'h12345678;
        WB_RD_DATA_I = 32'habcdef12;
        #10;

        // Test case 2: Forwarding from MEM stage (RS)
        #10 ID_RS = 5'b00001;
        #10;

        // Test case 3: Forwarding from WB stage (RS)
        #10 MEM_RD = 5'b0;
        #10;

        // Test case 4: Forwarding from MEM stage (RT)
        #10 opcode = 6'b000101; // BNE instruction
        ID_RS = 5'b00010;
        ID_RT = 5'b00011;
        MEM_RD = 5'b00011;
        WB_RD = 5'b00001;
        #10;

        // Test case 5: Forwarding from WB stage (RT)
        #10 MEM_RD = 5'b0;
        #10;

        // Test case 6: Forwarding from both MEM and WB stages (RS and RT)
        #10 MEM_RD = 5'b00001;
        WB_RD = 5'b00011;
        #10;

        // End simulation
        #10 $finish;
    end

endmodule