//Alan Achtenberg
//Lab 6 part 1
//test


module first_module(out, a, b);
    input    a, b;
    output   out;
    wire     a1, a2;

    not    n1(a1, a);
    and    and1(a2, a, b);
    or     or1(out,a1,a2);
endmodule

module test_first();              /* test bench module for first_module() */
    reg    a, b;
    wire   out;

    first_module fm(out,a,b);

    initial begin
        $monitor ($time,"\ta=%b\tb=%b\tout=%b",a,b,out);
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