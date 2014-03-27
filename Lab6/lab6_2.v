//Alan Achtenberg
//Lab 6 part 2
//half adder

module half_adder(S, C, A, B);
	
	input A, B;
	output S, C;
	
	xor (S, A, B);
	and (C, A, B);
	
endmodule

module half_adder_test();

	reg    a, b;
    wire   sum;
	wire   carry;

    half_adder test(sum,carry,a,b);

    initial begin
        $monitor ($time,"\ta=%b\tb=%b\tsum=%b\tcarry=%b",a,b, sum, carry);
        a = 0; b = 0;
        #1 
        a = 0; b = 1;
        #1
        a = 1; b = 0;
        #1
        a = 1; b = 1;
        #1 
        $finish;
    end
endmodule
	