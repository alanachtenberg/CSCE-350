//Alan Achtenberg
//Lab 6 part 5
//Decoder


module	dec_3x8(Out, In);

	output [7:0]Out;	//only one output
	reg	   [7:0]Out;
	input  [2:0] In;		//input to be selection
	
	always @ (In)
	case (In)
	3'b000: Out=8'b00000001;
	3'b001: Out=8'b00000010;
	3'b010: Out=8'b00000100;
	3'b011: Out=8'b00001000;
	3'b100: Out=8'b00010000;
	3'b101: Out=8'b00100000;
	3'b110: Out=8'b01000000;
	3'b111: Out=8'b10000000;
	endcase
endmodule


module full_adder_dec(S, Cout,A,B,Cin);
	input A, B;
    input   Cin;
	output	S;
    output  Cout;
	
	reg [2:0] input1;
	wire	[7:0] output1;
	always @ (A or B or Cin) begin
	input1[0]=Cin;
	input1[1]=B;
	input1[2]=A;
	end
	
	dec_3x8 d1(output1,input1);
	
	or or1(S,output1[1],output1[2],output1[4],output1[7]);
	or or2(Cout,output1[3],output1[5],output1[6],output1[7]);
endmodule



//testbench for full adder


module full_adder_test();              /* test bench module for first_module() */
    reg    a, b, cin;
    wire   S, Cout;

    full_adder_dec test(S,Cout,a,b,cin);

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





