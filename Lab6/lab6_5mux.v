//Alan Achtenberg
//Lab 6 part 5
//Multiplexer


module	mux_4x1(Out, In, Select);

	output	Out;	//only one output
	reg Out;
	input [3:0] In;		//input to be selection
	input [1:0] Select; //2bit selection
	
	
	always @ (In or Select)
	case (Select)
	2'b00: Out=In[0];
	2'b01: Out=In[1];
	2'b10: Out=In[2];
	2'b11: Out=In[3];
	endcase
endmodule


module full_adder_mux(S, Cout,A,B,Cin);
	input A, B;
    input   Cin;
	output	S;
    output  Cout;
	reg [3:0] input1, input2;
	reg	[1:0] select1,select2;
	
	always @ (A or B or Cin) begin
	input1[0]=A;
	input1[1]=~A;
	input1[2]=~A;
	input1[3]=A;
	
	select1[0]=Cin;
	select1[1]=B;
	
	input2[0]=1'b0;
	input2[1]=A;
	input2[2]=A;
	input2[3]=1'b1;
	select2[0]=Cin;
	select2[1]=B;
	end
	
	mux_4x1 sum(S, input1, select1);
	mux_4x1 carry(Cout, input2, select1);
endmodule



//testbench for full adder


module full_adder_test();              /* test bench module for first_module() */
    reg    a, b, cin;
    wire   S, Cout;

    full_adder_mux test(S,Cout,a,b,cin);

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





