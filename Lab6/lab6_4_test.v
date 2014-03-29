
//Test bench for 4 bit ripple carry adder

`include "lab6_4.v"


module ripple_carry_adder_test();              /* test bench module for first_module() */
    reg  [3:0]    A, B;
	reg	   C0;
    wire  [3:0] S; 
	wire Cout;

    ripple_carry_adder test(S,Cout,A,B,C0);
initial begin
		$monitor($time, "\tA=%d\tB=%d\tCin=%b\tS=%d\tCout=%b", A, B, C0, S, Cout);
		
		A = 0;	B = 0;	C0 = 0;
		#1
		A = 0;	B = 0;	C0 = 1;
		#1
		A = 0;	B = 1;	C0 = 0;
		#1
		A = 1;	B = 0;	C0 = 0;
		#1
		A = 1;	B = 1;	C0 = 0;
		#1
		A = 1;	B = 1;	C0 = 1;
		#1
		A = 7;	B = 7;	C0 = 0;
		#1
		A = 7;	B = 7;	C0 = 1;
		#1
		A = 15;	B = 0;	C0 = 0;
		#1
		A = 15;	B = 0;	C0 = 1;
		#1
		A = 15;	B = 1;	C0 = 0;
		#1
		A = 15;	B = 1;	C0 = 1;
		#1
		A = 0;	B = 15;	C0 = 0;
		#1
		A = 0;	B = 15;	C0 = 1;
		#1
		A = 1;	B = 15;	C0 = 0;
		#1
		A = 1;	B = 15;	C0 = 1;
		#1
		A = 15;	B = 15;	C0 = 0;
		#1
		A = 15;	B = 15;	C0 = 1;
		#1
		$finish;
	end
endmodule

