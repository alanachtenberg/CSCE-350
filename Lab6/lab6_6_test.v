
//Test bench for 32 bit ripple carry adder

`include "lab6_6.v"


module ripple_carry_adder_test();              /* test bench module for first_module() */
    reg  [31:0]    A, B;
	reg	   C0;
    wire  [31:0] S; 
	wire Cout;

    ripple_carry_adder_32bit test(S,Cout,A,B,C0);
initial begin
		$monitor($time, "\tA=%d\tB=%d\tCin=%b\tS=%d\tCout=%b", A, B, C0, S, Cout);
		
		A = 0;		B = 0;		C0 = 0;
		#1
		A = 0;		B = 0;		C0 = 1;
		#1
		A = 0;		B = 1;		C0 = 0;
		#1
		A = 1;		B = 0;		C0 = 0;
		#1
		A = 1;		B = 1;		C0 = 0;
		#1
		A = 1;		B = 1;		C0 = 1;
		#1
		A = 16777215;	B = 16777215;	C0 = 0;
		#1
		A = 16777215;	B = 16777215;	C0 = 1;
		#1
		A = 4294967295;	B = 0;		C0 = 0;
		#1
		A = 4294967295;	B = 0;		C0 = 1;
		#1
		A = 4294967295;	B = 1;		C0 = 0;
		#1
		A = 4294967295;	B = 1;		C0 = 1;
		#1
		A = 0;		B = 4294967295;	C0 = 0;
		#1
		A = 0;		B = 4294967295;	C0 = 1;
		#1
		A = 1;		B = 4294967295;	C0 = 0;
		#1
		A = 1;		B = 4294967295;	C0 = 1;
		#1
		A = 4294967295;	B = 4294967295;	C0 = 0;
		#1
		A = 4294967295;	B = 4294967295;	C0 = 1;
		#1
		$finish;
	end
endmodule

