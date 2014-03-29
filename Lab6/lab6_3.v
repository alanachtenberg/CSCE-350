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
