
`include "lab6_3.v"

//testbench for full adder


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