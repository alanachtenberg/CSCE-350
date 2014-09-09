// Texas A&M University          //
// cpsc350 Computer Architecture //
//Alan Achtenberg??
//Project 2//


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



// Top Level Architecture Model //
`include "Control.v"
`include "IdealMemory.v"
`include "PC.v"
`include "RegisterFile.v"
`include "mux.v"
`include "ALU_bhav.v"
`include "signextend.v"
`include "ALUControl.v"
`include "DataMemory.v"
/*-------------------------- CPU -------------------------------
 * This module implements a single-cycle
 * CPU similar to that described in the text book 
 * (for example, see Figure 5.19). 
 *
 */

//
// Input Ports
// -----------
// clock - the system clock (m555 timer).
//
// reset - when asserted by the test module, forces the processor to 
//         perform a "reset" operation.  (note: to reset the processor
//         the reset input must be held asserted across a 
//         negative clock edge).
//   
//         During a reset, the processor loads an externally supplied
//         value into the program counter (see startPC below).
//   
// startPC - during a reset, becomes the new contents of the program counter
//	     (starting address of test program).
// 
// Output Port
// -----------
// dmemOut - contains the data word read out from data memory. This is used
//           by the test module to verify the correctness of program 
//           execution.
//-------------------------------------------------------------------------

module SingleCycleProc(CLK, Reset_L, startPC, dmemOut);
   input 	Reset_L, CLK;
   input [31:0] startPC;
   output [31:0] dmemOut;
	
	wire [31:0] PC;
	wire [31:0] Instr;
	wire [31:0] ALUin, Result; 
	wire ALUzero;

//
// INSERT YOUR CPU MODULES HERE
    
	wire RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend;
	wire [31:0]Immediate; //Sign extended value
	wire [31:0] MemData, ALUresult;
	ProgramCounter PC1(PC, PC, Reset_L, startPC,CLK,Jump,ALUzero,Branch,Instr[25:0],Immediate);
	
	InstrMem IM1(PC, Instr);
	
	
	wire [3:0]ALUOp;
	
	Control_Unit C1(RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend, ALUOp, Instr[31:26]);
	
	wire [3:0] ALUctrl;
	
	ALUControl AC1(ALUctrl, ALUOp,Instr[5:0]);
	
	wire [4:0] Waddr;
	
	MUX5_2to1 mux1(Instr[20:16], Instr[15:11], RegDst, Waddr );

	wire [31:0]Read1, Read2, Writedata;
	
	RegisterFile RF1(Read1, Read2, Writedata, Instr[25:21],Instr[20:16], Waddr, RegWrite, CLK, Reset_L);
	
	
	SIGN_EXTEND SE1(Instr[15:0], Immediate);
	
	
	
	MUX32_2to1 mux2(Read2, Immediate, ALUSrc, ALUin);
	ALU_behav ALU1( Read1, ALUin, ALUctrl, ALUresult, Overflow, 1'b0, Carry_out, ALUzero ); 
	
	DataMem dm( MemData, ALUresult, Read2, MemRead, MemWrite, CLK, Reset_L);
	MUX32_2to1 memmux(ALUresult, MemData, MemToReg, Writedata);
	

//
// Debugging 
//
	/*
	always @(RegDst or Waddr)
	begin
		$display("RegDst %b Waddr %d" , RegDst, Waddr );
	end
	*/
	
     //Monitor changes in the program counter
/*   always @(PC)
	begin
     #10 $display($time," PC=%d Instr: op=%d rs=%d rt=%d rd=%d imm16=%d funct=%d",
	PC,Instr[31:26],Instr[25:21],Instr[20:16],Instr[15:11],Instr[15:0],Instr[5:0]);
	end
 */

   /*   Monitors memory writes
   always @(MemWrite)
	begin
	#1 $display($time," MemWrite=%b clock=%d addr=%d data=%d", 
	            MemWrite, clock, dmemaddr, rportb);
	end
   */
   
   /*always @(Instr)
	begin
     #10 $display($time,"OPCODE=%b, ALUctrl=%b , ALUOp=%b", Instr[31:26],ALUctrl, ALUOp);
	end
	*/
   
endmodule // CPU


module m555 (CLK);
   parameter StartTime = 0, Ton = 50, Toff = 50, Tcc = Ton+Toff; // 
 
   output CLK;
   reg 	  CLK;
   
   initial begin
      #StartTime CLK = 0;
   end
   
   // The following is correct if clock starts at LOW level at StartTime //
   always begin
      #Toff CLK = ~CLK;
      #Ton CLK = ~CLK;
   end
endmodule

   
module testCPU(Reset_L, startPC, testData);
   input [31:0] testData;
   output 	Reset_L;
   output [31:0] startPC;
   reg 		 Reset_L;
   reg [31:0] 	 startPC;
   
   initial begin
      // Your program 1
      Reset_L = 0;  startPC = 0 * 4;
      #101 // insures reset is asserted across negative clock edge
	  Reset_L = 1; 
      #4000; // allow enough time for program 1 to run to completion
      Reset_L = 0;
     // #1 $display ("Program 1: Result: %d", testData);
      
      // Your program 2
      //startPC = 14 * 4;
      //#101 Reset_L = 1; 
      //#10000;
      //Reset_L = 0;

      //#1 $display ("Program 2: Result: %d", testData);
      
      // etc.
      // Run other programs here
      
      
      $finish;
   end
endmodule // testCPU

module TopProcessor;
   wire reset, CLK, Reset_L;
   wire [31:0] startPC;
   wire [31:0] testData;
   
   m555 system_clock(CLK);
   SingleCycleProc SSProc(CLK, Reset_L, startPC, testData);
   testCPU tcpu(Reset_L, startPC, testData); 

endmodule // TopProcessor