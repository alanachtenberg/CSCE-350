//Alan Achtenberg
//Lab 6 part 4
//ripple carry adder
//test bench is in seperate file

`include "lab6_4.v" //ripple_carry

module ripple_carry_adder_32bit(S, Cout,A,B,Cin);
	input [31:0] A, B;
    input    Cin;
	output [31:0] S;
    output  Cout;
	
	// 7 intermediate carry outs
	wire [6:0] C;
	
	ripple_carry_adder adder0(S[3:0]  , C[0], A[3:0]  ,	B[3:0]  , Cin);
	ripple_carry_adder adder1(S[7:4]  , C[1], A[7:4]  ,	B[7:4]  , C[0]);
	ripple_carry_adder adder2(S[11:8] , C[2], A[11:8] ,	B[11:8] , C[1]);
	ripple_carry_adder adder3(S[15:12], C[3], A[15:12], B[15:12], C[2]);
	ripple_carry_adder adder4(S[19:16], C[4], A[19:16], B[19:16], C[3]);
	ripple_carry_adder adder5(S[23:20], C[5], A[23:20], B[23:20], C[4]);
	ripple_carry_adder adder6(S[27:24], C[6], A[27:24], B[27:24], C[5]);
	ripple_carry_adder adder7(S[31:28], Cout, A[31:28], B[31:28], C[6]);
	
	endmodule


