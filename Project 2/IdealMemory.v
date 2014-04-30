// Texas A&M University          //
// cpsc350 Computer Architecture //
// $Id: IdealMemory.v,v 1.3 2002/11/19 00:58:22 miket Exp miket $ //

// InstrMem is an asynchronous read memory model //
// MemSize Wordise parameterize the memory module at instantiation time //
module InstrMem (Mem_Addr, Dout);

   parameter T_rd = 10;
   parameter MemSize = 1024, WordSize = 32;
   
   input  [WordSize-1:0] Mem_Addr;
   output [WordSize-1:0] Dout;
   reg [WordSize-1:0] Dout;
   
   reg [WordSize-1:0] 	 Mem[0:MemSize-1];   // register array (SRAM) 
   
   //`include "imeminit.v"
   // Include your test program file here instead of "imeminit.v"
    `include "imeminit_simple_test.v"
always
      #T_rd assign  Dout = Mem[ Mem_Addr >> 2 ];
endmodule // Imem

// DataMem is an asynchronous read, synchronous write memory model //
// This memory cannot be read and written to simultaneously        //
module DataMem (Mem_Addr, CLK, Mem_rd, Mem_wr, Mem_DIN, Mem_DOUT);

   parameter T_rd = 10, T_wr = 10;
   parameter MemSize = 1024, WordSize = 32;

   input [WordSize-1:0] Mem_Addr;
   input 		CLK, Mem_rd, Mem_wr;
   input [WordSize-1:0] Mem_DIN;
   output [WordSize-1:0] Mem_DOUT;
   reg [WordSize-1:0] 	 Mem_DOUT;
   
   reg [WordSize-1:0] 	 Mem[0:MemSize-1];
   integer 		 i;
   
   `include "dmeminit.v"
      
   always @( Mem_Addr or Mem_rd )
	 if ( ~Mem_wr && Mem_rd )
	    Mem_DOUT <=  #T_rd Mem[Mem_Addr >> 2];

   
   always @(negedge CLK)
     if (Mem_wr == 1)
	 begin
	    // $display ($time, " . . . ", ..., Mem_DIN); 
	    Mem[Mem_Addr >> 2] <= #T_wr Mem_DIN;
	 end

   
endmodule // Dmem