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


