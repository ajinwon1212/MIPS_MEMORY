`timescale 1ns / 1ns  

module Top_module_TB;
        
	reg clk, rst;
	wire [7:0] PC_next; 
	wire [5:0] opcode, funct;// funct2;
	wire [4:0] rs, rt, rd, shamt, shift;
	wire RegDst, ALUSrc, MemtoReg, Regwrite, MemRead, MemWrite; //Branch, zero;// jump;
	wire [1:0] ALUOp;
	wire [31:0] instruction, readata1, readata2, ALUinput1, ALUinput2, ALUresult, Readata, outdata;
	wire [15:0] offset;
	wire [31:0] sign_extend;
	wire [3:0] ALUcontrol;   

 	Top_module UUT(
		.rst(rst),
		.clk(clk), 
		.PC_next(PC_next), 
		.opcode(opcode),
		.funct(funct),
		//.funct2(funct2),
		.rs(rs), 
		.rt(rt), 
		.rd(rd), 
		.shamt(shamt),
		.shift(shift),
		.RegDst(RegDst),
		.ALUSrc(ALUSrc),
		.MemtoReg(MemtoReg),
		.Regwrite(Regwrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		//.Branch(Branch),
		//.zero(zero),
		//.jump(jump),
		.ALUOp(ALUOp),
		.instruction(instruction),
		.readata1(readata1), 
		.readata2(readata2), 
		.ALUinput1(ALUinput1), 
		.ALUinput2(ALUinput2),
        .ALUresult(ALUresult),
		.Readata(Readata), 
		.outdata(outdata),
		.offset(offset),
		.sign_extend(sign_extend),
		.ALUcontrol(ALUcontrol)
	);   
         
	initial
	begin
		rst = 1'b1;
		#1 rst = 1'b0; 
	end

	initial
	begin
		clk = 1'b0;
		forever
		begin
			#10 clk = !clk;
		end
	end

endmodule