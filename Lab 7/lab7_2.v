//Alan Achtenberg
//Lab 7
//Part 2

module Dlatch (q,qbar,clock,data);
	output q, qbar;
	input clock, data;
	wire nand1, nand2;
	wire databar;
	not #1	 (databar,data);
	nand #1 (nand1,clock, data);
	nand #1 (nand2,clock, databar);
	nand #1 (qbar,nand2,q);
	nand #1 (q,nand1,qbar);
	
endmodule

module m555(clock);
    parameter InitDelay = 10, Ton = 50, Toff = 50;
    output clock;
    reg clock;

    initial begin
        #InitDelay clock = 1;
    end

    always begin
        #Ton clock = ~clock;
        #Toff clock = ~clock;
    end
endmodule

module testD(q, qbar, clock, data);
    input  q, qbar, clock;
    output data;
    reg    data;

    initial begin
        $monitor ($time, " q = %d, qbar = %d, clock = %d, data = %d", q, qbar, clock, data);
        data = 0;
        #25  
        data = 1;
        #100 
        data = 0;
        #50 
        data = 1;
        #50 
        data = 0;
        #100 
        data = 1;
        #50 
        data = 0;
        #50 
        data = 1;
        #100
        $finish; /* $finish simulation after 100 time simulation units */
    end
endmodule

module testBenchD;
    wire clock, q, qbar, data;
    m555 clk(clock);
    Dlatch dl(q, qbar, clock, data);
    testD td(q, qbar, clock, data);
endmodule