//Alan Achtenberg
//Lab 7
//Part 1

module SRlatch (q, qbar, set, reset);
    output q, qbar;
    input set, reset;

    nor #1 (q, qbar, reset);
    nor #1 (qbar, q, set);
endmodule

module testSR(q, qbar, set, reset);
    input q, qbar;
    output set, reset;
    reg set, reset;

    initial begin
        $monitor ($time," q = %d, qbar = %d, set = %d, reset = %d",q, qbar, set, reset);
        set = 0; reset = 0;
        #100 
        set = 1; 
        #100 
        set = 0;		/* Set pulse at $time==100 */
        #100 
        reset = 1;
        #100 
        reset = 0;		/* Reset pulse */
        #100
        set = 1;
        #100 
        set = 0;		/* Set pulse again */
        #100 
        reset = 1;
        #100 
        reset = 0;		/* Reset pulse again */
        #100 
        $finish;		/* Finish simulation */
    end
endmodule

module testBench;
    wire q, qbar, set, reset;
    SRlatch l(q, qbar, set, reset);
    testSR t(q, qbar, set, reset);
endmodule