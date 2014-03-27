//Alan Achtenberg
//Lab 6 part 4
//ripple carry adder


`include "lab6_3.v"

module ripple_carry_adder(S, Cout,A,B,Cin);
	input [3:0] A, B;
    input    Cin;
	output [3:0] S;
    output  Cout;
	
	// 3 intermediate carry outs
	wire [2:0] C;
	
	full_adder adder0(S[0], C[0], A[0], B[0], Cin);
	full_adder adder1(S[1], C[1], A[1], B[1], C[0]);
	full_adder adder2(S[2], C[2], A[2], B[2], C[1]);
	full_adder adder3(S[3], Cout, A[3], B[3], C[2]);

	endmodule

module ripple_carry_adder_test();              /* test bench module for first_module() */
    reg    A, B, C0;
    wire   S, Cout;

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

