//Alan Achtenberg
//Lab 7
//Part 4

module DFF_PC(Q, Qbar, C, D, PREbar, CLRbar, Wen);
	input D, C, PREbar, CLRbar, Wen;
	output Q, Qbar;
	wire clock;
	wire databar, clockbar;
	wire master_nand1, master_nand2;
	wire nand1, nand2;
	wire master_q, master_qbar;
	and #1  (clock, Wen, C);
	not #1	(databar, D);
	not #1	(clockbar, clock);
	//Master
	nand #1 m1(master_nand1,clock, D);
	nand #1 m2(master_nand2,clock, databar);
	nand #1 m3(master_qbar,master_nand2,master_q, CLRbar); //Clear Master
	nand #1 m4(master_q,master_nand1,master_qbar, PREbar);//Clear Slave
	//Slave
	nand #1 s1(nand1,clockbar, master_q);
	nand #1 s2(nand2,clockbar, master_qbar);
	nand #1 s3(Qbar,nand2,Q, CLRbar);
	nand #1 s4(Q,nand1,Qbar, PREbar);
	
	
	
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

module testD(q, qbar, clock, data, PREbar, CLRbar, Wen);
    input  q, qbar, clock;
    output data, PREbar, CLRbar, Wen;
    reg    data, PREbar, CLRbar, Wen;

    initial begin
        $monitor ($time, " q = %d, qbar = %d, clock = %d, data = %d Wen = %d, PREbar=%d, CLRbar=%d", q, qbar,  clock, data, Wen,PREbar, CLRbar);
        data = 0; Wen = 1; PREbar = 1; CLRbar = 1;
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
        
        Wen = 0;
        
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
        
        Wen = 1;
        
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
        
        CLRbar = 0;
        
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
        
        CLRbar = 1;
        
        PREbar = 0;
        
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
        
        PREbar = 1;
        
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
	
        $finish;
    end
endmodule

module testBenchD;
    wire clock, q, qbar, data, PREbar, CLRbar, Wen;
    m555 clk(clock);
    DFF_PC dff(q, qbar, clock, data, PREbar, CLRbar, Wen);
    testD td(q, qbar, clock, data, PREbar, CLRbar, Wen);
endmodule
