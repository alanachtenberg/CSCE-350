// ------------------------------------------------------------------------ //
// Texas A&M University                                                     //
// CPSC350 Computer Architecture                                            //
//                                                                          //
// $Id: ALU_behav.v,v 1.3 2002/11/14 16:06:04 miket Exp miket $             //
//                                                                          //
// ------------------------------------------------------------------------ //

// ------------------------------------------------------------------------ //
// Behavioral Verilog Module for a MIPS-like ALU                            //
// -- In continuous and procedure assignments Verilog extends the smaller   //
// operands by replicating their MSB, if it is equal to x, z; otherwise     //
// operends them with 0's. Arithmetic is interpreted as 2's C               //
// -- regs are considered as unsigned bit-vectors but the all arithmetic    //
// is done in 2's complement.                                               //
// At ALU instatiation time parameter n determines the ALU bit-size         //
// ------------------------------------------------------------------------ //

// repetoire of operations for ALU, selected by ALU_ctr (change at will)
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

`define SLL 4'b1000 // Shift logical left
`define SRL 4'b1100 // Shift logical right
`define SRA 4'b1110 // Shift arithmetic right
`define BNE 4'b1001  // Branch if not equal


module ALU_behav( ADin, BDin, ALU_ctr, Result, Overflow, Carry_in, Carry_out, Zero ); 

   parameter n = 32, Ctr_size = 4;

   input     Carry_in;
   input [Ctr_size-1:0] ALU_ctr;
   input [n-1:0] 	ADin, BDin;
   output [n-1:0] 	Result;
   reg [n-1:0] 		Result, tmp;
   output 		Carry_out, Overflow, Zero;
   reg 			Carry_out, Overflow, Zero;

   always @(ALU_ctr or ADin or BDin or Carry_in)
     begin
	 case(ALU_ctr)
	   `ADD:  begin
	      {Carry_out, Result} = ADin + BDin + Carry_in;
	      Overflow = ADin[n-1] & BDin[n-1] & ~Result[n-1]
			 | ~ADin[n-1] & ~BDin[n-1] & Result[n-1];
	   end
	   `ADDU: {Overflow, Result} = ADin + BDin + Carry_in;
	   `SUB:  begin
	      {Carry_out, Result} = ADin - BDin;
	      Overflow = ADin[n-1] & ~BDin[n-1] & Result[n-1]
			 | ~ADin[n-1] & BDin[n-1] & ~Result[n-1];
	   end
	   `SUBU: {Overflow, Result} = ADin - BDin;
	   `SLT:  begin
	      {Carry_out, tmp} = ADin - BDin;
	      Overflow = ADin[n-1] & ~BDin[n-1] & ~tmp[n-1] 
			 | ~ADin[n-1] & BDin[n-1] & tmp[n-1];
	      $display("\nSLT:- [%d] tmp = %d [%b]; Cout=%b, Ovf=%b; A=%d, B=%d",
		       $time, tmp, tmp, Carry_out, Overflow, ADin, BDin );
	      
	      Result = tmp[n-1] ^ Overflow;
	      $display("\nSLT:+R=%d [%b]", Result, Result );

	   end
	   `SLTU: begin
	      {Carry_out, tmp} = ADin - BDin;
	      $display("SLTU:- [%d] tmp = %d [%b]; Cout=%b, Ovf=%b; A=%d, B=%d",
		       $time, tmp, tmp, Carry_out, Overflow, ADin, BDin );
	      Result = Carry_out;
	      $display("SLTU:+R=%d [%b]", Result, Result );
	   end
	   `OR :  Result = ADin | BDin;
	   `AND:  Result = ADin & BDin;
	   `XOR:  Result = ADin ^ BDin;
	   `NOP:  Result = ADin;
	   `SLL:  Result = ADin << BDin;
	   `SRL:  Result = ADin >> BDin;
	   `SRA:  Result = $signed(ADin) >>> BDin;
	   `BNE:  if ((ADin-BDin)!=0)Result =0 ;// Branch if not equal
	   `NOP: Result= 1'bZ;
	 endcase
	 
	 Zero = ~| Result;  // Result = 32'b0
      end
	 /* always @ (Result)
	  begin
	  $display("%0d\t ADin = %0d BDin = %0d; Result = %0d; Cout = %b Ovfl = %b Zero = %b OP = %b",  $time, ADin, BDin, Result, Carry_out, Overflow, Zero, ALU_ctr ); 
	  end
	 */
endmodule

// this is a test bench to test the ALU in isolation (without fetching instructions from instruction memory)
// uncomment it only when you are testing

// module TestALU;

   // parameter n = 32, Ctr_size = 4;

   // reg [n-1:0] A, B, T;
   // wire [n-1:0]  R, tt;
   // reg 	       Carry_in;
   // wire        Carry_out, Overflow, Zero;
   
   // reg [Ctr_size-1:0] ALU_ctr;

   // integer 	      num;
   
   // ALU_behav ALU( A, B, ALU_ctr, R, Overflow, Carry_in, Carry_out, Zero );
   
   // always @( R or Carry_out or Overflow or Zero )
      // begin
	 // $display("%0d\tA = %0d B = %0d; R = %0d; Cout = %b Ovfl = %b Zero = %b OP = %b n = %d",  $time, A, B, R, Carry_out, Overflow, Zero, ALU_ctr, num );  
	 // num = num + 1;
      // end
   
   // initial begin
      // #0 num = 0; Carry_in = 0; 
      // #1 A = 101; B = 0; ALU_ctr = `NOP;
      // #10 A = 10; B = 10; ALU_ctr = `ADD;
      // #10 A = 10; B = 20; ALU_ctr = `ADDU;
      // #10 A = 10; B = 20; ALU_ctr = `SLT;
      // #10 A = 10; B = 20; ALU_ctr = `SLTU;
      // #10 A = 32'hffffffff; B = 1; ALU_ctr = `ADDU;
      // #10 A = 10; B = 10; ALU_ctr = `ADDU;
      // #10 A = 10; B = 10; ALU_ctr = `SUB;
      // #10 A = 1; B = 1; ALU_ctr = `SUBU;
      // #10 A = 10; B = 10; ALU_ctr = `SUB;
      // #10 A = 10; B = 10; ALU_ctr = `SUBU;
      // #10 A = -13; B = -12; ALU_ctr = `SLT;
      // #100 $finish;
   // end
// endmodule