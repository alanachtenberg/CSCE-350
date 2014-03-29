//Alan Achtenberg
//Lab 6 part 2
//half adder

module half_adder(S, C, A, B);
	
	input A, B;
	output S, C;
	
	xor (S, A, B);
	and (C, A, B);
	
endmodule

