`timescale 1ns / 1ps

module tb_Forwarding_Unit_EX;
    reg [5:0] opcode;
    reg [4:0] EX_RS, EX_RT;
    reg [4:0] MEM_RD, WB_RD;
    reg [31:0] MEM_RD_DATA_I, WB_RD_DATA_I;
    reg ALUSrc;
    wire [31:0] MEM_RD_DATA_O, WB_RD_DATA_O;
    wire FW_sig1, FW_sig2;

    // Instantiate the forwarding_unit_EX module
    Forwarding_Unit_EX forwarding_unit_ex (
        .opcode(opcode),
        .EX_RS(EX_RS),
        .EX_RT(EX_RT),
        .MEM_RD(MEM_RD),
        .WB_RD(WB_RD),
        .MEM_RD_DATA_I(MEM_RD_DATA_I),
        .WB_RD_DATA_I(WB_RD_DATA_I),
        .ALUSrc(ALUSrc),
        .MEM_RD_DATA_O(MEM_RD_DATA_O),
        .WB_RD_DATA_O(WB_RD_DATA_O),
        .FW_sig1(FW_sig1),
        .FW_sig2(FW_sig2)
    );

    // Stimulus and test scenarios
    initial begin
        $display("Time(ns) | opcode | EX_RS | EX_RT | MEM_RD | WB_RD | MEM_RD_DATA_I | WB_RD_DATA_I | ALUSrc | MEM_RD_DATA_O | WB_RD_DATA_O | FW_sig1 | FW_sig2");
        $display("---------|--------|-------|-------|--------|-------|---------------|-------------|-------|---------------|-------------|--------|-------");

        // Scenario 1
        opcode = 6'b100011;
        EX_RS = 5'b00010;
        EX_RT = 5'b00011;
        MEM_RD = 5'b00010;
        WB_RD = 5'b00100;
        MEM_RD_DATA_I = 32'h0000_000A;
        WB_RD_DATA_I = 32'h0000_0005;
        ALUSrc = 0;
        #10;

        // Scenario 2
        opcode = 6'b100011;
        EX_RS = 5'b00010;
        EX_RT = 5'b00011;
        MEM_RD = 5'b00100;
        WB_RD = 5'b00010;
        MEM_RD_DATA_I = 32'h0000_000A;
        WB_RD_DATA_I = 32'h0000_0005;
        ALUSrc = 0;
        #10;

        // Scenario 3
        opcode = 6'b100011;
        EX_RS = 5'b00010;
        EX_RT = 5'b00011;
        MEM_RD = 5'b00010;
        WB_RD = 5'b00010;
        MEM_RD_DATA_I = 32'h0000_000A;
        WB_RD_DATA_I = 32'h0000_0005;
        ALUSrc = 1;
        #10;

        // Scenario 4
        opcode = 6'b100011;
        EX_RS = 5'b00010;
        EX_RT = 5'b00011;
        MEM_RD = 5'b00100;
        WB_RD = 5'b00100;
        MEM_RD_DATA_I = 32'h0000_000A;
        WB_RD_DATA_I = 32'h0000_0005;
        ALUSrc = 0;
        #10;

        $finish;
    end

    // Monitor the outputs
    always @(posedge ALUSrc or posedge opcode or posedge EX_RS or posedge EX_RT or posedge MEM_RD or posedge WB_RD or posedge MEM_RD_DATA_I or posedge WB_RD_DATA_I) begin
        $display("%9d | %6b | %5b | %5b | %6b | %5b | %13h | %12h | %5b | %13h | %12h | %6b | %5b",
                 $time, opcode, EX_RS, EX_RT, MEM_RD, WB_RD, MEM_RD_DATA_I, WB_RD_DATA_I, ALUSrc,
                 MEM_RD_DATA_O, WB_RD_DATA_O, FW_sig1, FW_sig2);
    end

endmodule