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
	nand #1 s4(Q,nand1,Qbar,PREbar);
	
	
	
	endmodule

	module DFF32_PC(Q, Qbar, C, D, PREbar, CLRbar, Wen);
	input  [31:0] D;
	input  C, PREbar, CLRbar, Wen;
	output [31:0] Q, Qbar;
	
	DFF_PC r1(Q[0],Qbar[0],C,D[0],PREbar,CLRbar,Wen);
	DFF_PC r2(Q[1],Qbar[1],C,D[1],PREbar,CLRbar,Wen);
	DFF_PC r3(Q[2],Qbar[2],C,D[2],PREbar,CLRbar,Wen);
	DFF_PC r4(Q[3],Qbar[3],C,D[3],PREbar,CLRbar,Wen);
	DFF_PC r5(Q[4],Qbar[4],C,D[4],PREbar,CLRbar,Wen);
	DFF_PC r6(Q[5],Qbar[5],C,D[5],PREbar,CLRbar,Wen);
	DFF_PC r7(Q[6],Qbar[6],C,D[6],PREbar,CLRbar,Wen);
	DFF_PC r8(Q[7],Qbar[7],C,D[7],PREbar,CLRbar,Wen);
	DFF_PC r9(Q[8],Qbar[8],C,D[8],PREbar,CLRbar,Wen);
	DFF_PC r10(Q[9],Qbar[9],C,D[9],PREbar,CLRbar,Wen);
	DFF_PC r11(Q[10],Qbar[10],C,D[10],PREbar,CLRbar,Wen);
	DFF_PC r12(Q[11],Qbar[11],C,D[11],PREbar,CLRbar,Wen);
	DFF_PC r13(Q[12],Qbar[12],C,D[12],PREbar,CLRbar,Wen);
	DFF_PC r14(Q[13],Qbar[13],C,D[13],PREbar,CLRbar,Wen);
	DFF_PC r15(Q[14],Qbar[14],C,D[14],PREbar,CLRbar,Wen);
	DFF_PC r16(Q[15],Qbar[15],C,D[15],PREbar,CLRbar,Wen);
	DFF_PC r17(Q[16],Qbar[16],C,D[16],PREbar,CLRbar,Wen);
	DFF_PC r18(Q[17],Qbar[17],C,D[17],PREbar,CLRbar,Wen);
	DFF_PC r19(Q[18],Qbar[18],C,D[18],PREbar,CLRbar,Wen);
	DFF_PC r20(Q[19],Qbar[19],C,D[19],PREbar,CLRbar,Wen);
	DFF_PC r21(Q[20],Qbar[20],C,D[20],PREbar,CLRbar,Wen);
	DFF_PC r22(Q[21],Qbar[21],C,D[21],PREbar,CLRbar,Wen);
	DFF_PC r23(Q[22],Qbar[22],C,D[22],PREbar,CLRbar,Wen);
	DFF_PC r24(Q[23],Qbar[23],C,D[23],PREbar,CLRbar,Wen);
	DFF_PC r25(Q[24],Qbar[24],C,D[24],PREbar,CLRbar,Wen);
	DFF_PC r26(Q[25],Qbar[25],C,D[25],PREbar,CLRbar,Wen);
	DFF_PC r27(Q[26],Qbar[26],C,D[26],PREbar,CLRbar,Wen);
	DFF_PC r28(Q[27],Qbar[27],C,D[27],PREbar,CLRbar,Wen);
	DFF_PC r29(Q[28],Qbar[28],C,D[28],PREbar,CLRbar,Wen);
	DFF_PC r30(Q[29],Qbar[29],C,D[29],PREbar,CLRbar,Wen);
	DFF_PC r31(Q[30],Qbar[30],C,D[30],PREbar,CLRbar,Wen);
	DFF_PC r32(Q[31],Qbar[31],C,D[31],PREbar,CLRbar,Wen);
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

module testD32(q, qbar, clock, data, PREbar, CLRbar, Wen);
    input  clock;
    input  [31:0] q, qbar;
    output PREbar, CLRbar, Wen;
    output [31:0] data;
    reg    PREbar, CLRbar, Wen;
    reg    [31:0] data;

    initial begin
        $monitor ($time, " q = %d, qbar = %d, clock = %d, data = %d Wen = %d", q, qbar,  clock, data, Wen);
        data = 0; Wen = 1; PREbar = 1; CLRbar = 1;
        #25  
        data = -1;
        #100 
        
        data = 1815681630;
        #50 
        data = 4168106685;
        #50 
        data = 1815681630;
        #100 
        data = 4168106685;
        #50 
        data = 1815681630;
        #50 
        data = 4168106685;
        #100
        
        Wen = 0;
        
        data = 1815681630;
        #50 
        data = 4168106685;
        #50 
        data = 1815681630;
        #100 
        data = 4168106685;
        #50 
        data = 1815681630;
        #50 
        data = 4168106685;
        #100
        
        Wen = 1;
        
        data = 4089469290;
        #50 
        data = 2336693550;
        #50 
        data = 4089469290;
        #100 
        data = 2336693550;
        #50 
        data = 4089469290;
        #50 
        data = 2336693550;
        #100
        
        CLRbar = 0;
        
        data = 1815681630;
        #50 
        data = 4168106685;
        #50 
        data = 1815681630;
        #100 
        data = 4168106685;
        #50 
        data = 1815681630;
        #50 
        data = 4168106685;
        #100
        
        CLRbar = 1;
        
        PREbar = 0;
        
        data = 1815681630;
        #50 
        data = 4168106685;
        #50 
        data = 1815681630;
        #100 
        data = 4168106685;
        #50 
        data = 1815681630;
        #50 
        data = 4168106685;
        #100
        
        PREbar = 1;
        
        data = 1815681630;
        #50 
        data = 4168106685;
        #50 
        data = 1815681630;
        #100 
        data = 4168106685;
        #50 
        data = 1815681630;
        #50 
        data = 4168106685;
        #100
        
        $finish; 
    end
endmodule

module testBenchD;
    wire clock, PREbar, CLRbar, Wen;
    wire [31:0] data, q, qbar;
    
    m555 clk(clock);
    DFF32_PC dff(q, qbar, clock, data, PREbar, CLRbar, Wen);
    testD32 td(q, qbar, clock, data, PREbar, CLRbar, Wen);
endmodule