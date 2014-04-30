//Alan Achtenberg
//Project 2
//Processor Control Unit

`define OPCODE_ADD     6'b000000
`define OPCODE_SUB     6'b000000
`define OPCODE_ADDU    6'b000000
`define OPCODE_SUBU    6'b000000
`define OPCODE_AND     6'b000000
`define OPCODE_OR      6'b000000
`define OPCODE_SLL     6'b000000
`define OPCODE_SRA     6'b000000
`define OPCODE_SRL     6'b000000
`define OPCODE_SLT     6'b000000
`define OPCODE_SLTU    6'b000000
`define OPCODE_XOR     6'b000000
`define OPCODE_JR      6'b000000
//I-Type (All opcodes except 000000, 00001x, and 0100xx)
`define OPCODE_ADDI    6'b001000
`define OPCODE_ADDIU   6'b001001
`define OPCODE_ANDI    6'b001100
`define OPCODE_BEQ     6'b000100
`define OPCODE_BNE     6'b000101
`define OPCODE_BLEZ    6'b000110
`define OPCODE_BLTZ    6'b000001
`define OPCODE_ORI     6'b001101
`define OPCODE_XORI    6'b001110
`define OPCODE_NOP     6'b110110
`define OPCODE_LUI     6'b001111
`define OPCODE_SLTI    6'b001010
`define OPCODE_SLTIU   6'b001011
`define OPCODE_LB      6'b100000
`define OPCODE_LW      6'b100011
`define OPCODE_SB      6'b101000
`define OPCODE_SW      6'b101011
// J-Type (Opcode 00001x)
`define OPCODE_J       6'b000010
`define OPCODE_JAL     6'b000011

`define ADD  4'b0111 // 2's compl add
`define ADDU 4'b0001 // unsigned add
`define SUB  4'b0010 // 2's compl subtract
`define SUBU 4'b0011 // unsigned subtract
`define AND  4'b0100 // bitwise AND
`define OR   4'b0101 // bitwise OR
`define XOR  4'b0110 // bitwise XOR
`define SLT  4'b1010 // set result=1 if less than 2's compl
`define SLTU 4'b1011 // set result=1 if less than unsigned
`define NOP  4'b0000 // do nothing


module Control_Unit(RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend, ALUOp, Opcode);
   input [5:0] Opcode;
   output RegDst;
   output ALUSrc;
   output MemToReg;
   output RegWrite;
   output MemRead;
   output MemWrite;
   output Branch;
   output Jump;
   output SignExtend;
   output [3:0] ALUOp;
	 
	reg	RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend;
	reg  [3:0] ALUOp;
	always @ (Opcode) begin
		case(Opcode)
			6'b000000: begin
				RegDst <=  1;
				ALUSrc <= 0;
				MemToReg <= 0;
				RegWrite <= 1;
				MemRead <= 0;
				MemWrite <= 0;
				Branch <= 0;
				Jump <= 0;
				SignExtend <= 1'bX;
				ALUOp <= 4'b1111;
			end

			`OPCODE_ADDI: begin
				RegDst <= 0;
				ALUSrc <= 1;
				MemToReg <= 0;
				RegWrite <= 1;
				MemRead <= 0;
				MemWrite <= 0;
				Branch <= 0;
				Jump <= 0;
				SignExtend <= 1;
				ALUOp <= `ADD;
			end
			`OPCODE_ADDIU: begin
				RegDst <= 0;
				ALUSrc <= 1;
				MemToReg <= 0;
				RegWrite <= 1;
				MemRead <= 0;
				MemWrite <= 0;
				Branch <= 0;
				Jump <= 0;
				SignExtend <= 1;
				ALUOp <= `ADDU;
			end
			`OPCODE_NOP: begin
				RegDst <= 1'bX;
				ALUSrc <= 1'bX;
				MemToReg <= 1'bX;
				RegWrite <= 1'bX;
				MemRead <= 1'bX;
				MemWrite <= 1'bX;
				Branch <= 1'bX;
				Jump <= 1'bX;
				SignExtend <= 1'bX;
				ALUOp <= `NOP;
			end
				
		
		endcase
	end
endmodule