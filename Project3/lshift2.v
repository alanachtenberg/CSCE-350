// Texas A&M University          //
// cpsc350 Computer Architecture //
// $Id: lshift2.v,v 1.2 2002/04/08 23:39:07 miket Exp miket $ //

module LSHIFT2(in, out);
   input [31:0] in;
   output [31:0] out;
   assign out[31:2] = in[29:0];
   assign out[1] = 0;
   assign out[0] = 0;
endmodule


/*
 module test;
 wire [31:0] out;
 reg [31:0] in;
 
 LSHIFT2 ls2(in,out);
 
 initial begin	
 $monitor($time, " in=%d out=%d",in,out);
 in = 0;
 #1 in = 1;
 #1 in = in * 2;
 #1 in = in * 2;
 #1 in = in * 2;
 #1 in = in * 2;
 #1 in = in * 2;
 #1 in = in * 2;
 #1 in = in * 2;
 #1 in = in * 2;
 #1 in = in * 2;
 #1 in = in * 2;
 #1 in = in * 2;
 #1 in = (1 << 15) - 1;
 #1 $finish;
end
 endmodule
 */