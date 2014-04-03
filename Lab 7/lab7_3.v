//Alan Achtenberg
//Lab 7
//Part 3

module DFF (q,qbar,clock,data);
	output q, qbar;
	input clock, data;
	
	wire databar, clockbar;
	wire master_nand1, master_nand2;
	wire nand1, nand2;
	wire master_q, master_qbar;
	
	
	not #1	(databar, data);
	not #1		(clockbar, clock);
	//Master
	nand #1 m1(master_nand1,clock, data);
	nand #1 m2(master_nand2,clock, databar);
	nand #1 m3(master_qbar,master_nand2,master_q);
	nand #1 m4(master_q,master_nand1,master_qbar);
	//Slave
	nand #1 s1(nand1,clockbar, master_q);
	nand #1 s2(nand2,clockbar, master_qbar);
	nand #1 s3(qbar,nand2,q);
	nand #1 s4(q,nand1,qbar);
	
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
    DFF dff(q, qbar, clock, data);
    testD td(q, qbar, clock, data);
endmodule