// Texas A&M University          //
// cpsc350 Computer Architecture //
// $Id: mux.v,v 1.1 2001/11/07 19:24:39 miket Exp miket $ //
// Multiplexers of various bit-sizes and input to output mapping //
module MUX32_2to1(a0, a1, sel, out);
   input [31:0] a0, a1;
   input 	sel;
   output [31:0] out;
   reg [31:0] 	 out;
   
   always @(a0 or a1 or sel)
      if (sel == 0) out = a0;
      else          out = a1;
endmodule // MUX32_2to1


module MUX32_3to1(a0, a1, a2, sel, out);
   input [31:0] a0, a1, a2;
   input [1:0] 	sel;
   output [31:0] out;
   reg [31:0] 	 out;
   
   always @(a0 or a1 or a2 or sel)
      if (sel == 0) out = a0;
      else if (sel == 1) out = a1;
	   else out = a2;
endmodule // MUX32_3to1


module MUX5_2to1(a0, a1, sel, out);
   input [4:0]  a0, a1;
   input 	sel;
   output [4:0] out;
   reg [4:0] 	out;
   
   always @(a0 or a1 or sel)
      if (sel == 0) out = a0;
      else          out = a1;
endmodule // MUX5_2to1

