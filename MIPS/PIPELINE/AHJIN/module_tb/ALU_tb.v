`timescale 1ns / 1ps

module ALU_tb;
    reg CLK;
    reg signed [31:0] ALU_IN_1, ALU_IN_2;
    reg [3:0] ALU_control;
    reg [4:0] Shampt;
    wire ALU_zero;
    wire signed [31:0] ALU_result;
    wire signed [31:0] Hi, Lo;

    // Instantiate ALU module
    ALU my_ALU (
        .CLK(CLK),
        .ALU_IN_1(ALU_IN_1),
        .ALU_IN_2(ALU_IN_2),
        .ALU_control(ALU_control),
        .Shampt(Shampt),
        .ALU_zero(ALU_zero),
        .ALU_result(ALU_result),
        .Hi(Hi),
        .Lo(Lo)
    );

    // Clock generation
    always begin
        #5 CLK = ~CLK;
    end

    initial begin
        // Initialize inputs
        CLK = 0;
        ALU_IN_1 = 32'd10;
        ALU_IN_2 = 32'd5;

        // ADD operation
        ALU_control = 4'b0000;
        #10;
        $display("ADD result: %d, ALU_zero: %b", ALU_result, ALU_zero);

        // SUB operation
        ALU_control = 4'b0100; 
        #10;
        $display("SUB result: %d, ALU_zero: %b", ALU_result, ALU_zero);

        // AND operation
        ALU_control = 4'b1000; 
        #10;
        $display("AND result: %d, ALU_zero: %b", ALU_result, ALU_zero);

        // OR operation
        ALU_control = 4'b1010; 
        #10;
        $display("OR result: %d, ALU_zero: %b", ALU_result, ALU_zero);

        // SLT operation
        ALU_control = 4'b0101;
        #10;
        $display("SLT result: %d, ALU_zero: %b", ALU_result, ALU_zero);

        // SHIFT_LEFT operation
        ALU_control = 4'b0010;
        Shampt = 5'b00010; // shift left by 2
        #10;
        $display("SHIFT_LEFT result: %d, ALU_zero: %b", ALU_result, ALU_zero);

        // SHIFT_RIGHT operation
        ALU_control = 4'b0011;
        Shampt = 5'b00010; // shift right by 2
        #10;
        $display("SHIFT_RIGHT result: %d, ALU_zero: %b", ALU_result, ALU_zero);

        // DIV operation
        ALU_control = 4'b1011;
        #10;
        $display("DIV result: quotient = %d, remainder = %d", Lo, Hi);

        // MULT operation
        ALU_control = 4'b1101;
        #10;
        $display("MULT result: Hi = %d, Lo = %d", Hi, Lo);

        // MUL operation
        ALU_control = 4'b1001;
        #10;
        $display("MUL result: %d, ALU_zero: %b", ALU_result, ALU_zero);

        // Finish the simulation
        $finish;
    end
endmodule
