//Alan Achtenberg
//Lab 6 part 3
//Full Adder




module full_adder(S, Cout,A,B,Cin);

    input    A, B, Cin;
    output   S, Cout;
    wire     xor11, xor12,xor13, xor14;	//intermediaries 
	wire     xor21, xor22,xor23;//wire order from diagram left bottom top right
	
    nand	nand1(xor11, A, B);
	nand	nand2(xor12, xor11, B);
	nand	nand3(xor13, xor11, A);
	nand	nand4(xor14, xor12, xor13);
	
	nand	nand5(xor21, xor14, Cin);
	nand	nand6(xor22, xor21, Cin);
	nand	nand7(xor23, xor14, xor21);
	nand	nand8(S, xor22, xor23); //output s
	
	nand	nand9(Cout, xor21, xor11);
	
   
endmodule

module full_adder_test();              /* test bench module for first_module() */
    reg    a, b, cin;
    wire   S, Cout;

    full_adder test(S,Cout,a,b,cin);

    initial begin
        $monitor ($time,"\ta=%b\tb=%b\tcin=%b\tsum=%b\tcarry=%b",a,b,cin, S, Cout);
		
        a = 0; b = 0; cin=0;
        #1 
         a = 0; b = 0; cin=1;
        #1
         a = 0; b = 1; cin=0;
        #1
         a = 0; b = 1; cin=1;
        #1 
		 a = 1; b = 0; cin=0;
        #1 
         a = 1; b = 0; cin=1;
        #1
         a = 1; b = 1; cin=0;
        #1
         a = 1; b = 1; cin=1;
		#1
        $finish;
    end
endmodule